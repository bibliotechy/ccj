import { existsSync, promises as fs } from 'node:fs';
import { execFileSync } from 'node:child_process';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const rootDir = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const configuredDbPath = process.env.CATALOG_DB_PATH
  ? path.resolve(rootDir, process.env.CATALOG_DB_PATH)
  : undefined;
const prodDbPath = [
  configuredDbPath,
  path.join(rootDir, 'database', 'prod.db'),
  path.join(rootDir, 'db', 'prod.db'),
  path.join(rootDir, 'db', 'public.db'),
].find((candidate) => existsSync(candidate));
const recordsOut = path.join(rootDir, 'src', 'data', 'records.json');
const artistsOut = path.join(rootDir, 'src', 'data', 'artists.json');
const searchOut = path.join(rootDir, 'public', 'search-index.json');
const artistContextOut = path.join(rootDir, 'public', 'artist-context.json');
const publicArtistImagesDir = path.join(rootDir, 'public', 'images', 'artists');

const publicFacetFields = [
  'artists',
  'decades',
  'collections',
  'mediaFormats',
  'mediaTypes',
  'componentTypes',
  'viewingRestrictions',
];

function cleanCell(value) {
  const cleaned = String(value ?? '')
    .replace(/^\uFEFF/, '')
    .replace(/\u00a0/g, ' ')
    .trim();
  return cleaned.length ? cleaned : undefined;
}

function cleanText(value) {
  return cleanCell(value)?.replace(/\r\n/g, '\n').replace(/[ \t]+\n/g, '\n');
}

function compact(values) {
  return values.map(cleanCell).filter(Boolean);
}

function uniq(values) {
  const seen = new Set();
  return compact(values).filter((value) => {
    const key = value.toLocaleLowerCase();
    if (seen.has(key)) {
      return false;
    }
    seen.add(key);
    return true;
  });
}

function displayPair(en, jp) {
  return compact([en, jp]).join(' / ');
}

function extractYear(value) {
  const match = String(value ?? '').match(/\d{4}/);
  return match ? Number(match[0]) : undefined;
}

function decadeFor(value) {
  const year = extractYear(value);
  if (!year) {
    return undefined;
  }
  return `${Math.floor(year / 10) * 10}s`;
}

function videoIdFromUrl(videoUrl) {
  if (!videoUrl) {
    return undefined;
  }
  const match = String(videoUrl).match(/vimeo\.com\/(?:video\/)?(\d+)/);
  return match ? match[1] : undefined;
}

function searchableText(parts) {
  return compact(parts)
    .join(' ')
    .replace(/\s+/g, ' ')
    .toLocaleLowerCase();
}

function slugBase(value) {
  return String(value ?? 'record')
    .normalize('NFKC')
    .trim()
    .replace(/[\s/\\?#]+/g, '-')
    .replace(/[^\p{Letter}\p{Number}._-]+/gu, '-')
    .replace(/-+/g, '-')
    .replace(/^-|-$/g, '') || 'record';
}

function assignRecordSlugs(records) {
  const seen = new Map();
  for (const record of records) {
    const base = slugBase(record.id);
    const count = seen.get(base) ?? 0;
    seen.set(base, count + 1);
    record.slug = count === 0 ? base : `${base}-${count + 1}`;
    record.url = `/catalog/${encodeURIComponent(record.slug)}/`;
  }
}

function readSqliteJson(sql) {
  if (!prodDbPath) {
    throw new Error('Could not find production database at CATALOG_DB_PATH, database/prod.db, db/prod.db, or db/public.db.');
  }

  const output = execFileSync('sqlite3', ['-json', prodDbPath, sql], {
    cwd: rootDir,
    encoding: 'utf8',
    maxBuffer: 50 * 1024 * 1024,
  });
  return JSON.parse(output || '[]');
}

function recordArtist(row) {
  const id = String(row.id);
  const nameEn = cleanText(row.nameEn);
  const nameJp = cleanText(row.nameJp);

  return {
    id,
    nameEn,
    nameJp,
    name: displayPair(nameEn, nameJp) || `Artist ${id}`,
    dbId: id,
    url: `/artists/${id}/`,
  };
}

function titleFromRow(row, fallback) {
  const en = cleanText(row.titleEn);
  const jp = cleanText(row.titleJp);
  return {
    en,
    jp,
    display: displayPair(en, jp) || fallback,
  };
}

function buildWorkArtistIds(works, componentArtistIds) {
  const artistIdsByWork = new Map();

  for (const work of works) {
    const workId = String(work.dbId);
    if (!artistIdsByWork.has(workId)) {
      artistIdsByWork.set(workId, []);
    }
    if (work.artistId) {
      artistIdsByWork.get(workId).push(String(work.artistId));
    }
  }

  const componentWorks = readSqliteJson(`
    select
      c.id as componentId,
      c.work_id as workId
    from components c
    order by c.work_id, c.id
  `);

  for (const component of componentWorks) {
    const workId = String(component.workId);
    const artists = componentArtistIds.get(String(component.componentId)) ?? [];
    if (!artistIdsByWork.has(workId)) {
      artistIdsByWork.set(workId, []);
    }
    artistIdsByWork.set(workId, uniq([...artistIdsByWork.get(workId), ...artists]));
  }

  return artistIdsByWork;
}

function buildComponentArtistIds() {
  const rows = readSqliteJson(`
    select
      component_id as componentId,
      artist_id as artistId
    from artists_components
    order by component_id, artist_id
  `);
  const byComponent = new Map();

  for (const row of rows) {
    const componentId = String(row.componentId);
    if (!byComponent.has(componentId)) {
      byComponent.set(componentId, []);
    }
    byComponent.get(componentId).push(String(row.artistId));
  }

  for (const [componentId, artistIds] of byComponent) {
    byComponent.set(componentId, uniq(artistIds));
  }

  return byComponent;
}

function buildRecords(artistsById) {
  const dbWorks = readSqliteJson(`
    select
      id as dbId,
      local_id as localId,
      title_en as titleEn,
      title_jp as titleJp,
      description_en as descriptionEn,
      description_jp as descriptionJp,
      video_url as videoUrl,
      creation_date as creationDate,
      color,
      sound,
      run_time as runTime,
      format,
      artist_id as artistId
    from works
    order by title_en collate nocase, title_jp collate nocase, local_id collate nocase, id
  `);

  const componentArtistIds = buildComponentArtistIds();
  const workArtistIds = buildWorkArtistIds(dbWorks, componentArtistIds);
  const works = new Map();

  for (const row of dbWorks) {
    const id = cleanText(row.localId) || String(row.dbId);
    const title = titleFromRow(row, id);
    works.set(String(row.dbId), {
      dbId: String(row.dbId),
      id,
      localId: id,
      title,
      description: {
        en: cleanText(row.descriptionEn),
        jp: cleanText(row.descriptionJp),
      },
      videoUrl: cleanText(row.videoUrl),
      videoId: videoIdFromUrl(row.videoUrl),
      creationDate: cleanText(row.creationDate),
      color: cleanText(row.color),
      sound: cleanText(row.sound),
      runTime: cleanText(row.runTime),
      format: cleanText(row.format),
      artistIds: workArtistIds.get(String(row.dbId)) ?? [],
      components: [],
    });
  }

  const dbComponents = readSqliteJson(`
    select
      c.id as dbId,
      c.audio_reel_capacity as audioReelCapacity,
      c.audio_reel_size as audioReelSize,
      c.audio_speed as audioSpeed,
      c.bit_depth as bitDepth,
      c.bit_rate as bitRate,
      c.cataloger,
      c.color,
      c.component_type as componentType,
      c.contributors_en as contributorsEn,
      c.contributors_jp as contributorsJp,
      c.creation_date as creationDate,
      c.date_of_entry as dateOfEntry,
      c.dimensions,
      c.display_aspect_ratio as displayAspectRatio,
      c.duration,
      c.encoded_date as encodedDate,
      c.file_name as fileName,
      c.file_size_gb as fileSizeGb,
      c.film_element as filmElement,
      c.film_process_type as filmProcessType,
      c.film_wind as filmWind,
      c.fps,
      c.identifier,
      c.local_identifer as localIdentifier,
      c.media_format as mediaFormat,
      c.media_type as mediaType,
      c.name,
      c.previous_ids as previousIds,
      c.relation,
      c.run_time as runTime,
      c.scan_type as scanType,
      c.sound,
      c.video_standard as videoStandard,
      c.video_stock_length as videoStockLength,
      c.codecs,
      c.condition_notes as conditionNotes,
      c.description_en as descriptionEn,
      c.description_jp as descriptionJp,
      c.housing_annotations as housingAnnotations,
      c.item_annotations as itemAnnotations,
      c.provenance,
      c.notes,
      c.terms_governing_use as termsGoverningUse,
      c.viewing_restrictions as viewingRestrictions,
      c.recording_date as recordingDate,
      c.work_id as workDbId,
      w.local_id as workLocalId,
      co.name_en as collectionNameEn,
      co.name_jp as collectionNameJp
    from components c
    inner join works w on w.id = c.work_id
    left join collections co on co.id = c.collection_id
    order by c.work_id, c.id
  `);

  for (const row of dbComponents) {
    const work = works.get(String(row.workDbId));
    if (!work) {
      continue;
    }

    const componentId =
      cleanText(row.localIdentifier) ||
      cleanText(row.identifier) ||
      String(row.dbId);
    const collection =
      cleanText(row.collectionNameEn) ||
      cleanText(row.collectionNameJp) ||
      'Unknown Collection';

    work.components.push({
      id: componentId,
      workId: cleanText(row.workLocalId) || work.localId,
      previousIds: cleanText(row.previousIds),
      titleEn: cleanText(row.name),
      titleJp: undefined,
      descriptionEn: cleanText(row.descriptionEn),
      descriptionJp: cleanText(row.descriptionJp),
      contributorsEn: cleanText(row.contributorsEn),
      contributorsJp: cleanText(row.contributorsJp),
      collection,
      recordingDate: cleanText(row.recordingDate),
      creationDate: cleanText(row.creationDate),
      color: cleanText(row.color),
      sound: cleanText(row.sound),
      runTime: cleanText(row.runTime),
      mediaType: cleanText(row.mediaType),
      mediaFormat: cleanText(row.mediaFormat),
      componentType: cleanText(row.componentType),
      relation: cleanText(row.relation),
      filmProcessType: cleanText(row.filmProcessType),
      filmElement: cleanText(row.filmElement),
      filmWind: cleanText(row.filmWind),
      fps: cleanText(row.fps),
      audioSpeed: cleanText(row.audioSpeed),
      audioReelSize: cleanText(row.audioReelSize),
      audioReelCapacity: cleanText(row.audioReelCapacity),
      videoStockLength: cleanText(row.videoStockLength),
      videoStandard: cleanText(row.videoStandard),
      fileName: cleanText(row.fileName),
      codecs: cleanText(row.codecs),
      fileSizeGb: cleanText(row.fileSizeGb),
      duration: cleanText(row.duration),
      bitRate: cleanText(row.bitRate),
      dimensions: cleanText(row.dimensions),
      displayAspectRatio: cleanText(row.displayAspectRatio),
      bitDepth: cleanText(row.bitDepth),
      scanType: cleanText(row.scanType),
      encodedDate: cleanText(row.encodedDate),
      provenance: cleanText(row.provenance),
      viewingRestrictions: cleanText(row.viewingRestrictions),
      termsGoverningUse: cleanText(row.termsGoverningUse),
      housingAnnotations: cleanText(row.housingAnnotations),
      itemAnnotations: cleanText(row.itemAnnotations),
      conditionNotes: cleanText(row.conditionNotes),
      notes: cleanText(row.notes),
      dateOfEntry: cleanText(row.dateOfEntry),
      cataloger: cleanText(row.cataloger),
      artistIds: componentArtistIds.get(String(row.dbId)) ?? [],
    });
  }

  const records = [...works.values()]
    .map((work) => finalizeRecord(work, artistsById))
    .sort((a, b) => a.sort.title.localeCompare(b.sort.title));
  assignRecordSlugs(records);

  return { records, dbWorks, workArtistIds };
}

function finalizeRecord(work, artistsById) {
  const artistIds = uniq([
    ...work.artistIds,
    ...work.components.flatMap((component) => component.artistIds),
  ]);
  const artists = artistIds.map((id) => artistsById.get(String(id))).filter(Boolean);
  const creationDates = uniq([
    work.creationDate,
    ...work.components.map((component) => component.creationDate),
    ...work.components.map((component) => component.recordingDate),
  ]);
  const colors = uniq([work.color, ...work.components.map((component) => component.color)]);
  const sounds = uniq([work.sound, ...work.components.map((component) => component.sound)]);
  const runTimes = uniq([work.runTime, ...work.components.map((component) => component.runTime)]);
  const mediaFormats = uniq([
    work.format,
    ...work.components.map((component) => component.mediaFormat),
  ]);
  const mediaTypes = uniq(work.components.map((component) => component.mediaType));
  const collections = uniq(work.components.map((component) => component.collection));
  const componentTypes = uniq(work.components.map((component) => component.componentType));
  const viewingRestrictions = uniq(
    work.components.map((component) => component.viewingRestrictions),
  );
  const decades = uniq(creationDates.map(decadeFor));
  const sortYear = extractYear(work.creationDate) ?? extractYear(creationDates[0]) ?? 0;
  const details = uniq([...colors, ...sounds, ...runTimes, ...mediaFormats]).join(', ');
  const publicComponents = work.components.map(({ artistIds: _artistIds, ...component }) => component);

  return {
    id: work.id,
    localId: work.localId,
    slug: work.id,
    url: `/catalog/${encodeURIComponent(work.id)}/`,
    title: work.title,
    description: work.description,
    videoUrl: work.videoUrl,
    videoId: work.videoId,
    creationDate: work.creationDate,
    color: work.color,
    sound: work.sound,
    runTime: work.runTime,
    format: work.format,
    colors,
    sounds,
    runTimes,
    mediaFormats,
    mediaTypes,
    collections,
    artists,
    components: publicComponents,
    componentCount: publicComponents.length,
    facets: {
      artists: artists.map((artist) => artist.name),
      decades,
      collections,
      mediaFormats,
      mediaTypes,
      componentTypes,
      viewingRestrictions,
    },
    details,
    sort: {
      title: work.title.display.toLocaleLowerCase(),
      year: sortYear,
    },
    searchText: searchableText([
      work.id,
      work.title.en,
      work.title.jp,
      work.description.en,
      work.description.jp,
      work.creationDate,
      details,
      ...artists.flatMap((artist) => [artist.name, artist.nameEn, artist.nameJp]),
      ...publicComponents.flatMap((component) => [
        component.id,
        component.previousIds,
        component.titleEn,
        component.titleJp,
        component.descriptionEn,
        component.descriptionJp,
        component.contributorsEn,
        component.contributorsJp,
        component.collection,
        component.mediaType,
        component.mediaFormat,
        component.componentType,
        component.relation,
        component.filmProcessType,
        component.viewingRestrictions,
        component.notes,
      ]),
    ]),
  };
}

async function buildArtists(records, dbArtists, dbWorks, workArtistIds) {
  const imageFiles = new Set();
  try {
    for (const fileName of await fs.readdir(publicArtistImagesDir)) {
      imageFiles.add(fileName);
    }
  } catch {
    // Artist portraits are optional; pages render without an image when absent.
  }

  const recordByLocalId = new Map(records.map((record) => [record.localId, record]));
  const worksByArtist = new Map();

  for (const work of dbWorks) {
    const localId = cleanText(work.localId) || String(work.dbId);
    const artistIds = workArtistIds.get(String(work.dbId)) ?? [];
    for (const artistId of artistIds) {
      const item = {
        id: work.dbId,
        localId,
        title: titleFromRow(work, localId),
        creationDate: cleanText(work.creationDate),
        url: recordByLocalId.get(localId)?.url,
      };
      if (!worksByArtist.has(artistId)) {
        worksByArtist.set(artistId, []);
      }
      if (!worksByArtist.get(artistId).some((existing) => existing.id === item.id)) {
        worksByArtist.get(artistId).push(item);
      }
    }
  }

  for (const works of worksByArtist.values()) {
    works.sort((a, b) =>
      a.title.display.localeCompare(b.title.display) ||
      String(a.localId).localeCompare(String(b.localId)),
    );
  }

  return dbArtists.map((artist) => {
    const imageFilename = cleanText(artist.imageFilename);
    const imageUrl = imageFilename && imageFiles.has(imageFilename)
      ? `/images/artists/${encodeURIComponent(imageFilename)}`
      : undefined;
    const id = String(artist.id);
    const nameEn = cleanText(artist.nameEn);
    const nameJp = cleanText(artist.nameJp);

    return {
      id,
      url: `/artists/${id}/`,
      name: {
        en: nameEn,
        jp: nameJp,
        display: displayPair(nameEn, nameJp) || `Artist ${id}`,
      },
      description: {
        en: cleanText(artist.descriptionEn),
        jp: cleanText(artist.descriptionJp),
      },
      localIdentifier: cleanText(artist.localIdentifier),
      viafIdentifier: cleanText(artist.viafIdentifier),
      externalLink: cleanText(artist.externalLink),
      image: imageUrl ? { filename: imageFilename, url: imageUrl } : undefined,
      works: worksByArtist.get(id) ?? [],
    };
  });
}

async function main() {
  const dbArtists = readSqliteJson(`
    select
      a.id,
      a.name_en as nameEn,
      a.name_jp as nameJp,
      a.local_identifier as localIdentifier,
      a.viaf_identifier as viafIdentifier,
      a.external_link as externalLink,
      a.description_en as descriptionEn,
      a.description_jp as descriptionJp,
      b.filename as imageFilename
    from artists a
    left join active_storage_attachments att
      on att.record_type = 'Artist'
      and att.record_id = a.id
      and att.name = 'image'
    left join active_storage_blobs b
      on b.id = att.blob_id
    order by a.name_en collate nocase, a.name_jp collate nocase, a.id
  `);

  const artistsById = new Map(dbArtists.map((artist) => [String(artist.id), recordArtist(artist)]));
  const { records, dbWorks, workArtistIds } = buildRecords(artistsById);
  const artists = await buildArtists(records, dbArtists, dbWorks, workArtistIds);

  const searchIndex = records.map((record) => ({
    id: record.id,
    url: record.url,
    title: record.title.display,
    titleEn: record.title.en,
    titleJp: record.title.jp,
    localId: record.localId,
    artists: record.artists.map((artist) => artist.name),
    artistLinks: record.artists.map((artist) => ({
      name: artist.name,
      url: artist.url,
    })),
    creationDate: record.creationDate,
    details: record.details,
    componentCount: record.componentCount,
    description: record.description.en || record.description.jp,
    facets: Object.fromEntries(
      publicFacetFields.map((field) => [field, record.facets[field] ?? []]),
    ),
    sortTitle: record.sort.title,
    sortYear: record.sort.year,
    searchText: record.searchText,
  }));

  const artistContextIndex = artists.map((artist) => ({
    id: artist.id,
    url: artist.url,
    name: artist.name,
    description: artist.description,
  }));

  await fs.mkdir(path.dirname(recordsOut), { recursive: true });
  await fs.mkdir(path.dirname(searchOut), { recursive: true });
  await fs.writeFile(recordsOut, `${JSON.stringify(records, null, 2)}\n`);
  await fs.writeFile(artistsOut, `${JSON.stringify(artists, null, 2)}\n`);
  await fs.writeFile(searchOut, `${JSON.stringify(searchIndex)}\n`);
  await fs.writeFile(artistContextOut, `${JSON.stringify(artistContextIndex)}\n`);

  const componentCount = records.reduce((total, record) => total + record.componentCount, 0);
  const dbPath = path.relative(rootDir, prodDbPath);
  console.log(`Read ${dbPath}. Generated ${records.length} works, ${componentCount} components, and ${artists.length} artists.`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

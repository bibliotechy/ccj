require 'csv'
class Upload < ApplicationRecord
  mount_uploader :file, ImportUploader

  def process_upload
    record_count = 0
    open(file.current_path, "rb") do |f|
      CSV.foreach(f, headers: true).each do |row|
        if is_a_work?(row)
          work_from_row(row)
          record_count += 1
        elsif is_a_component?(row)
          component_from_row(row)
          record_count += 1
        else
          # some else clause goes here
          # currently, as real as Santa Clause

        end
      end
      records_upserted = record_count
      was_ingested = true
    end
  end

  def component_from_row(row)
    Component.find_or_create_by(local_identifer: row["Component ID"]) do |c|
      # Assumes work already exists. Very assy of me
      c.work = Work.where(local_id: row["ID"]).first_or_create do |work|
        work.title_en = row["Title (EN)"]
        work.title_jp = row["Title (JP)"]
        work.description_en = row["Description (EN)"]
        work.description_jp = row["Description (JP)"]
      end

      if has_artist_name?(row)
        c.artists << add_component_artist(row)
      end

      c.description_en = row['Description (EN)']
      c.description_jp = row['Description (JP)']
      c.contributors_en = row['Contributors (EN)']
      c.contributors_jp = row['Contributors (JP)']
      c.creation_date = row['Creation Date ']
      c.color = row['Color']
      c.sound = row['Sound']
      c.run_time = row['Run time (HH:MM:SS)']
      c.collection = row['Collection']
      c.media_type = row['Media Type']
      c.media_format = row['Media Format']
      c.component_type = row['Component Type']
      c.relation = row['Relation']
      c.film_print_type = row['Film Print Type ']
      c.fps = row['FPS']
      c.brand = row['Brand']
      c.file_name = row['File Name']
      c.codec = row['Codec']
      c.codec_id = row['Codec ID']
      c.file_size_gb = row['File Size (GB)']
      c.duration = row['Duration']
      c.bit_rate = row['Bit Rate']
      c.dimensions = row['Dimensions']
      c.display_aspect_ratio = row['Display Aspect Ratio']
      c.bit_depth = row['Bit Depth']
      c.scan_type = row['Scan Type']
      c.encoded_date = row['Encoded Date']
      c.provenance = row['Provenance']
      c.viewing_restrictions = row['Viewing Restrictions']
      c.terms_governing_use = row['Terms of Governing Use']
      c.housing_annotations = row['Housing Annotations ']
      c.item_annotations = row['Item Annotations\xE3\x80\x80 ']
      c.condition_notes = row['Condition Notes ']
      c.notes = row['Notes']
      c.date_of_entry = row['Date of Entry (MM-DD-YYYY)']
      c.cataloger = row['Cataloger']
    end
  end


  def add_component_artist(row)
    artist = Artist.find_or_create_by(name_en: row["Artist name (EN)"]) do |a|
      a.name_jp = row["Artist name (JP)"]
    end
  end
  def has_artist_name?(row)
    !row["Artist name (JP)"].nil? or !row["Artist name (EN)"].nil?
  end

  def work_from_row(row)
    Work.find_or_create_by(local_id: row["ID"]) do |work|
      work.title_en = row["Title (EN)"]
      work.title_jp = row["Title (JP)"]
      work.description_en = row["Description (EN)"]
      work.description_jp = row["Description (JP)"]
    end
  end

  def is_a_component?(row)
    !is_a_work?(row)
  end

  def is_a_work?(row)
    (row["Component ID"].nil?) || (row["Component ID"] == "(Work Record)")
  end
end

require 'csv'
class Upload < ApplicationRecord
  mount_uploader :file, ImportUploader


  def process_upload(upload_file_path = nil)
    upload_file_path ||= file.current_path
    record_count = 0
    open(upload_file_path, "rb") do |f|

      # Clean line breaks not preceded by a carriage return
      cleaned = f.read.force_encoding('UTF-8').gsub(/(?<!\r)\n/,"")
      CSV.parse(cleaned,
        headers: true,
        converters: ->(v) {v ? v.strip : nil},
	header_converters: -> (h) {h.strip.downcase}
      )
      .each_with_index do |row, index|
        unless row.fetch("id", nil)
          puts "Row #{index} did not have an ID, and was not ingested"
          next
        end
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
      self.records_upserted = record_count
      self.was_ingested = true
      save
    end
  end

  def component_from_row(row)

    Component.find_or_create_by!(local_identifer: row["component id"]) do |c|
      # Assumes work already exists. Very assy of me
      c.work = Work.find_or_create_by(local_id: row["id"]) do |work|
        work.title_en = row["title (en)"]
        work.title_jp = row["title (jp)"]
        work.description_en = row["description (en)"]
        work.description_jp = row["description (jp)"]
      end

      if has_artist_name?(row)
        artist = add_component_artist(row)
        c.artists << artist unless c.artists.include? artist
      end

      c.collection = add_component_collection(row)



      c.description_en = row['description (en)']
      c.description_jp = row['description (jp)']
      c.contributors_en = row['contributors (en)']
      c.contributors_jp = row['contributors (jp)']
      c.creation_date = row['creation date']
      c.color = row['color']
      c.sound = row['sound']
      c.run_time = row['run time (hh:mm:ss)']
      c.media_type = row['media type']
      c.media_format = row['media format']
      c.component_type = row['component type']
      c.relation = row['relation']
      c.film_process_type = row['film process type']
      c.fps = row['fps']
      c.film_wind = row['film wind']
      c.brand = row['brand']
      c.audio_speed = row['audio speed']
      c.audio_reel_size = row['audio reel size']
      c.audio_reel_capacity = row['audio reel capacity']
      c.video_stock_length = row['video stock length']
      c.video_standard = row['video standard']
      c.file_name = row['file name']
      c.codecs = (row['codecs'] || row['codec'])
      c.file_size_gb = row['file size (gb)']
      c.duration = row['duration']
      c.bit_rate = row['bit rate']
      c.dimensions = row['dimensions']
      c.display_aspect_ratio = row['display aspect ratio']
      c.bit_depth = row['bit depth']
      c.scan_type = row['scan type']
      c.encoded_date = row['encoded date']
      c.provenance = row['provenance']
      c.viewing_restrictions = row['viewing restrictions']
      c.terms_governing_use = row['terms of governing use']
      c.housing_annotations = row['housing annotations']
      c.item_annotations = row['item annotations']
      c.condition_notes = row['condition notes']
      c.notes = row['notes']
      c.date_of_entry = row['date of entry (mm-dd-yyyy)']
      c.cataloger = row['cataloger']
      c.recording_date = row['recording date']

      # deprecated, but here for backwards compatability
      c.film_process_type = row['film print type']

    end.save!
  end

  def add_component_artist(row)
    Artist.find_or_create_by(name_jp: row["artist name (jp)"]) do |a|
      a.name_en = row["artist name (en)"]
    end
  end

  def add_component_collection(row)
    Collection.find_or_create_by(name_en: (row["collection"]|| "Unknown Collection"))
  end

  def has_artist_name?(row)
    !row["artist name (jp)"].nil? or !row["artist name (en)"].nil?
  end

  def has_collection?(row)
    !row["collection"].nil?
  end

  def work_from_row(row)
    Work.find_or_create_by(local_id: row["id"]) do |work|
      work.title_en = row["title (en)"]
      work.title_jp = row["title (jp)"]
      work.description_en = row["description (en)"]
      work.description_jp = row["description (jp)"]
    end
  end

  def is_a_component?(row)
    !is_a_work?(row)
  end

  def is_a_work?(row)
    (row["component id"].nil?) || (row["domponent id"] == "(Work Record)")
  end
end

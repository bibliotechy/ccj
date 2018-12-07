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
        header_converters: -> (h) {h.strip}
      )
      .each_with_index do |row, index|
        unless row.fetch("ID", nil)
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

    Component.find_or_create_by!(local_identifer: row["Component ID"]) do |c|
      # Assumes work already exists. Very assy of me
      c.work = Work.find_or_create_by(local_id: row["ID"]) do |work|
        work.title_en = row["Title (EN)"]
        work.title_jp = row["Title (JP)"]
        work.description_en = row["Description (EN)"]
        work.description_jp = row["Description (JP)"]
      end

      if has_artist_name?(row)
        artist = add_component_artist(row)
        c.artists << artist unless c.artists.include? artist
      end

      c.collection = add_component_collection(row)



      c.description_en = row['Description (EN)']
      c.description_jp = row['Description (JP)']
      c.contributors_en = row['Contributors (EN)']
      c.contributors_jp = row['Contributors (JP)']
      c.creation_date = row['Creation Date']
      c.color = row['Color']
      c.sound = row['Sound']
      c.run_time = row['Run time (HH:MM:SS)']
      c.media_type = row['Media Type']
      c.media_format = row['Media Format']
      c.component_type = row['Component Type']
      c.relation = row['Relation']
      c.film_process_type = row['Film Process Type']
      c.fps = row['FPS']
      c.film_wind = row['Film Wind']
      c.brand = row['Brand']
      c.audio_speed = row['Audio Speed']
      c.audio_reel_size = row['Audio Reel Size']
      c.audio_reel_capacity = row['Audio Reel Capacity']
      c.video_stock_length = row['Video Stock Length']
      c.video_standard = row['Video Standard']
      c.file_name = row['File Name']
      c.codecs = (row['Codecs'] || row['Codec'])
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
      c.housing_annotations = row['Housing Annotations']
      c.item_annotations = row['Item Annotations']
      c.condition_notes = row['Condition Notes']
      c.notes = row['Notes']
      c.date_of_entry = row['Date of Entry (MM-DD-YYYY)']
      c.cataloger = row['Cataloger']

      # deprecated, but here for backwards compatability
      c.film_process_type = row['Film Print Type']

    end.save!
  end

  def add_component_artist(row)
    Artist.find_or_create_by(name_en: row["Artist name (EN)"]) do |a|
      a.name_jp = row["Artist name (JP)"]
    end
  end

  def add_component_collection(row)
    Collection.find_or_create_by(name_en: (row["Collection"]|| "Unknown Collection"))
  end

  def has_artist_name?(row)
    !row["Artist name (JP)"].nil? or !row["Artist name (EN)"].nil?
  end

  def has_collection?(row)
    !row["Collection"].nil?
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

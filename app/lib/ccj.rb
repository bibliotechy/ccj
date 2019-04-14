module Ccj


  def self.clean_and_parse_sheet(opened_file)
    CSV.parse(
      opened_file.
        read.
        force_encoding('UTF-8').
        gsub(/(?<!\r)\n/,""),
      headers: true,
      converters: ->(v) {v ? v.strip : nil},
      header_converters: -> (h) {h.strip.downcase}
    )
  end

  def self.has_expected_headers?(sheet:, type: )
    self.expected_headers[type].all? do |header|
       sheet.headers.include?(header)
    end
  end

  def self.missing_header(sheet:, type: )
    self.expected_headers[type].each do |header|
      raise Exception.new("Header #{header} was not present in this sheet") unless sheet.headers.include?(header)
    end
  end

  def self.is_work_level_sheet?(sheet)
    self.has_expected_headers?(sheet: sheet, type: "work")
  end

  def self.is_component_level_sheet?(sheet)
    self.has_expected_headers?(sheet: sheet, type: "component")
  end

  def self.expected_headers
    {
     "work" => [
        "id", "title (en)", "title (jp)", "artist name (en)",
        "artist name (jp)", "description (en)", "description (jp)",
        "video url", "creation date", "color", "sound",
        "run time (hh:mm:ss)", "format",
      ],
      "component" => []
    }
  end
end

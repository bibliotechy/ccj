# frozen_string_literal: true

require 'csv'

namespace :verify do

  desc "Verify work spreadsheet headers"
  task :headers, [:file, :type] => :environment do |t, args|
    args.with_defaults(type: "work" )
    open(args[:file], "rb") do |f|
    # Clean line breaks not preceded by a carriage return
    sheet = Ccj.clean_and_parse_sheet(f)
    unless Ccj.has_expected_headers?(sheet: sheet, type: args[:type])
      Ccj.missing_header(sheet: sheet, type: args[:type])
      
    end
   end
  end

  desc "Verify Components spreadsheet headers"
  task :component_headers => :environment do
  end
end

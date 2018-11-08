# frozen_string_literal: true

desc "Upload a file of data"
task :upload, [:file] => :environment do |t, args|
    args.with_defaults(file: Rails.root.join("sampledata/sample.csv") )
    uploader = Upload.new
    uploader.process_upload(args[:file])
end

desc "Clear out data"
task :clean => :environment do
  Artist.all.each(&:destroy)
  Component.all.each(&:destroy)
  Work.all.each(&:destroy)
  SolrDocument.repository.search["response"]["docs"].each {|doc| SolrService.delete(doc['id'])}
end

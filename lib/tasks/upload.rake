# frozen_string_literal: true

desc "Upload a file of data"
task :upload, [:file] => :environment do |t, args|
    args.with_defaults(file: Rails.root.join("sampledata/sample.csv") )
    uploader = Upload.new
    uploader.process_upload(args[:file])
end

desc "Upload sample data"
task :upload_sample => :environment do
  [
    "WorkLevel_CCJ_Iimura_Survey - 170227(1).csv",
    "WorkLevel_CCJ_Nakajima_Survey_LD - Simplified Headers Data_2018_CC.csv",
    "WorkLevel_CCJ_Tanaami_Survey - Template.csv",
    "WorkLevel_Jonouchi_Fukuoka - CCJ_Iimura_Survey_20190319_LD x.csv",
    "WorkLevel_Oe - 170227.csv",
    "WorkLevel_TOP_Museum_LD - Template.csv"
  ].each {|w| Upload.new.process_upload("sampledata/#{w}")}
 [
    "Components_CCJ_Iimura_Survey_20190405 - CCJ_Iimura_Survey_20190319_LD x.csv",
    "Components_CCJ_Nakajima_Survey_20190325 - Simplified Headers Data_2018_CC.csv",
    "Components_CCJ_Tanaami_20190328.xlsm - Template.csv",
    "Components_Jonouchi_Fukuoka_20190326 - CCJ_Iimura_Survey_20190319_LD x.csv",
    "Components_Oe_20190401 - 170227.csv",
    "Components_TOP_Museum_20190325 - TOP_Museum xlsm xlsx.csv"
  ].each {|c| Upload.new.process_upload("sampledata/#{c}")}
  ::SolrService.commit

end


desc "Reindex all Works"
task :reindex => :environment do
  Work.reindex_all
end


desc "Clear out data"
task :clean => :environment do
  Artist.all.each(&:destroy)
  Component.all.each(&:destroy)
  Work.all.each(&:destroy)
  SolrDocument.repository.search(limit: 100)["response"]["docs"].each {|doc| ::SolrService.delete(doc['id'])}
end


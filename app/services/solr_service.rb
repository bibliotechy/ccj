module SolrService
  def self.add(json)
    connection.add(json, add_attributes: {:commitWithin => 10})
  end

  def self.delete(id)
    connection.delete_by_id(id)
    puts "Deleted solr record #{id}"
    connection.commit
  end

  def self.connection
    RSolr.connect(url: Blacklight.connection_config[:url])
  end
end

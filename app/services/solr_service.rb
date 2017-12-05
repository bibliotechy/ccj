module SolrService
  def self.add(json)
    p json
    connection.add(json, add_attributes: {:commitWithin => 10})
  end

  def self.connection
    RSolr.connect(url: Blacklight.connection_config[:url])
  end
end

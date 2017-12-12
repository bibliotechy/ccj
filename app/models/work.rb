class Work < ApplicationRecord
  has_many :components
  has_many :artists, through: :components

  after_save :index_record

  def to_solr
      # *_texts here is a dynamic field type specified in solrconfig.xml
    {
      id: "work_#{id}",
      title_t: title,
      title_en_t: title_en,
      title_jp_t: title_jp,
      description_en_t: description_en,
      description_jp_t: description_jp,
      artists_t: artists.uniq.map(&:to_s),
      artists_facet: artists.uniq.map(&:to_s),
    }.merge(components_solr)
  end

  def components_solr
    return_hash = {}
    # Get an array of hash representations of components
    # thenm transfom that into a hash of arrays
    components.map(&:to_solr)
    .each do |pairs|
      pairs.each do |k,v|
        (return_hash[k] ||= []) << v unless v.nil?
      end
    end
    return_hash
  end

  def index_record
    SolrService.add(self.to_solr)
  end

  def title
    [title_en, title_jp].compact.join(" / ")
  end

  def to_s
    title
  end
end

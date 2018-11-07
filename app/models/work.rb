class Work < ApplicationRecord
  has_many :components, dependent: :destroy
  has_many :artists, -> { distinct }, through: :components

  after_save :index_record
  after_destroy :delete_solr_record

  def solr_id
    "work_#{id}"
  end

  def to_solr
      # *_texts here is a dynamic field type specified in solrconfig.xml
    {
      id: solr_id,
      local_id_t: local_id,
      title_t: title,
      title_facet: title,
      title_en_t: title_en,
      title_jp_t: title_jp,
      description_en_t: description_en,
      description_jp_t: description_jp,
      artists_t: artists.uniq.map(&:to_s),
      artists_en_t: artists.uniq.map(&:name_en),
      artists_facet: artists.uniq.map(&:to_s),
      decades_facet: decades.uniq
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
    return_hash.transform_values(&:uniq)
  end

  def index_record
    SolrService.add(self.to_solr)
  end

  def delete_solr_record
    SolrService.delete(solr_id)
  end

  def title
    [title_en, title_jp].compact.join(" / ")
  end

  def to_s
    title
  end

  def decades
    components.map(&:creation_date)
      .compact
      .map(&:to_i)
      .map(&:to_s)
      .map { |date| "#{date[0..2]}0s" }
  end
end

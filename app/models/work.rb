class Work < ApplicationRecord
  has_many :components, dependent: :destroy
  belongs_to :artist
  has_many :component_artists, -> { distinct }, through: :components, source: :artists
  has_many :collections, -> { distinct }, through: :components

  after_save :index_record
  after_destroy :delete_solr_record


  def solr_id
    local_id
  end

  def to_solr
      # *_texts here is a dynamic field type specified in solrconfig.xml
    {
      id: local_id,
      local_id_t: local_id,
      title_t: title,
      title_facet: title,
      title_en_t: title_en,
      title_jp_t: title_jp,
      description_en_t: description_en,
      description_jp_t: description_jp,
      artists_t: artists.map(&:to_s),
      artists_en_t: artists.map(&:name_en),
      artists_facet: artists.map(&:to_s),
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

  def artists
    (component_artists.to_a.append(artist)).uniq
  end

  def video_id
    # video_url is expected in format https://vimeo.com/288791842
    video_url.split("/").last
  end

  def decades
    components.map(&:creation_date)
      .compact
      .map(&:to_i)
      .map(&:to_s)
      .map { |date| "#{date[0..2]}0s" }
  end
end

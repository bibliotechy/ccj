# frozen_string_literal: true
class SolrDocument
  include Blacklight::Solr::Document

  def initialize(source_doc = {}, response = nil)
    super(source_doc, response)
    self['combined_title'] = combined_title
  end

  def combined_title
    "#{self['title_en_t'].join(' ')} / #{self['title_jp_t'].join(' ')}"
  end

  # self.unique_key = 'id'

  # Email uses the semantic field mappings below to generate the body of an email.
  SolrDocument.use_extension(Blacklight::Document::Email)

  # SMS uses the semantic field mappings below to generate the body of an SMS email.
  SolrDocument.use_extension(Blacklight::Document::Sms)

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  # Semantic mappings of solr stored fields. Fields may be multi or
  # single valued. See Blacklight::Document::SemanticFields#field_semantics
  # and Blacklight::Document::SemanticFields#to_semantic_values
  # Recommendation: Use field names from Dublin Core
  use_extension(Blacklight::Document::DublinCore)



end

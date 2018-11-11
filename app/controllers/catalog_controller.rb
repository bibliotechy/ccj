# frozen_string_literal: true
class CatalogController < ApplicationController
  include Blacklight::Catalog

  before_action :add_facet_context, only: [:index]
  def add_facet_context
    if params['f']
      artist_name = params.dig('f','artists_facet')
      if artist_name && artist_name.size == 1
        artist_name_en = artist_name.first.split("/").first.strip
        @context = Artist.find_by(name_en: artist_name_en)
      end
    end
  end




  def show
    pid = params[:id]
    binding
    id = pid.include?("_") ? pid.split("_")[1] : pid
    @work = Work.find(id)
    respond_to do |format|
     format.html  # {setup_next_and_previous_documents }
     #format.json { render json: { response: { document: @document } } }
    end
  end

  configure_blacklight do |config|


    config.default_solr_params = {
      rows: 10,
      fl: %q[
        id
        artists_en_t
        local_id_t
        pub_date
        score
        title_en_t
        title_jp_t
        color_t
        sound_t
        run_time_t
      ]

    }

    config.index.document_actions.delete(:bookmark)
    config.show.document_actions.delete(:bookmark)
    config.navbar.partials.delete(:bookmark)

    # solr path which will be added to solr base url before the other solr params.
    #config.solr_path = 'select'

    # items to show per page, each number in the array represent another option to choose from.
    #config.per_page = [10,20,50,100]

    ## Default parameters to send on single-document requests to Solr. These settings are the Blackligt defaults (see SearchHelper#solr_doc_params) or
    ## parameters included in the Blacklight-jetty document requestHandler.
    #
    #config.default_document_solr_params = {
    #  qt: 'document',
    #  ## These are hard-coded in the blacklight 'document' requestHandler
    #  # fl: '*',
    #  # rows: 1,
    #  # q: '{!term f=id v=$id}'
    #}

    # solr field configuration for search results/index views
    config.index.title_field = 'combined_title'

    config.index.display_type_field = 'format'

    config.add_facet_field 'artists_facet', label: 'Artists', limit: 5, collapse: false
    config.add_facet_field 'decades_facet', label: "Decade", collapse: false
    config.add_facet_field 'contributors_facet', label: 'Contributors', limit: 5, collapse: false
    config.add_facet_field 'film_print_type_facet', label: 'Film Print Type', limit: 5, collapse: false
    config.add_facet_field 'bit_depth_facet', label: 'Bit Depth', limit: 5, collapse: false
    config.add_facet_field 'dimensions_facet', label: 'Dimensions', limit: 5, collapse: false
    config.add_facet_field 'viewing_restrictions_facet', label: 'Viewing Restrictions', limit: 5, collapse: false
    config.add_facet_field 'collection_facet', label: "Collection", limit: 5, collapse: false
    # Only for logged in users
    config.add_facet_field 'media_format_facet', label: 'Media Format', limit: 5, collapse: false, if: :user_signed_in?
    config.add_facet_field 'component_type_facet', label: 'Component Type', limit: 5, collapse: false, if: :user_signed_in?
    config.add_facet_field 'media_type_facet', label: "Media Type", limit: 5, collapse: false, if: :user_signed_in?



    config.add_facet_fields_to_solr_request!

    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display
    config.add_index_field 'artists_t', label: 'Artists', helper: :artists_display



      #   The ordering of the field names is the order of the display
    config.add_show_field 'title_t', label: 'Title'
    config.add_show_field 'description_en_t', label: 'Description'

    # "fielded" search configuration. Used by pulldown among other places.
    # For supported keys in hash, see rdoc for Blacklight::SearchFields
    #
    # Search fields will inherit the :qt solr request handler from
    # config[:default_solr_parameters], OR can specify a different one
    # with a :qt key/value. Below examples inherit, except for subject
    # that specifies the same :qt as default for our own internal
    # testing purposes.
    #
    # The :key is what will be used to identify this BL search field internally,
    # as well as in URLs -- so changing it after deployment may break bookmarked
    # urls.  A display label will be automatically calculated from the :key,
    # or can be specified manually to be different.

    # This one uses all the defaults set by the solr request handler. Which
    # solr request handler? The one set in config[:default_solr_parameters][:qt],
    # since we aren't specifying it otherwise.

    config.add_search_field 'all_fields', label: 'All Fields'

    # "sort results by" select (pulldown)
    # label in pulldown is followed by the name of the SOLR field to sort by and
    # whether the sort is ascending or descending (it must be asc or desc
    # except in the relevancy case).
    config.add_sort_field 'score desc, pub_date_sort desc, title_sort asc', label: 'relevance'
    config.add_sort_field 'pub_date_sort desc, title_sort asc', label: 'year'
    config.add_sort_field 'author_sort asc, title_sort asc', label: 'author'
    config.add_sort_field 'title_sort asc, pub_date_sort desc', label: 'title'

    # If there are more than this many search results, no spelling ("did you
    # mean") suggestion is offered.
    config.spell_max = 5

    # Configuration for autocomplete suggestor
    config.autocomplete_enabled = true
    config.autocomplete_path = 'suggest'
  end
end

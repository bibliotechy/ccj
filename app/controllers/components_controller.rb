class ComponentsController < ApplicationController
  before_action :set_component, only: [:show, :edit, :update, :destroy]

  layout "blacklight"

  # GET /components/1
  # GET /components/1.json
  def show
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_component
      @component = Component.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def component_params
      params.require(:component).permit(:local_identifer, :identifier, :previous_ids, :work_id, {:artist_ids => []}, :description_en, :description_jp, :contributors_jp, :contributors_jp, :creation_date, :color, :sound, :run_time, :collection, :media_type, :media_format, :component_type, :relation, :film_print_type, :fps, :brand, :file_ame, :codec, :codec_id, :file_size_gb, :duration, :bit_rate, :dimensions, :display_aspect_ratio, :bit_depth, :scan_type, :encoded_date, :provenance, :viewing_restrictions, :terms_governing_use, :housing_annotations, :item_annotations, :condition_notes, :notes, :date_of_entry, :cataloger)
    end
end

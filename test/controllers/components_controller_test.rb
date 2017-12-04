require 'test_helper'

class ComponentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @component = components(:one)
  end

  test "should get index" do
    get components_url
    assert_response :success
  end

  test "should get new" do
    get new_component_url
    assert_response :success
  end

  test "should create component" do
    assert_difference('Component.count') do
      post components_url, params: { component: { bit_depth: @component.bit_depth, bit_rate: @component.bit_rate, brand: @component.brand, cataloger: @component.cataloger, codec: @component.codec, codec_id: @component.codec_id, collection: @component.collection, color: @component.color, component_type: @component.component_type, condition_notes: @component.condition_notes, contributors_jp: @component.contributors_jp, contributors_jp: @component.contributors_jp, creation_date: @component.creation_date, date_of_entry: @component.date_of_entry, description_en: @component.description_en, description_jp: @component.description_jp, dimensions: @component.dimensions, display_aspect_ratio: @component.display_aspect_ratio, duration: @component.duration, encoded_date: @component.encoded_date, file_ame: @component.file_ame, file_size_gb: @component.file_size_gb, film_print_type: @component.film_print_type, fps: @component.fps, housing_annotations: @component.housing_annotations, identifier: @component.identifier, item_annotations: @component.item_annotations, local_identifer: @component.local_identifer, media_format: @component.media_format, media_type: @component.media_type, notes: @component.notes, previous_ids: @component.previous_ids, provenance: @component.provenance, relation: @component.relation, run_time: @component.run_time, scan_type: @component.scan_type, sound: @component.sound, terms_governing_use: @component.terms_governing_use, viewing_restrictions: @component.viewing_restrictions, work_id: @component.work_id } }
    end

    assert_redirected_to component_url(Component.last)
  end

  test "should show component" do
    get component_url(@component)
    assert_response :success
  end

  test "should get edit" do
    get edit_component_url(@component)
    assert_response :success
  end

  test "should update component" do
    patch component_url(@component), params: { component: { bit_depth: @component.bit_depth, bit_rate: @component.bit_rate, brand: @component.brand, cataloger: @component.cataloger, codec: @component.codec, codec_id: @component.codec_id, collection: @component.collection, color: @component.color, component_type: @component.component_type, condition_notes: @component.condition_notes, contributors_jp: @component.contributors_jp, contributors_jp: @component.contributors_jp, creation_date: @component.creation_date, date_of_entry: @component.date_of_entry, description_en: @component.description_en, description_jp: @component.description_jp, dimensions: @component.dimensions, display_aspect_ratio: @component.display_aspect_ratio, duration: @component.duration, encoded_date: @component.encoded_date, file_ame: @component.file_ame, file_size_gb: @component.file_size_gb, film_print_type: @component.film_print_type, fps: @component.fps, housing_annotations: @component.housing_annotations, identifier: @component.identifier, item_annotations: @component.item_annotations, local_identifer: @component.local_identifer, media_format: @component.media_format, media_type: @component.media_type, notes: @component.notes, previous_ids: @component.previous_ids, provenance: @component.provenance, relation: @component.relation, run_time: @component.run_time, scan_type: @component.scan_type, sound: @component.sound, terms_governing_use: @component.terms_governing_use, viewing_restrictions: @component.viewing_restrictions, work_id: @component.work_id } }
    assert_redirected_to component_url(@component)
  end

  test "should destroy component" do
    assert_difference('Component.count', -1) do
      delete component_url(@component)
    end

    assert_redirected_to components_url
  end
end

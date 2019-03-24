module ComponentsHelper
  def work_page_fields(component)
    component_fields = %i[
      color sound run_time media_type media_format
      creation_date recording_date description_en description_jp
    ]
    field_subset_hash = {}
    component_fields.each do |cf|
      val = component.respond_to?(cf) ? component.send(cf) : nil
      field_subset_hash[cf] = val unless val.nil?
    end
    field_subset_hash
  end
end

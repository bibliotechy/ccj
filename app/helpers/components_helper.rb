module ComponentsHelper
  def work_page_fields(component)
    admin_component_fields = %i[
      color sound run_timemedia_format
      creation_date recording_date description_en description_jp 
    ]
    component_fields = %i[ collection  media_type ]
    component_fields+= admin_component_fields if user_signed_in?  
    field_subset_hash = {}
    component_fields.each do |cf|
      val = component.respond_to?(cf) ? component.send(cf) : nil
      field_subset_hash[cf] = val unless val.nil?
    end
    field_subset_hash
  end
end

module ComponentsHelper
  def work_page_fields(component)
    component_fields = %i[
      local_identifer color sound run_time
      media_type media_format component_type
      film_print_type notes
    ]
    field_subset_hash = {}
    component_fields.each do |cf|
      val = component.respond_to?(cf) ? component.send(cf) : nil
      field_subset_hash[cf] = val unless val.nil?
    end
    field_subset_hash
  end
end

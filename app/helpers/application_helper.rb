module ApplicationHelper

  def artists_display(args)

  end

  def document_show_link_field_jp document=nil
    fields = Array(blacklight_config.view_config(document_index_view_type).title_field_jp)

    field = fields.first if document.nil?
    field ||= fields.find { |f| document.has? f }
    field &&= field.try(:to_sym)
    field ||= document.id

    field
  end
end

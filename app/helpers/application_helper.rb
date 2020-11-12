module ApplicationHelper

  def work_details(document)
    document.values_at('color_t', 'sound_t', 'run_time_t', "media_format_t", "pub_date" ).compact.map do |detail|
      detail.compact.uniq.to_sentence
    end.join(", ")
  end

  def render_context
    render "#{@context.class.to_s.downcase}_context" rescue nil
  end

  def collection_facet_name(context)
    if context.website.nil?
      context.website
    else
      link_to context.name_en, context.website
    end
  end
end

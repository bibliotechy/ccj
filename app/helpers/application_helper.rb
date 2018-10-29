module ApplicationHelper

  def work_details(document)
    document.values_at('color_t', 'sound_t', 'run_time_t').compact.map do |detail|
      detail.compact.uniq.to_sentence
    end.join(", ")
  end
end

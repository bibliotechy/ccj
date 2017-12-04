class Work < ApplicationRecord
  has_many :components
  has_many :artists, through: :components

  def title
    [title_en, title_jp].compact.join(" / ")
  end

  def to_s
    title
  end
end

class Artist < ApplicationRecord
  has_and_belongs_to_many :components
  has_many :works, through: :components

  def name
    [name_en, name_jp].compact.join(" / ")
  end

  def to_s
    name
  end
end

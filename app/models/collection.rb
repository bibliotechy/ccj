class Collection < ApplicationRecord
  has_many :components
  has_many :works, -> { distinct }, through: :components

  def name
    name_en
  end

  def to_s
    name_en
  end

end

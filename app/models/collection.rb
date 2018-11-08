class Collection < ApplicationRecord
  has_many :works


  def to_s
    name_en
  end

end

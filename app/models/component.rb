class Component < ApplicationRecord
  belongs_to :work
  has_and_belongs_to_many :artists

  def to_s
    identifier
  end
end

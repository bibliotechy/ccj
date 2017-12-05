class Artist < ApplicationRecord
  has_and_belongs_to_many :components
  has_many :works, through: :components

  after_save :index_work_record

  def index_work_record
      works.each do |work|
        work.index_record
      end
  end

  def name
    [name_en, name_jp].compact.join(" / ")
  end

  def to_s
    name
  end
end

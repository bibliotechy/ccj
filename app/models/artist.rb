class Artist < ApplicationRecord
  has_and_belongs_to_many :components
  has_many :component_works, -> { distinct }, through: :components, source: :work
  has_many :works
  has_one_attached :image


  after_save :index_work_record

  def index_work_record
      all_works.each do |work|
        work.index_record
      end
  end

  def all_works
    component_works + works
  end

  def name
    [name_en, name_jp].compact.join(" / ")
  end

  def to_s
    name
  end
end

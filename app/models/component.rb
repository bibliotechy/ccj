class Component < ApplicationRecord
  belongs_to :work
  has_and_belongs_to_many :artists

  after_save :index_work_record

  def index_work_record
    Work.find(work_id).index_record
  end

  def to_s
    identifier
  end
end

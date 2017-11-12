class Work < ApplicationRecord
    has_many :artists
    has_many :components
end

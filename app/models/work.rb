class Work < ApplicationRecord
    has_many :components through :artists
end

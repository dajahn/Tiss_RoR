class Favorite < ApplicationRecord
    validates :objectId, presence: true
    validates :entryType, presence: true

    belongs_to :user
end

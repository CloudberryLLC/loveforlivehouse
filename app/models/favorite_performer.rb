class FavoritePerformer < ApplicationRecord
  belongs_to :user, optional: true
end

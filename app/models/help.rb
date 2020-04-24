class Help < ApplicationRecord
  validates :title, :category, :content, presence: true
end

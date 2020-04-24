class Inquiry < ApplicationRecord
  validates :name, :email, :category, :content, presence: true
  validates :content, presence:true, length: { maximum: 1000 }
end

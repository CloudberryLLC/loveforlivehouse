class Payment < ApplicationRecord
  belongs_to :offer, optional: :true

  #validates :payment_options, presence: true

end

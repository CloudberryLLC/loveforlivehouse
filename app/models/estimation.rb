class Estimation < ApplicationRecord
  belongs_to :offer, optional: :true

	validates :staff, :transport, :accommodation, :carriage, :equipment, :other_expenses,
    numericality: {only_integer: true, greater_than_or_equal_to: 0,
            message: 'には0以上の数値(半角)を入力してください。'}

end

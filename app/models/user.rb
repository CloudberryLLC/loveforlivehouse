class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :two_factor_authenticatable,
         :otp_secret_encryption_key => Rails.application.credentials.TWO_FACTOR_ENCRYPTION_KEY

  has_one :basic, dependent: :destroy
  has_one :bank, dependent: :destroy
  has_many :livehouses, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :chat_messages, through: :contacts, dependent: :destroy
  has_many :offers, dependent: :destroy
  has_many :favorite_livehouses, dependent: :destroy

  accepts_nested_attributes_for :basic, :bank, :livehouses, :contacts, :chat_messages, :favorite_livehouses

  validate :rule_confirmation_valid?
  validate :user_type_valid?
  validates :email, confirmation: true
  validates :password, confirmation: true

  private
    def rule_confirmation_valid?
      errors.add(:rule_confirmation, 'に同意しない場合、登録できません。') unless rule_confirmation == true
    end

    def user_type_valid?
      errors.add(:user_type, 'のいずれか1つにチェックを入れてください。') if user_type == nil
    end

end

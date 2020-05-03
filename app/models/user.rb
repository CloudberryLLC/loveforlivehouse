class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable, #:confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :two_factor_authenticatable,
         :otp_secret_encryption_key => Rails.application.credentials.TWO_FACTOR_ENCRYPTION_KEY

  has_one :basic, dependent: :destroy
  has_one :bank, dependent: :destroy
  has_one :musician_profile, dependent: :destroy #musician_profileはperformer_profileができたら削除
  has_many :performer_profiles, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :chat_messages, through: :contacts, dependent: :destroy
  has_many :offers, dependent: :destroy
  has_many :favorite_performers, dependent: :destroy

 #musician_profileは会員数が増えてきたら実装
  accepts_nested_attributes_for :basic, :bank, :musician_profile, :performer_profiles, :contacts, :chat_messages, :offers, :favorite_performers

  acts_as_ordered_taggable
  acts_as_ordered_taggable_on :instruments

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

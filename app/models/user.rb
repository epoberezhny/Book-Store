class User < ApplicationRecord
  has_one :billing_address,  as: :addressable, dependent: :destroy
  has_one :shipping_address, as: :addressable, dependent: :destroy

  has_many :reviews, dependent: :destroy
  has_many :orders,  dependent: :nullify

  validates_with PasswordValidator, if: :password_required?

  accepts_nested_attributes_for :billing_address, :shipping_address

  devise :database_authenticatable,
         :registerable,
         :rememberable,
         :confirmable,
         :recoverable,
         :validatable,
         :omniauthable,
         omniauth_providers: [:facebook]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email      = auth.info.email
      user.first_name = auth.info.first_name
      user.last_name  = auth.info.last_name
      user.avatar     = auth.info.image

      user.skip_confirmation!
      user.skip_password_validations!
    end
  end

  def skip_password_validations!
    self.password = Devise.friendly_token
    @skip_validations = true
  end

  def skip_password_validations?
    !!@skip_validations
  end

  private

  def password_required?
    return false if skip_password_validations?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
end

class Consumer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :registerable, :rememberable, authentication_keys: [:login]

  belongs_to :tariff

  attr_writer :login

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  validates :username, presence: true, uniqueness: { case_sensitive: false }

  # validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  validates_length_of :username, minimum: 3

  has_many :change_tariff_requests, dependent: :destroy

  has_many :complaints, dependent: :destroy

  has_many :payments, dependent: :destroy

  has_many :consumer_notifications, dependent: :destroy
end

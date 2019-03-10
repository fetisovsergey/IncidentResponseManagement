class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #
  # Disabled:
  # :validatable - for validation
  # :registerable - for registration

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  has_many :incidents, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :departures, dependent: :destroy
  has_many :documents, dependent: :destroy

  validates :email, :name, :surname, :second_name, :password, :password_confirmation, presence: true

  validates :email, uniqueness: { case_sensitive: false }, length: { minimum: 3 }, format: { with: /\A[a-zA-Z0-9\.\-]+\z/ }

  validates :name, :surname, :second_name, length: { minimum: 2 }, format: { with: /\A[а-яА-Я\-]+\z/ }

  validates :password, length: { minimum: 6 }

  validate :check_passwords, if: -> { password && password_confirmation && password != password_confirmation }

  # Check names
  after_validation :set_correct_names

  def full_name
    "#{self.surname} #{self.name} #{self.second_name}"
  end

  def short_name
    "#{self.surname} #{self.name.first}.#{self.second_name.first}."
  end

  private

  def set_correct_names
    self.name = name.mb_chars.capitalize
    self.surname = surname.mb_chars.capitalize
    self.second_name = second_name.mb_chars.capitalize
  end

  def check_passwords
    errors.add(:password, :not_match)
  end
end

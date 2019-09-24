class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name, presence: true, uniqueness: true, length: {minimum: 2, maximum: 20}
  validates :introduction, length: {maximum: 50}

  attachment :profile_image

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :books, dependent: :destroy

  def email_required?
    false
  end
  def email_changed?
    false
  end
end

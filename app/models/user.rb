# frozen_string_literal: true

# User
class User < ApplicationRecord
  has_one_attached :icon_image
  has_many :boards
  has_many :boards_requests
  has_many :boards_chatrooms_users
  has_many :chatrooms, through: :boards_chatrooms_users
  has_many :messages
  has_many :notifications
  has_many :users_slides, dependent: :destroy
  has_many :slide_images, through: :users_slides
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.assign_omniauth_attributes(auth)
    end
  end

  private

  def assign_omniauth_attributes(auth)
    self.name = auth.info.name
    self.gender = auth.info.gender || 'male'
    self.email = auth.info.email
    self.password = Devise.friendly_token[0, 20]
    skip_confirmation!
  end
end

class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

       enum role: [:admin, :user]
  has_many :reservation
  has_many :image

  validates :current_password, :presence => true, :on => :update_profile
  validates :password, :presence =>true, :confirmation => true, :length => { :within => 6..40 }, :on => :update_profile, :unless => lambda{ |user| user.password.blank? }
  validates :password, :confirmation => true, :length => { :within => 6..40 }, :on => :update_profile, :unless => lambda{ |user| user.password.blank? }




end

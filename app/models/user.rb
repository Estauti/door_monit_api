# frozen_string_literal: true

class User < ActiveRecord::Base
  has_many :devices
  has_many :alerts, through: :devices

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist
end

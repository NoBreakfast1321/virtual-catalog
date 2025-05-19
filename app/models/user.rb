class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :categories, dependent: :destroy
  has_many :products, dependent: :destroy

  class << self
    def current
      Thread.current[:current_user]
    end

    def current=(user)
      Thread.current[:current_user] = user
    end
  end
end

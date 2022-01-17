class User < ApplicationRecord

  has_many :articles

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

#  def articles
#   return article.where(user_id: self.id)
#   end
end

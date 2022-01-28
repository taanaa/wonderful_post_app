class Article < ApplicationRecord

  belongs_to :user
  has_many :Article_Tags, dependent: :destroy
  has_many :Tags, through: :Article_Tag


  def user
    #インスタンスメソッドないで、selfはインスタンス自身を表す
    return User.find_by(id: self.user_id)
  end

  def self.search(search)
    if search
      Article.where(['title LIKE ?', "%#{search}%"])
    else
      Article.all
    end
  end



end

class Article < ApplicationRecord

  belongs_to :user
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags

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

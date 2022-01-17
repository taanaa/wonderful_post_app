class AddUserIdToArticles < ActiveRecord::Migration[6.0]
  def change

    add_reference :articles, :user, null: false,default: 0, foreign_key: true
  end
end

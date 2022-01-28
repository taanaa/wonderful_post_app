class Tag < ApplicationRecord
  has_many :Article_Tags, dependent: :destroy
  has_many :Articles, through: :Article_Tag

  validates :name, presence: true
end

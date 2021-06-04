class Book < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.last_week
    Book.joins(:favorites).where(favorites: { created_at: 1.weeks.ago..Time.now}).group(:id).order("count(*) desc")
  end

end
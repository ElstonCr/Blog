class Article < ApplicationRecord
  include Visible

  has_many :comments, dependent: :destroy

  scope :publicly_visible, -> { where(status: "public") }
  scope :order_by_created_at, -> { order(created_at: :desc) }

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  def self.public_count
    publicly_visible.count
  end
end

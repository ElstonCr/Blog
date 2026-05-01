class Comment < ApplicationRecord
  include Visible

  belongs_to :article

  scope :public_comments, -> { where(status: "public") }
end

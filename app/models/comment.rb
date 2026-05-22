class Comment < ApplicationRecord
  include Visible

  belongs_to :article

  scope :public_comments, -> { where(status: "public") }
  scope :approved_comments, -> { where(moderation_status: "approved") }
  scope :visible_comments, -> { public_comments.approved_comments }
  scope :needs_review, -> { where(moderation_status: "flagged") }

  validates :moderation_status, inclusion: { in: [ "approved", "flagged", "rejected", "pending" ].freeze }, allow_nil: true

  def moderate!
    result = CommentModerationService.moderate(body)

    self.moderation_status = result[:moderation_status]
    self.moderation_reason = result[:moderation_reason]
    self.moderation_score = result[:moderation_score]
    self.moderated_at = result[:moderated_at]

    Rails.logger.info "Comment moderated: #{result[:moderation_status]} (score: #{result[:moderation_score]})"
  end
end

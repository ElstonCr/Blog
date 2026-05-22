require "test_helper"

class CommentModerationServiceTest < ActiveSupport::TestCase
  test "approves clean comment" do
    result = CommentModerationService.moderate("This is a great article!")

    assert_equal "approved", result[:moderation_status]
    assert_equal "Clean content", result[:moderation_reason]
    assert_equal 0.0, result[:moderation_score]
    assert_not_nil result[:moderated_at]
  end

  test "flags comment with spam keywords" do
    result = CommentModerationService.moderate("Click here for cheap stuff")

    assert_equal "flagged", result[:moderation_status]
    assert_equal "May contain questionable content", result[:moderation_reason]
    assert_equal 0.5, result[:moderation_score]
    assert_not_nil result[:moderated_at]
  end

  test "rejects comment with both spam and inappropriate keywords" do
    result = CommentModerationService.moderate("Buy cheap stuff you idiot")

    assert_equal "rejected", result[:moderation_status]
    assert_equal "Spam or inappropriate content detected", result[:moderation_reason]
    assert_equal 1.0, result[:moderation_score]
    assert_not_nil result[:moderated_at]
  end

  test "flags comment with inappropriate keywords only" do
    result = CommentModerationService.moderate("This is stupid and nonsense")

    assert_equal "flagged", result[:moderation_status]
    assert_equal "May contain questionable content", result[:moderation_reason]
    assert_equal 0.5, result[:moderation_score]
    assert_not_nil result[:moderated_at]
  end
end

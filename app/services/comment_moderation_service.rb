class CommentModerationService
  def self.moderate(text)
    new(text).moderate
  end

  def initialize(text)
    @text = text.to_s.downcase
  end

  def moderate
    score = calculate_score
    status = determine_status(score)
    reason = build_reason(status, score)

    {
      moderation_status: status,
      moderation_reason: reason,
      moderation_score: score,
      moderated_at: Time.current
    }
  end

  private
    def calculate_score
      @score = 0
      @score += 0.5 if SPAM_KEYWORDS.any? { |keyword| @text.include?(keyword) }
      @score += 0.5 if INAPPROPRIATE_KEYWORDS.any? { |keyword| @text.include?(keyword) }
      @score
    end

    def determine_status(score)
      if score > 0.5
        "rejected"
      elsif score == 0.5
        "flagged"
      else
        "approved"
      end
    end

    def build_reason(status, score)
      case status
      when "rejected"
        "Spam or inappropriate content detected"
      when "flagged"
        "May contain questionable content"
      else
        "Clean content"
      end
    end

    SPAM_KEYWORDS = [ "cheap", "buy now", "click here", "free money" ].freeze
    INAPPROPRIATE_KEYWORDS = [ "hate", "stupid", "idiot", "nonsense" ].freeze
end

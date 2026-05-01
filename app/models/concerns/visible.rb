module Visible
  extend ActiveSupport::Concern

  VALIDATES_STATUS = [ "public", "private", "archived" ]

  included do
    validates :status, inclusion: { in: VALIDATES_STATUS }
  end

  def archived?
    status == "archived"
  end
end

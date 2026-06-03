class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Roles
  ROLES = %w[admin author reader].freeze

  validates :role, inclusion: { in: ROLES }

  def admin?
    role == "admin"
  end

  def author?
    role == "author"
  end

  def reader?
    role == "reader"
  end
end

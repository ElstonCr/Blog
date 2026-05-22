class AddModerationFieldsToComments < ActiveRecord::Migration[8.0]
  def change
    add_column :comments, :moderation_status, :string
    add_column :comments, :moderation_reason, :text
    add_column :comments, :moderation_score, :float
    add_column :comments, :moderated_at, :datetime
  end
end

class AddNotNullToStatus < ActiveRecord::Migration[8.0]
  def change
    change_column_null :articles, :status, false, "public"
    change_column_null :comments, :status, false, "public"

    change_column_default :articles, :status, "public"
    change_column_default :comments, :status, "public"
  end
end

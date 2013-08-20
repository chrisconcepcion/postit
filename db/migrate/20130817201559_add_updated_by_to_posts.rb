class AddUpdatedByToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :updated_by, :string
  end
end

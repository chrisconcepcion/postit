class AddEmailAndAboutMeToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :email, :string
  	add_column :users, :about, :string
  end
end

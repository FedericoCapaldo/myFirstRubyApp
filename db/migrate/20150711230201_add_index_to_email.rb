class AddIndexToEmail < ActiveRecord::Migration
  def change
  	add_index :users, :email, unique: true #does unique refer to the index or data of the columns?
  end
end

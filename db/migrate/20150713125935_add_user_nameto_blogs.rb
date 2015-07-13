class AddUserNametoBlogs < ActiveRecord::Migration
  def change
  	add_column :blogs, :username, :string
  end
end

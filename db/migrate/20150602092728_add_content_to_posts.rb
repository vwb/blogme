class AddContentToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :content, :string
  end
end

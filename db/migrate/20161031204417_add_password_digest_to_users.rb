class AddPasswordDigestToUsers < ActiveRecord::Migration[5.0]
  def self.up
    add_column :users, :password_digest, :string
  end

  def self.down
    remove_column :users, :password_digest, :string
  end
end

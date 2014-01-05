class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string

    User.reset_column_information

    User.all.each do |user|
      user.update_attribute(:password_digest, user.password_hash)
    end

    remove_column :users, :password_hash
  end
end

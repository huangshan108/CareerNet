class AddPasswordDigestToAccount < ActiveRecord::Migration
  def up
  	add_column "accounts", "password_digest", :string
  end

  def down
  	remove_column "accounts", "password_digest"
  end
end

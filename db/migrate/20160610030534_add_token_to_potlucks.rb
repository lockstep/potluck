class AddTokenToPotlucks < ActiveRecord::Migration
  def change
    add_column :potlucks, :token, :string
  end
end

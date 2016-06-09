class CreatePotluckMemberships < ActiveRecord::Migration
  def change
    create_table :potluck_memberships do |t|
      t.references :potluck, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end

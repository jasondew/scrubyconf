class CreateProposals < ActiveRecord::Migration
  def self.up
    create_table :proposals do |t|
      t.string :name, :email, :title, :duration
      t.text :details
      t.datetime :created_at
    end
  end

  def self.down
    drop_table :proposals
  end
end

class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.string :state
      t.belongs_to :sender, :class_name => "User"
      t.belongs_to :receiver, :class_name => "User"
      t.belongs_to :room
      t.timestamps
    end
  end
end

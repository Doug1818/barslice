class AddAttachmentPicToRoompics < ActiveRecord::Migration
  def self.up
    change_table :roompics do |t|
      t.has_attached_file :pic
    end
  end

  def self.down
    drop_attached_file :roompics, :pic
  end
end

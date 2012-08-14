class AddAttachmentPolicydocToRespolicies < ActiveRecord::Migration
  def self.up
    change_table :respolicies do |t|
      t.has_attached_file :policydoc
    end
  end

  def self.down
    drop_attached_file :respolicies, :policydoc
  end
end

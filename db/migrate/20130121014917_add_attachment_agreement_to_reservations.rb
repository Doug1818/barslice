class AddAttachmentAgreementToReservations < ActiveRecord::Migration
  def self.up
    change_table :reservations do |t|
      t.has_attached_file :agreement
    end
  end

  def self.down
    drop_attached_file :reservations, :agreement
  end
end

class Hrsrange < ActiveRecord::Base
  attr_accessible :close, :closed, :friday, :monday, :saturday, :open, :sunday, :thursday, :tuesday, :wednesday
  belongs_to :bar

  before_save do |h|
  	if h.open? && h.close? && !h.sunday && !h.monday && !h.tuesday && !h.wednesday && !h.thursday && !h.friday && !h.saturday
  		h.sunday = true && h.monday = true && h.tuesday = true && h.wednesday = true && h.thursday = true && h.friday = true && h.saturday = true
		end
  end

  validate :open_or_close

  def open_or_close
    unless (self.open? && self.close?) || self.closed?
      self.errors[""] = "Each entry for Hours of operation must either have an open/close time or be marked as closed"
    end
  end
end

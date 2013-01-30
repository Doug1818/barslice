class Hdctrange < ActiveRecord::Base
  attr_accessible :friday, :max, :min, :monday, :saturday, :sunday, :thursday, :tuesday, :var_by_day, :wednesday
  belongs_to :room

  before_save do |hdctrange|
  	if hdctrange.min != nil && hdctrange.max != nil && !hdctrange.sunday && !hdctrange.monday && !hdctrange.tuesday && !hdctrange.wednesday && !hdctrange.thursday && !hdctrange.friday && !hdctrange.saturday
	  	hdctrange.sunday = true && hdctrange.monday = true && hdctrange.tuesday = true && hdctrange.wednesday = true && hdctrange.thursday = true && hdctrange.friday = true && hdctrange.saturday = true
	  	x = Hash.new
	  	Bar.find(Room.find(hdctrange.room_id).bar_id).hrsranges.each_with_index do |hrsrange, idx|
	  		if hrsrange.closed
		  		if hrsrange.sunday    then x[0]=1 end
		  		if hrsrange.monday    then x[1]=1 end
		  		if hrsrange.tuesday   then x[2]=1 end
	  			if hrsrange.wednesday then x[3]=1 end
  				if hrsrange.thursday  then x[4]=1 end
					if hrsrange.friday    then x[5]=1 end
					if hrsrange.saturday  then x[6]=1 end
				end
			end
			if x[0]==1 then hdctrange.sunday = nil end
			if x[1]==1 then hdctrange.monday = nil end
			if x[2]==1 then hdctrange.tuesday = nil end
			if x[3]==1 then hdctrange.wednesday = nil end
			if x[4]==1 then hdctrange.thursday = nil end
			if x[5]==1 then hdctrange.friday = nil end
			if x[6]==1 then hdctrange.saturday = nil end
		end
  end

  validates :min, presence: true, :numericality => { :only_integer => true }
  validates :max, presence: true, :numericality => { :only_integer => true }
end

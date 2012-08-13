require 'abbrev'

class DayRange

   def self.use_day_names(week, abbrev_length=3)
     @day_numbers = {}
     @day_abbrevs = {}
     week.abbrev.each do |abbr, day|
       num = week.index(day) + 1
       @day_numbers[abbr] = num
       if abbr.length == abbrev_length
         @day_abbrevs[num] = abbr
       end
     end
   end

   use_day_names \
     %w(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)

   def day_numbers; self.class.class_eval{ @day_numbers } end
   def day_abbrevs; self.class.class_eval{ @day_abbrevs } end

   attr_reader :days

   def initialize(days)
     @days = days.collect{ |d| day_numbers[d] or d }
     if not (@days - day_abbrevs.keys).empty?
       raise ArgumentError
     end
   end

   def to_s
     ranges = []
     number_ranges.each do |range|
       case range[1] - range[0]
       when 0; ranges << day_abbrevs[range[0]]
       when 1; ranges.concat day_abbrevs.values_at(*range)
       else    ranges << day_abbrevs.values_at(*range).join('-')
       end
     end
     ranges.join(', ')
   end

   def number_ranges
     @days.inject([]) do |l, d|
       if l.last and l.last[1] + 1 == d
         l.last[1] = d
       else
         l << [d, d]
       end
       l
     end
   end
end
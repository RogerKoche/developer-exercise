#!/usr/bin/env ruby

class Array
	def where(args)
		numConditions = args.size
		result = []
		each do |i|
			numMatches = 0
			args.each do |akey, avalue|
				i.each do |ikey, ivalue|
					if akey == ikey
						if avalue.is_a?(Regexp)
							if (avalue =~ ivalue)
								numMatches += 1
								if numMatches == numConditions
									result << i
								end
							end
						else
							if (avalue == ivalue)
								numMatches += 1
								if numMatches == numConditions
									result << i
								end	
							end
						end
					end
				end
			end
		end
		result
	end
end
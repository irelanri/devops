
# (1)

sites = ["net", "psd", "mobile"]
 
sites.map! do |site|
     site += ".tutsplus.com"
     end
      
# Methods ending in '!' are destructive i.e. the original array 'sites' gets
# over-written by the method

sites # => ["net.tutsplus.com", "psd.tutsplus.com", "mobil
puts sites


# (2)

sites2 = ["net", "psd", "mobile"]

sites2.each { |site|
	puts "#{site}.whatever.com"
}

# Blocks can be enclosed by { .. } OR by begin .. end


# (3)

sites3 = ["net", "psd", "mobile"]

sites4 = sites3.map do |s|
    "#{s}.tutsplus.com"
end
puts sites4

# Blocks will return the value of the last statement


# (4)

# Numbers have methods! Like this times method, which takes a block ...
# ( Starts from '0' btw !! )

5.times do |i|
    puts "Loop number #{i}"
end
        

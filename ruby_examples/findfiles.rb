require 'find'

def bitmap?(data)
     return data[0,2]=="MB"
end

def gif?(data)
     return data[0,4]=="GIF8"
end

def jpeg?(data)
     return data[0,4]=="\xff\xd8\xff\xe0"
end

def file_is_image?(filename)
     begin

     if File.directory?(filename)
     	return false
	end
     unless File.readable?(filename)
     	return false
	end
     	f = File.open(filename,'rb')  or return false # rb means to read using binary
     data = f.read(9) or return false              # magic numbers are up to 9 bytes
     f.close

     if data
     	return bitmap?(data) || gif?(data) || jpeg?(data)
     end

     #return bitmap?(data) or gif?(data) or jpeg?(data)
     #puts filename
     #if data
     #	return bitmap?(data)
     #end

     rescue Exception
     # do nothing 
     false

     end
end

Find.find(ENV["HOME"]) do |path|

	if file_is_image?(path)
		puts "Image found: #{path}"
	end

end



require 'fileutils'

def movefiles(dir,limit)

        files = Array.new

        Dir.chdir(dir)

        # Get next 10 files
        Dir.glob("*") do |path|

                if files.length < limit
                        unless File.directory?(path)
                                files.push(dir + "/" + path)
                        end
                end
        end

        newdir = String.new

        unless files.length == limit
                return 0
        end

        # Find numerical unique name for new directory
        (0..999).each do |i|
                newdir = dir + "/" + i.to_s
                unless File.exists?(newdir)
                        puts "Will create #{newdir}"
                        break
                end
        end

        #
        # Create new directory
        # Need to catch exception here, if permission denied for example
        Dir.mkdir newdir

        # Move files into new directory
        # Need to catch exception here, if permission denied for example
        files.each do |file|
                puts "File = #{file}"
                FileUtils.mv(file,newdir)
        end
        return newdir
end

#Need to loop, until returns 0
movefiles('/Users/richard/devops/ruby_examples/testdata',5)


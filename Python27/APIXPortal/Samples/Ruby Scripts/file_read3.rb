f = File.open("input.txt", "r")
if f
  f.each{|line| print line} 

else
  puts "Unable to open file!"
end
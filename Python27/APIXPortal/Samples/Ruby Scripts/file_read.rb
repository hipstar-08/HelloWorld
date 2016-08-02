f = File.open("input.txt", "r")
if f
  if File.read(f).include?("nitin")
     puts "Yes"
  else
     puts "no"
   end	 
   
else
  puts "Unable to open file!"
end
f = File.open("input.txt", "r")
f1 = File.new("dest.txt","w+")
if f
  s=f.read()
  f1.write(s)
  puts"file copied"
  f1.close
  f1=File.open(f1,"r")
   if f1
     f1.each{|line| print line}
   else
     puts "No f1"
   end	 

else
  puts "Unable to open file!"
end
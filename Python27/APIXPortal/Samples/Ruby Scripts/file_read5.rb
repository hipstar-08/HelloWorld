f = File.open("input.txt", "r")
f1 = File.new("dest.txt","w+")
f2 = Hash.new()
f3 = Hash.new()
n=0
if f
  s=f.read()
  f1.write(s)
  puts"file copied"
  f1.close
  f1=File.open(f1,"r")
   if f1
     f2=File.read(f1).split
	len=f2.length
	
	for i in 0...len
	n=0
	for j in 0...len
	 
	  if f2[i]==f2[j]
	     n=n+1
	  end
	  
	end  
	  f3[i]=n
    end
    
   else
     puts "No f1"
   end	 
  for i in 0...len
	puts f2[i] 
	puts f3[i]
	end

else
  puts "Unable to open file!"
end
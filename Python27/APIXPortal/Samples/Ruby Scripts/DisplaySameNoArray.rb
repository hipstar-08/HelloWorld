#-- Same no in array
a = Array.new
b = Array.new
a=[1,5,4,5,4,6,1]


l=a.length
puts l
flag=0
j=0
for p in 0...l

n=a[p]
for i in p+1...l
  l1=b.length
   flag=0
 if n == a[i]
  
  for x in 0..l1
	if n == b[x]
		flag=1
	end
  end
	if flag == 0 
	    b[j]= n
		j=j+1
    end		
 end
  
end 
end 
#end
puts "#{b}"


#--substring search in string

a=Array.new
b= Array.new
c= Array.new
a=[1,2,0,3,4,5]
l=a.length
flag=0

#print "Please provide value:"
val=6



x=0
for i in 0...l
    p=a[i]
	sum=0
   for j in 0...l
      # if i!=j
	     sum= p+a[j]
		 if sum==val
		# puts sum
		# puts val
			c[x]=p
			  x=x+1
		   c[x]=a[j]
		   x=x+1
		 end  
	  #end
    end
end	 

puts "#{c}"
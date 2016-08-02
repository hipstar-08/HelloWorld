#---------calculating combinations of array element--------------------


p=0
a=Array.new
b=Array.new
x=String.new
u=Array.new
a=[[3,2],[6,7]]
l=a.length
#puts l
n=0
m=0

for i in 0...l
d=a[i].length
   for j in 0...d
   
   b[n]=a[i][j]
   n=n+1
   end
   
end	 
q=b.length
#puts q
puts "-----"
#puts b
k=0
r=0
for s in 0...l
u[r]=a[s].length
r=r+1
end
puts u
v=0
for i in 0...q-1
c=0
  
      x=b[i]
	# puts x
	 if(u[v]%2==0)
	  c=i+u[v]
	 else
      c=i+1
     end 	
     	 
	 for k in c...q
	 y=b[k]
	 puts "[#{x} " " #{y} ]"
	 end

#else
#break   
#end  
puts"---"
end	


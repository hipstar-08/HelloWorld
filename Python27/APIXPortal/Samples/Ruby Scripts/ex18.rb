#---------Missing Value from Array--------------------

p=0
a=Array.new
b=Array.new
x=String.new

a=[[1,2], [3,4]]
l=a.length
#puts l
n=0
m=0

for i in 0...l
   if (i != l-1)
     g=a[i].length
	 for j in 0...g
	    x=a[i][j]
		p=i+1
		q=j+1
		if(p<l)
	    y=a[p][j]
		end
	    puts x
	    puts y
	   puts "----"
	 end
	 end
end	 
	 
	 
	




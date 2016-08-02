#---------Missing Value from Array--------------------

p=0
a=Array.new
b=Array.new
puts "Enter values = "
a=gets.chomp
l=a.length
puts l
x=a[0]  #Max
y=a[0]  #Min
#Min Max calualtion
for i in 1...l
  if( x < a[i])
     x=a[i]
  else 
    if (y > a[i])
     y=a[i]
	end 
  end
end 
c=0
flag=0
#Finding Missing value
for p in y..x
flag=0
   for i in 0..l
     if(p==a[i])
      	flag=1
		break 
     else
        flag=0
     end
   end
   if flag==0
    b[c]=p
	c=c+1
   end
end   

puts "Missing values = #{b}"
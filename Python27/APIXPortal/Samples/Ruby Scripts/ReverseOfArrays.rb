#----------Reverse of array------------

p=0
a=Array.new
b=Array.new
s="My Name is nitin"

a=s.split(" ")
l=a.length
i=l-1
while i >= 0 do
   b[p]=a[i]
   p=p+1
   i=i-1
end  
g=b*" "   
puts l
puts g

puts "Reverse = #{b}" 

#--Reverse string

a=String.new
b=String.new

a = 'sony'
j=0
l=a.length
i=l-1


while i>=0 
 b[j]=a[i]
 j=j+1
 i=i-1
end 

puts "Reverse of string is: #{b}"

if b.eql?(a)
 puts "String is Palimedrome"
else
  puts "String is Not Palimedrome"
end	



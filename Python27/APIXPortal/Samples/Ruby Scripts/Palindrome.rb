#--Reverse string
a=String.new
b=String.new
print "Please provide string:"
a=gets.chomp
j=0
l=a.length
i=l-1

while i>=0 
 
 b[j]=a[i]
 j=j+1
 i=i-1
end 

puts "Reverse of string is: #{b}"

if a.eql?(b)
 puts "String is Palindrome"
else
  puts "String is Not Palindrome"
end
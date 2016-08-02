#---------perfect square--------------------

i=1
p=0
n=26
flag=0
for p in 0..n
if (p==n)
flag=1

break
else
p=p+1
i=i+2
flag=0
end 
end
puts p
puts flag


if  flag==1
 puts "Yes"
else

puts "No"
end
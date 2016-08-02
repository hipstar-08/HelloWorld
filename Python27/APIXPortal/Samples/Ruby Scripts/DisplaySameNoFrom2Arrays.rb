a = Array.new
b = Array.new
a=[1,2,5]
b=[1,2,3,4,5,6]
l1=a.length
l2=b.length
if(l1 > l2)
 len=l1
else
 len=l2
end
 
c = Array.new
p=0
j=0
for i in 0...len
 if a[i] != b[j]
   i=i+1
 else
   if a[i] == b[j]
    c[p]=a[i]
	p=p+1
	j=j+1
  end
 end 
end 
puts "#{c}"

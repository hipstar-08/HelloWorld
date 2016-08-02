

def sort(a=Array.new,count)

n=a[0]

for i in 1..count-1
  if (n < a[i].to_i) then
     n=a[i]
  else
    a[i],a[i-1]=a[i-1],a[i]    
	
  end 
end
 return a
end


a=Array.new

a=[1,3,3,2,1]
l=a.length
count=l
while count > 1 do 
a=sort(a,count)
count=count-1
end
puts a








 




 

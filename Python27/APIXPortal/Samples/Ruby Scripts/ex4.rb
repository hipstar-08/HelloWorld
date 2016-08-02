a=Array.new
a=[3,3,1,2]
l=a.length

n=a[0]
for i in 1..l-1
  if n < a[i] then
     n=a[i]
  else
    p=a[i-1]
    a[i-1]=a[i]
    a[i]=p	
      
  end 
end

puts a  




 

a=String.new("3+5")
l=a.length
arr=Array.new
n=0
for i in 0..l-1
  if a[i] != '+' then
    arr[n]=a[i].to_i
	n=n+1
  end
end
  
k=arr.length
puts k
a=0

a=arr.inject(:+)

puts a





 

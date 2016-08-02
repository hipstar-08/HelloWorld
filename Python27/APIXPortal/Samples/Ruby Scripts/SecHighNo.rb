#--2nd largest number
def max(a,m)
l=a.length
n=0
j=0
n=a[0]
for i in 1...l
  if n < a[i]
    if a[i]!=m
    n = a[i]
    puts "******"
    i=i+1
	end
 end
end 
return n
end

a = Array.new
a=[1,3,4,6,7,8,4,3]
n=nil
for i in 1..2
n=max(a,n)
puts n
end    
	
puts "2nd Largest Number is : #{n}"
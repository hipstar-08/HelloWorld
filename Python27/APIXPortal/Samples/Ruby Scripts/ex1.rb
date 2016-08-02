def mul(a,b)
#puts a
#puts b
ans=a+b
puts ans
return ans
end


a = String.new("3*6")
#puts a
p=a.length
#puts p
n=0
s=0
arr=Array.new
fin=Array.new
for i in 0..p-1
    
    if a[i] == '*' then
       i=i+1
	else   
	   puts a[i]
	   puts a[i-1]
       fin[s]= mul((a[i]),(a[i-1]))
	   s=s+1
    end
end	
puts fin
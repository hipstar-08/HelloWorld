class Anagram
#--Anagram string


def search(b,n,l1)
   p=0
   for j in 0...l1
	   if n==b[j]
        p=1
       end
   end
   
   if p==1
    return 1
   else
    return 0
   end
end
   
a=String.new
b=String.new
print "Please provide First string:"
a=gets.chomp

l=a.length
count =0
print "Please provide Second string:"
b=gets.chomp
p=0
l1=b.length

if l!=l1
  puts "Both string are not Anagram"
else
    
  for i in 0...l
    n=a[i]
	p=search(b,n,l1)
	if p==1
	  count=count+1
	end
 end

 if count == l
     puts "Both string are Anagram"
 else
       puts "Both string are not Anagram"
	 
 end
end 
	
	
	   



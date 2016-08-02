
#--Prime nUmber identification


print "Please provide Number:"
a=gets.chomp
c=2
b =(a.to_i/ c)

flag=0

for i in 2..b
   res= (a.to_i % i)

   if res == 0 
     flag = 1
   end	
  
 	 
end	 

if flag == 1 || a==1
 puts "Number is Not Prime Number"
else
 puts "Number is Prime Number"
end
 
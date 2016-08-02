#---------mini pascal--------------------

n=5
k=0
k=n-1
for i in 1..n
 # if (k>-1)
  j=k
  while (j>0)
     print " "
	 j=j-1
  end	
  k=k-1
  for a in 1..i
  print a
  end  
  x=i-1

  if (i>1)
  b=x
    while (b>0)
 
    print b
	b=b-1
    end
  end
  puts "\n"

 # end
end  
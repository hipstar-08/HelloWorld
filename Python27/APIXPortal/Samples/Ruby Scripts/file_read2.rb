f = File.open("input.txt", "r")
p=0
n=10000
if f
 f.each_line do |line|

    line.scan(/[\w']+/) do |word|
     p=p+1
	if word == "running"
	  n=p
	end	
	
	
	if p > n
	 puts word
	end 
  end
 
end


   
else
  puts "Unable to open file!"
end
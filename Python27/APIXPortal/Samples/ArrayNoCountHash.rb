#--Count Dup values
a = [1,1,2,1,2,3,4,1]
#a = Array.new
#a = ['g','b','g','c','d','g','d','g','b','b']
l = a.length - 1
h = Hash.new
	for i in 0..l
		k = h.has_key?(a[i])
		if !(h.include? a[i])
			h.store(a[i],1);
		else
		  	c = h.fetch(a[i])
		  	c = c+1
		  	h.store(a[i],c)
		end	
	end
	h.each do |key, no|
		puts "#{key} #{no}"
	end
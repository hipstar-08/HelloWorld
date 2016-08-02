#--Count Dup values
a = String.new("aabccdd")
b = ""
l = a.length
for i in 0...l
	chr = a[i]
	if !(b.include? chr)
		b << chr
	end	
end
puts b
bl = b.length
for i in 0...bl
	cnt = 0
	for j in 0...l
		if b[i]==a[j]
			cnt = cnt +1
		end
	end
	puts "#{b[i]} #{cnt}"
end
a=[1,2,3,4,5]
b=[1,2,3,4,5,6]
sumA = 0
sumB = 0
alen=a.length
blen=b.length

h = Hash.new

for i in 0...alen
	sumA += a[i]
end

for i in 0...blen
	sumB += b[i]
end

if alen > blen
	puts "missing value is #{sumA - sumB}"
else
	puts "missing value is #{sumB - sumA}"
end
# puts alen
# 	if alen > blen
# 		for i in 0...alen
# 			#puts i
# 			for j in 0...blen
# 				#puts a[i]
# 				if (a[i] == b [j])
# 				# 	puts "a[i]"
# 					break	
# 				end			
# 			end
# 			#puts a[i]	
# 		end
# 	end
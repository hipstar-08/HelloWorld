a = [1,2,3,4,5,6,7,8,9,10,11]
b = Array.new
l = a.length
n = 5
start=0
endv=n
(0...l).step(n) do |i|
	for j in (endv-1).downto(start)
		b << a[j]
	end
	start= start + n
	endv = endv + n
end
puts b
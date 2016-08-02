data = String.new("3*6+4*2")
l=data.length
p=0
a=Array.new
a[p]=data[0].to_i
puts "**#{a[p]}"
p=p+1
for i in 1...l
 if data[i] == '*' then
    i=i+1
    n=a[p-1]
    a[p-1]=n * data[i].to_i
 else
    if data[i] == '+' then
     i=i+1
     a[p]=data[i].to_i
     p=p+1
    end
 end
end

puts "#{a}"
arr= a.inject(:+)

puta = [1,2,3,4,5,6,7,8,9,10,11]
b = Array.new
l = a.length
n = 5
start=0
endv=n
(0...l).step(n) do |i|
	#puts "#{i}"
	#(start...l).s tep(n) do |j|
	#for j in endv-1...start
	for j in (endv-1).downto(start)
		#puts "#{i}  #{j}"
		#puts "value : #{a[j]}" 
		b << a[j]
	end
	#i = i +n\
	start= start + n
	endv = endv + n
end
puts b
#puts as arr 
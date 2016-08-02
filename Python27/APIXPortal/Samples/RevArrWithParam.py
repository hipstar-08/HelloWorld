var =  [1,2,3,4,5,6]
var2 = [5]
N = 2
l = len(var) -1
print l
print var
for i in range(len(var)):
    print i
    #=var[i+1]
    #print var2[i]
    #print var[l-i]
    var2[i] = var[l]
    l=l-1
    #print i
    #if []:
     #   print i
#print var2
#print var2
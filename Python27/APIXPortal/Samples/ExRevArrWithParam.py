def revertSubsetList(l,n,res=[]):

    for i in range(1, len(l)/n+1):
        #print len(l)
        a=(len(l)/n+1)
        print "******************"
        print "a = {}".format(a)
        for j in range(1,n+1):
            print "n +1 = {}".format(n+1)
            #v=l[i*n-j]
           # print "v = {}".format(v)
            res = res + [ l[i*n-j] ]
            print "l =  {}, i = {}, j = {}, i*n = {}, i*n-j {}, l[i*n-j] {} ".format(l,i,j,i*n,i*n-j,l[i*n-j])
            print "res = {}".format(res)
    return res
print revertSubsetList([1,2,3,4,5,6], 2)
def orderly_count(let_string):
	mapping = {}

	for item in let_string:
            #print "****"
            print "item = {}".format(item)
            print (mapping.get(item))
            mapping[item] = mapping.get(item,0)+1
            print (mapping.get(item,0)+1)
            print "mapping-item in function = {}".format(mapping[item])

	result = ''

	for item in let_string:
		if item not in result:
			result += item + str(mapping[item])
                print "item = {} ".format(item)
                print "mapping-item = {}".format(str(mapping[item]))
                print "result = {} ".format(result)
	return result

print(orderly_count('abbaccdbac')) #a3b3c3d1
#print(orderly_count('bbddeeeaaccbbdef')) #b4d3e4a2c2f1
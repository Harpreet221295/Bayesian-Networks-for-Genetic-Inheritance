l = ["F", "f", "n"]
print(l)

m = [l[i]+l[j] for i in range(0,3) for j in range(i,3)]
print(m)

total = 0

for i in range(0, 6):
	for j in range(i, 6):
		list1 = list(m[i])
		list2 = list(m[j])
		res = []
		for k in range(0, len(list1)):
			for l in range(0, len(list2)):
				res.append(''.join(sorted(list1[k]+list2[l])))

		print("{0}-{1} => {2}   tot={3}".format(m[i],m[j],set(res), len(set(res))))
		total += len(set(res))

print("total = ",total)
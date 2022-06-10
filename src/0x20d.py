import os

data = None
decode = []
with open('../data/hex.in') as f:
    data = f.read().split('\n')
data = [i.split(' ')[1:5] for i in data]
for i in data:
    decode.append([])
    for j in i:
        for k in range(0, 8, 2):
            decode[-1].append(int(j[k:k+2], 16))
            if 'a' <= chr(decode[-1][-1]) <= 'z' or 'A' <=  chr(decode[-1][-1]) <= 'Z' or '0' <=  chr(decode[-1][-1]) <= '9':
                decode[-1][-1] = f'{decode[-1][-1]}[{chr(decode[-1][-1])}]'
        decode[-1][-1], decode[-1][-4] = decode[-1][-4], decode[-1][-1]
        decode[-1][-2], decode[-1][-3] = decode[-1][-3], decode[-1][-2]
    decode[-1] = str(decode[-1])

with open('../data/decode.out', 'w') as f:
    f.write('\n'.join(decode))

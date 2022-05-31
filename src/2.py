import random, string
l = [f"{''.join(random.sample(string.ascii_letters + string.digits, 10))} {''.join(random.sample(string.digits, 10))}" for x in range(5000000)]
with open('2.txt', 'w') as f:
    f.write('\n'.join(l))
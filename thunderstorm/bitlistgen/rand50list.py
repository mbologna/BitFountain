import random

def rand50list(seed, L):
    bitlist = [0] * L
    random.seed(seed)
    for i in xrange(L):
        bitlist[i] = random.randint(0,1)
    return bitlist
    

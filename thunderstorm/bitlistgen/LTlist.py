from thunderstorm.util.constants import *
from thunderstorm.util.stat import *

def LTlist(seqnum,K,L,L1):
    d,a,b = tripX2dab(seqnum,K,L1)
    bitlist = [0]*L
    while b >= L:
        b = (b+a) % L1
    bitlist[b] = 1
    if (d-1) < (L-1):
        jmax = d-1
    else:
        jmax = L-1
    for j in xrange(1,jmax+1,1):
        b = (b+a) % L1
        while b >= L:
            b = (b+a) % L1
        bitlist[b] = 1
    return bitlist


from thunderstorm.util.tables import *
from thunderstorm.util.constants import *

fac = lambda n:n-1 + abs(n-1)and fac(n-1)*n or 1
nchoosek = lambda n,k: fac(n)/(fac(n-k)*fac(k))

def tripX2dab(seqnum, K, L1):
    Q = 65521
    JK = JKtbl[K-MINRAPTORK]
    a = (53591 + JK*997)%Q
    b = 10267*(JK+1)%Q
    Y = ((b)+seqnum*(a))%Q
    v = randXim(Y,0,1048576)
    d = degv(v)
    a = 1+randXim(Y,1,L1-1)
    b = randXim(Y,2,L1)
    return d,a,b 
    
def randXim(X, i, m):
    return ((V0tbl[(X+i)%256]^V1tbl[((X>>8)+i)%256])%m)

def degv(v):
    if v < 10241:
        return 1
    elif v < 491582:
        return 2
    elif v < 712794:
        return 3
    elif v < 831695:
        return 4
    elif v < 948446:
        return 10
    elif v < 1032189:
        return 11
    elif v < 1048576:
        return 40
    else:
        raise Exception('rand error')
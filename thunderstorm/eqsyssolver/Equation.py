import numpy
from numpy.core import multiarray as ma

class Equation(object):
    def __init__(self,bl,rblock):
        self.bitlist = bl
        self.random_block = rblock
           
    def __xor__(self, eq):
        assert len(self.bitlist) == len(eq.bitlist) and \
        len(self.random_block) == len(eq.random_block)
        bitlist = []
        for i in xrange(len(self.bitlist)):
            bitlist.append(self.bitlist[i] ^ eq.bitlist[i]) 
        random_block = self.random_block ^ eq.random_block
        return self.__class__(bitlist,random_block)
    
    def cardinality(self):
        cardinality = 0
        for i in xrange(len(self.bitlist)):
            if self.bitlist[i] == 1:
                cardinality += 1
        return cardinality
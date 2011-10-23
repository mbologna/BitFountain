import psyco
psyco.full()
import random
import numpy
from numpy.core import multiarray as ma
from thunderstorm.eqsyssolver.EquationSet import EquationSet 
from thunderstorm.eqsyssolver.Equation import Equation
from thunderstorm.bitlistgen.rand50list import *

def create_random_block(bitlist,piece):
    assert len(piece) % len(bitlist) == 0
    blocksize = len(piece)/len(bitlist)
    random_block = ma.zeros(blocksize,numpy.uint8)
    for i in xrange(len(bitlist)):
        if bitlist[i] == 1:
            block = ma.fromstring(piece[i*blocksize:i*blocksize+blocksize],numpy.uint8)
            random_block ^= block
    return random_block

class RandomDF(object):
    def __init__(self, K,blocksize=16384):
        self.L = K
        self.es = EquationSet(self.L,blocksize)
            
    def use_random_block(self, seed, rblock):
        rblock = ma.fromstring(rblock,numpy.uint8)
        e = Equation(rand50list(seed,self.L), rblock)
        return self.es.puteq(e) 
    
    def retrievedata(self):
        data = self.es.getdata()
        return data

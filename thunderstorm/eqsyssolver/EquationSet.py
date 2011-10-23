from thunderstorm.eqsyssolver.Equation import Equation
import numpy
from numpy.core import multiarray as ma

class EquationSet(object):
    def __init__(self, Neq, blocksize):
        assert Neq > 0 and blocksize > 0
        self.eqset = []
        self.V = []
        self.C = 0
        self.N = Neq
        self.blocksize = blocksize
        for i in xrange(self.N):
            e = Equation([0]*self.N,ma.zeros(self.blocksize,numpy.uint8))
            self.eqset.append(e)
            self.V.append(False)
    
    def puteq(self, eq):
        while True:     
            assert len(eq.bitlist) == self.N and len(eq.random_block) == self.blocksize
            if 1 in eq.bitlist:
                fo = eq.bitlist.index(1)
                if self.V[fo] == False:
                    self.V[fo] = True
                    self.eqset[fo] = eq
                    self.C += 1
                    if self.C == self.N:
                        self.finalize()
                        return True
                else:
                    eq ^= self.eqset[fo]
            else:
                return False
    
    def messagepassingpre(self, eq):
        for i in xrange(0,self.N,1):
            if self.V[i] == True:
                if self.eqset[i].count1() == 1:
                    eq ^= self.eqset[i]
    
    def messagepassingpost(self, j):
        for i in xrange(0,j,1):
            if self.V[i] == True:
                if self.eqset[i].bitlist[j] == 1:
                    self.eqset[j] ^= self.eqset[i]
                    if self.eqset[j].count1() == 1:
                        self.messagepassingpost(j)
        
        
    def done(self):
        return self.C == self.N
        
    def getdata(self):
        assert self.done()
        data = ''
        for i in xrange(self.N):
            data += self.eqset[i].random_block.tostring()
        return data
    
    def finalize(self):
        for Y in xrange(self.N,0,-1):
            for X in xrange(Y-1,0,-1):
                if self.eqset[X-1].bitlist[Y-1] == 1:
                    self.eqset[X-1].random_block ^= self.eqset[Y-1].random_block
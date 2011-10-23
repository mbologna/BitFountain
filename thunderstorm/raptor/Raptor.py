import psyco
psyco.full()
import math
import numpy
from numpy.core import multiarray as ma

from thunderstorm.eqsyssolver.EquationSet import EquationSet 
from thunderstorm.eqsyssolver.Equation import Equation
from thunderstorm.eqsyssolver.Matrix import Matrix
from thunderstorm.bitlistgen.LTlist import *
from thunderstorm.rdf.RandomDF import *

class Raptor(object):   
    def _setLDPCinSmtx(self):
        for i in xrange(0, self.K,1):
            a = int(1+((i/self.S)%(self.S-1)))
            b = i % self.S
            self.raptorSmtx.setbit(b,i)
            b = (b+a) % self.S
            self.raptorSmtx.setbit(b,i)
            b = (b+a) % self.S
            self.raptorSmtx.setbit(b,i)
        for i in xrange(0,self.S,1):
            self.raptorSmtx.setbit(i,self.K+i)
        
    def _setHALFinHmtx(self):
        gjH1 = Matrix(MAXRAPTORL*2,MAXRAPTORH)
        j = 0
        for i in xrange(0,1<<self.H,1):
            for h in xrange(0, MAXRAPTORH,1):
                gjH1.setitem(j, h, 0)
            gi = i^(i>>1)
            cnt = 0
            for h in xrange(0, self.H, 1):
                if gi&0x01:
                    gjH1.setbit(j,h)
                    cnt += 1
                gi >>=1
            if cnt == self.H1:
                j += 1
        for h in xrange(0, self.H, 1):
            for j in xrange(0, (self.K+self.S), 1):
                if gjH1.tstbit(j,h) == True:
                    self.raptorHmtx.setbit(h,j)
        
        for i in xrange(0, self.H, 1):
            self.raptorHmtx.setbit(i,self.K+self.S+i)
          
    def _raptor_precode(self, piece):
        assert len(piece) % self.blocksize == 0    
        es = EquationSet(self.L, self.blocksize) 
        
        for i in xrange(0, self.K, 1):
            block = ma.fromstring(piece[i*self.blocksize:i*self.blocksize+self.blocksize],numpy.uint8)
            e = Equation(LTlist(i,self.K,self.L,self.L1),block)
            es.puteq(e)
            
        block = ma.zeros(self.blocksize,numpy.uint8)
        for i in xrange(0, self.S, 1):
            e = Equation(self.raptorSmtx.getrow(i)[:self.L],block)
            es.puteq(e)
        for i in xrange(0, self.H, 1):
            e = Equation(self.raptorHmtx.getrow(i)[:self.L],block)
            es.puteq(e)
            
        assert es.done()
        return es.getdata()
    
    def _use_raptor_block(self, seqnum, rblock):
        self.C += 1
        e = Equation(LTlist(seqnum,self.K, self.L, self.L1),rblock)
        self.es.puteq(e)
        if self.C == self.K:
            block = ma.zeros(self.blocksize,numpy.uint8)
            for i in xrange(self.S):
                e = Equation(self.raptorSmtx.getrow(i)[:self.L],block)
                self.es.puteq(e)
            for i in xrange(self.H):
                e = Equation(self.raptorHmtx.getrow(i)[:self.L],block)
                self.es.puteq(e)
        return self.es.done()
    
    def _get_raptor_predecoded(self):
        return self.es.getdata()
        
    def _decode_raptor_piece(self,rpiece):
        assert len(rpiece) == self.L * self.blocksize
        piece = ma.zeros(self.blocksize*self.K,numpy.uint8)
        for i in xrange(0,self.K,1):
            bitlist = LTlist(i,self.K,self.L,self.L1)
            piece[i*self.blocksize:i*self.blocksize+self.blocksize] = create_random_block(bitlist,rpiece)
        return piece
    
    ################################################################################
    ################################################################################
    ################################################################################
    ################################################################################
    ################################################################################
    
    def __init__(self, K,blocksize=16384):
        assert K >= MINRAPTORK and K <= MAXRAPTORK
        self.K = K
        self.blocksize = blocksize
        self.raptorSmtx = Matrix(MAXRAPTORS,MAXRAPTORL)
        self.raptorHmtx = Matrix(MAXRAPTORH,MAXRAPTORL)
        self.X = int(math.ceil((1+math.sqrt(1+8*self.K))/2.0))
        self.K001 = int(math.ceil(self.K/100.0))
        for i in xrange(0,MAXIPRIME,1):
            if PRIMEtbl[i] >= (self.K001 + self.X):
                break
        self.S = PRIMEtbl[i]
        for h in xrange(0,K+self.S,1):
            if nchoosek(h,math.ceil(h/2.0)) >= K+self.S:
                break
        self.H = h
        self.H1 = int(math.ceil(self.H/2.0))
        self.L = self.K+self.S+self.H
        for i in xrange(0,MAXIPRIME,1):
            if PRIMEtbl[i] >= self.L:
                break
        self.L1 = PRIMEtbl[i]
        self._setLDPCinSmtx()
        self._setHALFinHmtx() 
        self.es = EquationSet(self.L, self.blocksize)
        self.C = 0
    
    def encode(self, seqnum, piece):
        if hasattr(self, 'rpiece') == False:
            self.rpiece = self._raptor_precode(piece)    
        return create_random_block(LTlist(seqnum, self.K, self.L, self.L1),self.rpiece)
    
    def decode(self, seqnum, block):
        block = ma.fromstring(block,numpy.uint8)
        return self._use_raptor_block(seqnum, block)
        
    def retrievedata(self):
        rpiecedec = self._get_raptor_predecoded()
        return self._decode_raptor_piece(rpiecedec)
    
    
    


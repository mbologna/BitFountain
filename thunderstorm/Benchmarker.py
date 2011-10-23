import psyco
psyco.full()

import random
import time
import sha
import os

from thunderstorm.raptor.Raptor import Raptor
from thunderstorm.rdf.RandomDF import *

if __name__ == '__main__':
    start = time.time()
    PIECESIZE = [64*1024,128*1024,256*1024,512*1024,1024*1024,2*1024*1024,4*1024*1024]
    BLOCKSIZE = 16384
    MIN_REQ_BLOCKS = [p/BLOCKSIZE for p in PIECESIZE]
    ITERATIONS = 500
    PLOSSSIZE = [0,25,50,75,99]
    
    for PLOSS in PLOSSSIZE:
        t_enc_mean_rdf = []
        t_dec_mean_rdf = []
        ovh_mean_rdf = []
        ovh_mean_rr = []
        
        for piecesize in PIECESIZE:
            piece = os.urandom(piecesize)
            blocks = []
            for i in xrange(0, len(piece), BLOCKSIZE):
                blocks.append(piece[i:i+BLOCKSIZE])
            mean = []
            for m in xrange(ITERATIONS):    
                received = False
                transmitted = []
                receivedC = {}
                i = 0
                txsn = 0
                used = 0
    
                while not received:
                    transmitted.append(blocks[i])
                    txsn += 1
                    if random.randint(0,99) < PLOSS-1:
                        transmitted.pop()
                    else:
                        used += 1
                        receivedC[i] = transmitted.pop()
                        if len(receivedC) == len(blocks):
                            mean.append((used*100.0/(piecesize/BLOCKSIZE))-100)
                            received = True
                            print 'Round Robin transmission/receiving process finished (# of it.: ' + str(m+1) + ')'
                            print '\tpiecesize: ' + str(piecesize)
                            print '\tblocksize: ' + str(BLOCKSIZE)
                            print '\t# of blocks transmitted: ' + str(txsn)
                            print '\tLoss pr. %d%%, lost blocks: %d' %(PLOSS,txsn-used)
                            print '\t# of blocks received and used: ' + str(used)
                            print '\toverhead (%): ' + str((used*100.0/(piecesize/BLOCKSIZE))-100)
                    i += 1
                    i %= len(blocks)
            ovh_mean_rr.append(sum(mean)/len(mean))
            print '#' * 10

         
        for piecesize, K in zip(PIECESIZE, MIN_REQ_BLOCKS):
            t_enc = []
            t_dec = []
            ovh = []
            
            for m in xrange(ITERATIONS):
                piece = os.urandom(piecesize)
                transmitted = []
                decoded = False
                txsn = 0
                tenc = 0
                tdec = 0
                used = 0
                
                t1 = time.time()
                Y = RandomDF(K,BLOCKSIZE)
                t2 = time.time()
                tdec += (t2-t1)
                
                while decoded == False: 
                    ####################################################
                    # avoid encoding/decoding if packet is lost ########
                    if random.randint(0,99) < PLOSS-1:
                        txsn += 1
                        continue 
                    ####################################################
                    t1 = time.time() 
                    seed = random.getrandbits(32)
                    rblock = create_random_block(rand50list(seed, K),piece).tostring()
                    t2 = time.time()
                    tenc += (t2-t1)
                    transmitted.append((seed,rblock))    
                    txsn += 1
                    ####################################################
                    ####################################################
                    ####################################################
                    
                    used += 1
                    rxsn,block = transmitted.pop()
                    
                    t1 = time.time()
                    if Y.use_random_block(rxsn, block) == True:
                        piecedec = Y.retrievedata()
                        t2 = time.time()
                        tdec += (t2-t1)
                        if sha.new(piece).hexdigest() != sha.new(piecedec).hexdigest():
                            raise Exception
                        decoded = True
                        print 'Random DF encoding/decoding process finished (# of it.: ' + str(m+1) + ')'
                        print '\tpiecesize: ' + str(piecesize)
                        print '\tblocksize: ' + str(BLOCKSIZE)
                        print '\tencoding time (s): ' + str(tenc)
                        print '\t# of blocks transmitted: ' + str(txsn)
                        print '\tLoss pr. %d%%, lost blocks: %d' %(PLOSS,txsn-used)
                        print '\tdecoding time (s): ' + str(tdec)
                        print '\t# of blocks received and used: ' + str(used)
                        print '\toverhead (%): ' + str((used*100.0/(piecesize/BLOCKSIZE))-100)
                        t_enc.append(tenc/used * piecesize/BLOCKSIZE)
                        t_dec.append(tdec/used * piecesize/BLOCKSIZE)
                        ovh.append((used*100.0/(piecesize/BLOCKSIZE))-100)
                        break
                    t2 = time.time()
                    tdec += (t2-t1)
                print '#' * 10    
            t_enc_mean_rdf.append(sum(t_enc)/len(t_enc))
            t_dec_mean_rdf.append(sum(t_dec)/len(t_dec))
            ovh_mean_rdf.append(sum(ovh)/len(ovh))
        
        t_enc_mean_raptor = []
        t_dec_mean_raptor = []
        ovh_mean_raptor = []
        
        for piecesize, K in zip(PIECESIZE, MIN_REQ_BLOCKS):
            t_enc = []
            t_dec = []
            ovh = []
            
            for m in xrange(ITERATIONS):
                piece = os.urandom(piecesize)
                transmitted = []
                decoded = False
                txsn = 0
                tenc = 0
                tdec = 0
                used = 0
                
                t1 = time.time()
                X = Raptor(K,BLOCKSIZE)
                t2 = time.time()
                tenc += (t2-t1)
                
                t1 = time.time()
                Y = Raptor(K,BLOCKSIZE)
                t2 = time.time()
                tdec += (t2-t1)
                
                while decoded == False:
                    ####################################################
                    # avoid encoding/decoding if packet is lost ########
                    if random.randint(0,99) < PLOSS-1:
                        txsn += 1
                        continue 
                    ####################################################
                    t1 = time.time() 
                    rblock = X.encode(txsn, piece).tostring()
                    t2 = time.time()
                    tenc += (t2-t1)
                    transmitted.append((txsn,rblock))    
                    txsn += 1
                    ####################################################
                    ####################################################
                    ####################################################
                    
                    used += 1
                    rxsn,block = transmitted.pop()
                    
                    t1 = time.time()
                    if Y.decode(rxsn, block) == True:
                        piecedec = Y.retrievedata()
                        t2 = time.time()
                        tdec += (t2-t1)
                        if sha.new(piece).hexdigest() != sha.new(piecedec).hexdigest():
                            raise Exception
                        decoded = True
                        print 'Raptor DF encoding/decoding process finished (# of it.: ' + str(m+1) + ')'
                        print '\tpiecesize: ' + str(piecesize)
                        print '\tblocksize: ' + str(BLOCKSIZE)
                        print '\tencoding time (s): ' + str(tenc)
                        print '\t# of blocks transmitted: ' + str(txsn)
                        print '\tLoss pr. %d%%, lost blocks: %d' %(PLOSS,txsn-used)
                        print '\tdecoding time (s): ' + str(tdec)
                        print '\t# of blocks received and used: ' + str(used)
                        print '\toverhead (%): ' + str((used*100.0/(piecesize/BLOCKSIZE))-100)
                        t_enc.append(tenc/used * piecesize/BLOCKSIZE)
                        t_dec.append(tdec/used * piecesize/BLOCKSIZE)
                        ovh.append((used*100.0/(piecesize/BLOCKSIZE))-100)
                        break
                    t2 = time.time()
                    tdec += (t2-t1)
                print '#' * 10    
            t_enc_mean_raptor.append(sum(t_enc)/len(t_enc))
            t_dec_mean_raptor.append(sum(t_dec)/len(t_dec))
            ovh_mean_raptor.append(sum(ovh)/len(ovh))
    
        print t_enc_mean_rdf
        print t_dec_mean_rdf
        print t_enc_mean_raptor
        print t_dec_mean_raptor
        print ovh_mean_rdf   
        print ovh_mean_raptor
        print ovh_mean_rr   
           
        grapherinstr = """\
        piecesize = %s;
        blocks = %s;
        
        t_enc_mean_rdf = %s;
        t_enc_mean_raptor = %s;
        t_dec_mean_rdf = %s;
        t_dec_mean_raptor = %s;
        ovh_mean_rdf = %s;
        ovh_mean_raptor = %s;
        ovh_mean_rr = %s;
        
        figure
        hold on
        plot(blocks,t_enc_mean_rdf,'--rs','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','c','MarkerSize',4)
        plot(blocks,t_enc_mean_raptor,'--gs','LineWidth',2,'MarkerEdgeColor','b','MarkerFaceColor','y','MarkerSize',4)
        set(gca,'XTick',blocks)   
        ylabel('encoding time [s]')
        xlabel('# blocks')
        title('encoding time (block = %d bytes) - avg on %d iterations')
        h = legend('Random DF','Raptor DF','Location','NorthWest');
        set(h,'Interpreter','none')
        axis tight
        grid on
        
        figure
        hold on
        plot(blocks,t_enc_mean_rdf,'--rs','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','c','MarkerSize',4)
        plot(blocks,t_enc_mean_raptor,'--gs','LineWidth',2,'MarkerEdgeColor','b','MarkerFaceColor','y','MarkerSize',4)
        set(gca,'XTick',blocks)  
        set(gca,'XScale','Log') 
        ylabel('encoding time [s]')
        xlabel('# blocks')
        title('(semilog) encoding time (block = %d bytes) - avg on %d iterations')
        h = legend('Random DF','Raptor DF','Location','NorthWest');
        set(h,'Interpreter','none')
        axis tight
        grid on
        
        figure
        hold on
        plot(blocks,t_enc_mean_rdf,'--rs','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','c','MarkerSize',4)
        plot(blocks,t_enc_mean_raptor,'--gs','LineWidth',2,'MarkerEdgeColor','b','MarkerFaceColor','y','MarkerSize',4)
        set(gca,'XTick',blocks)  
        set(gca,'XScale','Log') 
        set(gca,'YScale','Log') 
        ylabel('encoding time [s]')
        xlabel('# blocks')
        title('(log) encoding time (block = %d bytes) - avg on %d iterations')
        h = legend('Random DF','Raptor DF','Location','NorthWest');
        set(h,'Interpreter','none')
        axis tight
        grid on
        
        figure
        hold on
        plot(blocks,t_dec_mean_rdf,'--rs','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','c','MarkerSize',4)
        plot(blocks,t_dec_mean_raptor,'--gs','LineWidth',2,'MarkerEdgeColor','b','MarkerFaceColor','y','MarkerSize',4)
        set(gca,'XTick',blocks)   
        ylabel('decoding time [s]')
        xlabel('# blocks')
        title('decoding time (block = %d bytes) - avg on %d iterations')
        h = legend('Random DF','Raptor DF','Location','NorthWest');
        set(h,'Interpreter','none')
        axis tight
        grid on
        
        figure
        hold on
        plot(blocks,t_dec_mean_rdf,'--rs','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','c','MarkerSize',4)
        plot(blocks,t_dec_mean_raptor,'--gs','LineWidth',2,'MarkerEdgeColor','b','MarkerFaceColor','y','MarkerSize',4)
        set(gca,'XTick',blocks) 
        set(gca,'XScale','Log')   
        ylabel('decoding time [s]')
        xlabel('# blocks')
        title('(semilog) decoding time (block = %d bytes) - avg on %d iterations')
        h = legend('Random DF','Raptor DF','Location','NorthWest');
        set(h,'Interpreter','none')
        axis tight
        grid on
        
        figure
        hold on
        plot(blocks,t_dec_mean_rdf,'--rs','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','c','MarkerSize',4)
        plot(blocks,t_dec_mean_raptor,'--gs','LineWidth',2,'MarkerEdgeColor','b','MarkerFaceColor','y','MarkerSize',4)
        set(gca,'XTick',blocks) 
        set(gca,'XScale','Log')   
        set(gca,'YScale','Log') 
        ylabel('decoding time [s]')
        xlabel('# blocks')
        title('(log) decoding time (block = %d bytes) - avg on %d iterations')
        h = legend('Random DF','Raptor DF','Location','NorthWest');
        set(h,'Interpreter','none')
        axis tight
        grid on
        
        figure
        hold on
        plot(blocks,ovh_mean_rr,'--rs','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','c','MarkerSize',4)
        set(gca,'XTick',blocks)    
        set(gca,'XScale','Log')   
        xlabel('# blocks')
        ylabel('overhead [%%]')
        title('(semilog) overhead (# of block used/min # of blocks to decode) - loss pr: %d - avg on %d iterations')
        h = legend('Round Robin','Location','NorthWest');
        set(h,'Interpreter','none')
        axis tight
        grid on
        
        figure
        hold on
        plot(blocks,ovh_mean_rdf,'--rs','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','c','MarkerSize',4)
        plot(blocks,ovh_mean_raptor,'--gs','LineWidth',2,'MarkerEdgeColor','b','MarkerFaceColor','y','MarkerSize',4)
        set(gca,'XTick',blocks)     
        xlabel('# blocks')
        ylabel('overhead [%%]')
        title('overhead (# of block used/min # of blocks to decode) - loss pr: %d - avg on %d iterations')
        h = legend('Random DF','Raptor DF','Location','NorthEast');
        set(h,'Interpreter','none')
        axis tight
        grid on
        
        figure
        hold on
        plot(blocks,ovh_mean_rdf,'--rs','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','c','MarkerSize',4)
        plot(blocks,ovh_mean_raptor,'--gs','LineWidth',2,'MarkerEdgeColor','b','MarkerFaceColor','y','MarkerSize',4)
        set(gca,'XTick',blocks)    
        set(gca,'XScale','Log')   
        xlabel('# blocks')
        ylabel('overhead [%%]')
        title('(semilog) overhead (# of block used/min # of blocks to decode) - loss pr: %d - avg on %d iterations')
        h = legend('Random DF','Raptor DF','Location','NorthEast');
        set(h,'Interpreter','none')
        axis tight
        grid on
        
        figure
        hold on
        plot(blocks,ovh_mean_rr,'--bs','LineWidth',2,'MarkerEdgeColor','b','MarkerFaceColor','r','MarkerSize',4)
        plot(blocks,ovh_mean_rdf,'--rs','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','c','MarkerSize',4)
        plot(blocks,ovh_mean_raptor,'--gs','LineWidth',2,'MarkerEdgeColor','b','MarkerFaceColor','y','MarkerSize',4)
        set(gca,'XTick',blocks)    
        set(gca,'XScale','Log')   
        xlabel('# blocks')
        ylabel('overhead [%%]')
        title('(semilog) overhead (# of block used/min # of blocks to decode) - loss pr: %d - avg on %d iterations')
        h = legend('Round Robin','Random DF','Raptor DF','Location','NorthWest');
        set(h,'Interpreter','none')
        axis tight
        grid on
        """ % (str(PIECESIZE), str(MIN_REQ_BLOCKS),\
               str(t_enc_mean_rdf), str(t_enc_mean_raptor),\
               str(t_dec_mean_rdf), str(t_dec_mean_raptor),\
               str(ovh_mean_rdf), str(ovh_mean_raptor),str(ovh_mean_rr),\
               BLOCKSIZE, ITERATIONS,\
               BLOCKSIZE, ITERATIONS,\
               BLOCKSIZE, ITERATIONS,\
               BLOCKSIZE, ITERATIONS,\
               BLOCKSIZE, ITERATIONS,\
               BLOCKSIZE, ITERATIONS,\
               PLOSS, ITERATIONS,\
               PLOSS, ITERATIONS,\
               PLOSS, ITERATIONS,\
               PLOSS, ITERATIONS)      
         
        fd = open('grapher'+str(PLOSS)+'.m','w')
        fd.write(grapherinstr)
        fd.close() 
            
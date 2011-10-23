        piecesize = [65536, 131072, 262144, 524288, 1048576, 2097152, 4194304];
        blocks = [4, 8, 16, 32, 64, 128, 256];
        
        t_enc_mean_rdf = [0.00099823648279363472, 0.0041647916258817138, 0.013877052730984158, 0.047841220743515912, 0.18376352496648662, 0.68730691602134819, 2.7090159137889103];
        t_enc_mean_raptor = [0.0097467009226481129, 0.018824249325376567, 0.040675718020769504, 0.06880305761109487, 0.17842732166534553, 0.43659499492738119, 1.2514622818354018];
        t_dec_mean_rdf = [0.00090541276064786053, 0.0027647986186041607, 0.012735988267886092, 0.051389694570048071, 0.18940479782625275, 0.73571108438745436, 3.1941249506018972];
        t_dec_mean_raptor = [0.0085999774932861324, 0.015729261648775351, 0.040364795884275752, 0.078089075207497763, 0.16685420246979477, 0.42802826531111055, 1.177582401368096];
        ovh_mean_rdf = [65.0, 27.5, 8.75, 12.5, 2.1875, 1.09375, 0.390625];
        ovh_mean_raptor = [20.0, 22.5, 7.5, 3.75, 2.8125, 1.40625, 1.015625];
        ovh_mean_rr = [50.0, 187.5, 221.25, 187.5, 230.0, 393.125, 376.71875];
        
        figure
        hold on
        plot(blocks,t_enc_mean_rdf,'--rs','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','c','MarkerSize',4)
        plot(blocks,t_enc_mean_raptor,'--gs','LineWidth',2,'MarkerEdgeColor','b','MarkerFaceColor','y','MarkerSize',4)
        set(gca,'XTick',blocks)   
        ylabel('encoding time [s]')
        xlabel('# blocks')
        title('encoding time (block = 16384 bytes) - avg on 5 iterations')
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
        title('(semilog) encoding time (block = 16384 bytes) - avg on 5 iterations')
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
        title('(log) encoding time (block = 16384 bytes) - avg on 5 iterations')
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
        title('decoding time (block = 16384 bytes) - avg on 5 iterations')
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
        title('(semilog) decoding time (block = 16384 bytes) - avg on 5 iterations')
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
        title('(log) decoding time (block = 16384 bytes) - avg on 5 iterations')
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
        ylabel('overhead [%]')
        title('(semilog) overhead (# of block used/min # of blocks to decode) - loss pr: 75 - avg on 5 iterations')
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
        ylabel('overhead [%]')
        title('overhead (# of block used/min # of blocks to decode) - loss pr: 75 - avg on 5 iterations')
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
        ylabel('overhead [%]')
        title('(semilog) overhead (# of block used/min # of blocks to decode) - loss pr: 75 - avg on 5 iterations')
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
        ylabel('overhead [%]')
        title('(semilog) overhead (# of block used/min # of blocks to decode) - loss pr: 75 - avg on 5 iterations')
        h = legend('Round Robin','Random DF','Raptor DF','Location','NorthWest');
        set(h,'Interpreter','none')
        axis tight
        grid on
        
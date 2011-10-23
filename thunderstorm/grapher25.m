        piecesize = [65536, 131072, 262144, 524288, 1048576, 2097152, 4194304];
        blocks = [4, 8, 16, 32, 64, 128, 256];
        
        t_enc_mean_rdf = [0.0016267140706380211, 0.0034408116581464052, 0.012748641298528304, 0.052245451458726243, 0.20016954649927388, 0.72924176969590937, 2.8335139512324288];
        t_enc_mean_raptor = [0.011600017547607422, 0.018600068429503777, 0.036141188037243747, 0.065387939259330216, 0.17196933051031243, 0.44196653685998477, 1.2072062796100749];
        t_dec_mean_rdf = [0.0014933045705159507, 0.0033748624782369589, 0.01543730044225503, 0.056284743372890703, 0.20041208236567254, 0.77756692853959553, 3.4004148450707428];
        t_dec_mean_raptor = [0.010799932479858398, 0.019456492048321349, 0.038287266120083929, 0.071781774255681149, 0.16560682057795184, 0.44698743196345536, 1.167056075797039];
        ovh_mean_rdf = [25.0, 17.5, 6.25, 5.625, 4.0625, 1.71875, 0.859375];
        ovh_mean_raptor = [0.0, 15.0, 12.5, 4.375, 3.75, 1.25, 0.546875];
        ovh_mean_rr = [20.0, 47.5, 108.75, 98.125, 195.3125, 201.09375, 238.4375];
        
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
        title('(semilog) overhead (# of block used/min # of blocks to decode) - loss pr: 25 - avg on 5 iterations')
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
        title('overhead (# of block used/min # of blocks to decode) - loss pr: 25 - avg on 5 iterations')
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
        title('(semilog) overhead (# of block used/min # of blocks to decode) - loss pr: 25 - avg on 5 iterations')
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
        title('(semilog) overhead (# of block used/min # of blocks to decode) - loss pr: 25 - avg on 5 iterations')
        h = legend('Round Robin','Random DF','Raptor DF','Location','NorthWest');
        set(h,'Interpreter','none')
        axis tight
        grid on
        
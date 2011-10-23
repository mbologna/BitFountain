        piecesize = [65536, 131072, 262144, 524288, 1048576, 2097152, 4194304];
        blocks = [4, 8, 16, 32, 64, 128, 256];
        
        t_enc_mean_rdf = [0.00082858630589076451, 0.004714500802194971, 0.012564250098334418, 0.060180049897373536, 0.19052213422068348, 0.68975104479826699, 2.7723248886048402];
        t_enc_mean_raptor = [0.0092666943868001291, 0.015477557563929942, 0.040024228501164057, 0.075517690882963298, 0.18141831520276192, 0.47814249920148405, 1.2394944701646955];
        t_dec_mean_rdf = [0.0021428448813302177, 0.0029042728945740267, 0.013684648937649197, 0.050749064171802985, 0.17799399433713972, 0.73768683475614938, 3.2573526099179873];
        t_dec_mean_raptor = [0.0099999268849690747, 0.016396771722184473, 0.040937121148202929, 0.073270550896139708, 0.1668306549001129, 0.48508977281528354, 1.1654448834280529];
        ovh_mean_rdf = [15.0, 25.0, 10.0, 5.0, 1.5625, 0.9375, 1.015625];
        ovh_mean_raptor = [20.0, 37.5, 8.75, 1.25, 1.25, 0.78125, 0.546875];
        ovh_mean_rr = [65.0, 115.0, 133.75, 138.125, 230.3125, 287.1875, 315.46875];
        
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
        title('(semilog) overhead (# of block used/min # of blocks to decode) - loss pr: 50 - avg on 5 iterations')
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
        title('overhead (# of block used/min # of blocks to decode) - loss pr: 50 - avg on 5 iterations')
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
        title('(semilog) overhead (# of block used/min # of blocks to decode) - loss pr: 50 - avg on 5 iterations')
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
        title('(semilog) overhead (# of block used/min # of blocks to decode) - loss pr: 50 - avg on 5 iterations')
        h = legend('Round Robin','Random DF','Raptor DF','Location','NorthWest');
        set(h,'Interpreter','none')
        axis tight
        grid on
        
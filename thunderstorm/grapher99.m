        piecesize = [65536, 131072, 262144, 524288, 1048576, 2097152, 4194304];
        blocks = [4, 8, 16, 32, 64, 128, 256];
        
        t_enc_mean_rdf = [0.0010819012778145926, 0.0034206129546858312, 0.012437830831771506, 0.048688764475812815, 0.18037448058317312, 0.68886904976431929, 2.7603845659588204];
        t_enc_mean_raptor = [0.0071466615464952253, 0.019942179815474647, 0.038881074598986216, 0.068200010905275277, 0.17250481076690516, 0.44423496853686828, 1.2939527263152673];
        t_dec_mean_rdf = [0.0011486539386567616, 0.0030376303909171341, 0.011954709143068957, 0.049333653855977468, 0.18177997017795944, 0.73293224412946545, 3.2670491794101721];
        t_dec_mean_raptor = [0.0074132792154947922, 0.019828190392269678, 0.03809277875996718, 0.074919341421227567, 0.16296660610148694, 0.44357193097800957, 1.2547293630894945];
        ovh_mean_rdf = [35.0, 25.0, 12.5, 8.75, 1.5625, 2.34375, 0.625];
        ovh_mean_raptor = [75.0, 25.0, 12.5, 10.625, 3.125, 0.9375, 0.546875];
        ovh_mean_rr = [75.0, 152.5, 195.0, 359.375, 305.625, 422.5, 491.328125];
        
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
        title('(semilog) overhead (# of block used/min # of blocks to decode) - loss pr: 99 - avg on 5 iterations')
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
        title('overhead (# of block used/min # of blocks to decode) - loss pr: 99 - avg on 5 iterations')
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
        title('(semilog) overhead (# of block used/min # of blocks to decode) - loss pr: 99 - avg on 5 iterations')
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
        title('(semilog) overhead (# of block used/min # of blocks to decode) - loss pr: 99 - avg on 5 iterations')
        h = legend('Round Robin','Random DF','Raptor DF','Location','NorthWest');
        set(h,'Interpreter','none')
        axis tight
        grid on
        
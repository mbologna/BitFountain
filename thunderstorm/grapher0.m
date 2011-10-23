        piecesize = [65536, 131072, 262144, 524288, 1048576, 2097152, 4194304];
        blocks = [4, 8, 16, 32, 64, 128, 256];
        
        t_enc_mean_rdf = [0.001279926300048828, 0.0040645960605505743, 0.010970620023125752, 0.047288937038845479, 0.18199445230977518, 0.69896194448908955, 2.811273238860684];
        t_enc_mean_raptor = [0.015799903869628908, 0.023599958419799803, 0.043200159072875978, 0.069399976730346674, 0.19200005531311035, 0.51819992065429688, 1.3089998245239258];
        t_dec_mean_rdf = [0.001280059814453125, 0.0054667641418148774, 0.016772602003876352, 0.051959509801382975, 0.17994005845698999, 0.73848494153827438, 3.3364178854803273];
        t_dec_mean_raptor = [0.011600112915039063, 0.020400047302246094, 0.03859987258911133, 0.068999958038330075, 0.17879986763000488, 0.48200011253356934, 1.3083999633789063];
        ovh_mean_rdf = [55.0, 20.0, 12.5, 8.75, 1.5625, 0.46875, 1.25];
        ovh_mean_raptor = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
        ovh_mean_rr = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
        
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
        title('(semilog) overhead (# of block used/min # of blocks to decode) - loss pr: 0 - avg on 5 iterations')
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
        title('overhead (# of block used/min # of blocks to decode) - loss pr: 0 - avg on 5 iterations')
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
        title('(semilog) overhead (# of block used/min # of blocks to decode) - loss pr: 0 - avg on 5 iterations')
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
        title('(semilog) overhead (# of block used/min # of blocks to decode) - loss pr: 0 - avg on 5 iterations')
        h = legend('Round Robin','Random DF','Raptor DF','Location','NorthWest');
        set(h,'Interpreter','none')
        axis tight
        grid on
        
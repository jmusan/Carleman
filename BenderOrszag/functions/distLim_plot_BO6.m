function [Yeq_plot,Yeq_teo_plot,isPlot_eq] = distLim_plot_BO6(y0eq,y1_eq,y2_eq,Lim)

    Yeq_plot{length(y0eq(:,1))} = {}; 
    Yeq_teo_plot{length(y0eq(:,1))} = {};
    isPlot_eq{length(y0eq(:,1))} = {};
    
    maxT = 40;

    warning('off','all');
    for i = 1:length(y0eq(:,1))
        [t_num_forw,y_num_forw] = ode78(@(t,y) ex6(t,y),[0 maxT],y0eq(i,:),odeset("Events",@stopInt,'AbsTol',10^-10,'RelTol',10^-10));
        [t_num_back,y_num_back] = ode78(@(t,y) ex6(t,y),[0 -maxT],y0eq(i,:),odeset("Events",@stopInt,'AbsTol',10^-10,'RelTol',10^-10));
        t_num = [flipud(t_num_back(2:end,:)); t_num_forw]; y_teo = [flipud(y_num_back(2:end,:)); y_num_forw];   
        
        y1 = y1_eq(t_num,y0eq(i,1),y0eq(i,2));
        y2 = y2_eq(t_num,y0eq(i,1),y0eq(i,2));
        
        dist = sqrt((y_teo(:,1)-y1).^2 + (y_teo(:,2)-y2).^2)./mean(abs(y_teo),2);
        isPlot = (dist<Lim);
        isPlot_line = isPlot; t = t_num;
        isPlot_line([1:(find(t == 0)-find(~flipud(isPlot_line(t < 0)),1)) (find(t == 0)+find(~isPlot_line(t > 0),1)):end]) = false;
        isPlot_line((find(t == 0)-find(~flipud(isPlot_line(t < 0))+1,1)):(find(t == 0)+find(~isPlot_line(t > 0),1)-1)) = true;
        isPlot_corrected = logical(isPlot_line);
        % isPlot_corrected = isPlot;

        Yeq_teo_plot{i} = [t_num(isPlot_corrected) y_teo(isPlot_corrected,:)];
        Yeq_plot{i} = [t_num(isPlot_corrected) y1(isPlot_corrected) y2(isPlot_corrected)];
        isPlot_eq{i} = isPlot_corrected;

    end
    warning('on','all');

end
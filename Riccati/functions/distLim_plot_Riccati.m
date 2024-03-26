function [Y_plot,isPlot] = distLim_plot_Riccati(t,yteo,yexp,Lim)

    dist = sqrt((yteo(:,1)-yexp(:,1)).^2)./abs(yteo(:,1));
    isPlot = (dist<Lim);
    Y_plot = [t(isPlot) yexp(isPlot,:) abs(yexp(isPlot,:)-yteo(isPlot,:))];

end
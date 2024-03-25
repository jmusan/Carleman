function [value, isterminal, direction] = stopInt(~,y)
        
    value = (y(1)+y(2)<1000);
    isterminal = 1;
    direction = 0;
    
end
function dydt = ex6(~,y)

    dydt = zeros(2,1);

    dydt(1) = y(1)^2-y(1)*y(2)-y(1);           
    dydt(2) = y(2)^2+y(1)*y(2)-2*y(2);
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                   %
%   CARLEMAN MatA_u0-                                               %
%   jc.munoz@csic.es                                                %
%   2023                                                            %
%                                                                   %               
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [A,Vars,X_0,b] = MatA_u0(N,c,u0)

    E = string(num2str(zeros(N,1)));
    for i = 1:N
        E(i) = string(num2str(i));
    end    
    Vars = genvarname(E);
    
    % Creo las ecuaciones para las derivadas de estas variables
    eqs = sym(zeros(length(Vars),1));
    for w = 1:length(Vars)
        
        e = char(E(w));
        i = str2double(e(1:end));
    
        eqs(w,1) = i*str2sym("x"+num2str(i+1)) ...
                  +i*(2*u0-1)*str2sym("x"+num2str(i)) ...
                  +i*(u0^2-u0)*str2sym("x"+num2str(i-1));               
    end
    
    % equationsToMatrix: para poner el sistema en forma de matriz
    A = equationsToMatrix(eqs,Vars);
%     A = double(equationsToMatrix(eqs,Vars));
    
    %Vector de condiciones iniciales
    X_0 = sym(zeros(length(Vars),1));
%     X_0 = zeros(length(Vars),1);
    for w = 1:length(Vars)    
        e = char(Vars(w));    
        i = str2double(e(2:end));
        X_0(w,1) = (c-u0)^i;       
    end
    b = sym(zeros(size(X_0)));
%     b = zeros(size(X_0));
    b(Vars == 'x1') = u0^2-u0;

end
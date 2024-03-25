%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                   %
%   CARLEMAN MatA_u-                                                %
%   jc.munoz@csic.es                                                %
%   2022                                                            %
%                                                                   %               
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [A,Vars,X_0] = MatA_u(N, c)

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
    
        eqs(w,1) = -i*str2sym("x"+num2str(i)) +i*str2sym("x"+num2str(i+1));       
        %Crear las ecuaciones con las variables simbólicas y guardarlo en un
        %vector length(Vars)x1. Si no existe la variable simbólica (porque es
        %de un orden superior al que estamos) se omite
        
    end
    
    % equationsToMatrix: para poner el sistema en forma de matriz
    A = equationsToMatrix(eqs,Vars);
    
    %Vector de condiciones iniciales
    X_0 = sym(zeros(length(Vars),1));
    for w = 1:length(Vars)    
        e = char(Vars(w));    
        i = str2double(e(2:end));
        X_0(w,1) = c^i;       
    end

end
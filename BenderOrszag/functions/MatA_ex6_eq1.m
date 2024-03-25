%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                   %
%   CARLEMAN MatA_ex6_eq1.-                                         %
%   jc.munoz@csic.es                                                %
%   2023                                                            %
%                                                                   %               
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [A,Vars,X_0] = MatA_ex6_eq1(N,a,b)

    E = zeros(sum(2:N+1),2);
    w = 1;
    for i = 1:N+1
        for j = 1:N+1
           E(w,:) = [i-1,j-1];
           w = w+1;
        end
    end    
    E(1,:) = [];
    E = E(sum(E,2)<=N,:);
    Vars = genvarname(join(string(E)));
    
    % Creo las ecuaciones para las derivadas de estas variables
    eqs = sym(zeros(length(Vars),1));
    for w = 1:length(Vars)
        i = E(w,1);
        j = E(w,2);
        eqs(w,1) = -(i+2*j)*str2sym("x"+num2str(i)+num2str(j)) + ...
            (i+j)*str2sym("x"+num2str(i+1)+ num2str(j)) +(j-i)*str2sym("x"+num2str(i)+num2str(j+1));               
    end    
    % equationsToMatrix: para poner el sistema en forma de matriz
    A = equationsToMatrix(eqs,Vars);
    
    %Vector de condiciones iniciales
    X_0 = sym(zeros(length(Vars),1));
    for w = 1:length(Vars)    
        i = E(w,1);
        j = E(w,2);
        X_0(w,1) = a^i*b^j;       
    end

end
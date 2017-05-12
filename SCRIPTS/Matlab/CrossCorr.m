% Funcion para calcular la correlacion cruzada (rho) de dos vectores v1 y v2
% dados. Además, vuelve el p-value asociado a cada valor de rho.

% Para ello, va desplazando punto a punto v2 sobre v1 y calculando la
% correlacion.

%       1º step:    
%         v1                   ------------------
%         v2   -----------------

%       [...]


%       5º step:
%         v1                     ------------------
%         v2      --------------------


%       [...]

%       Last step:
%         v1                ------------------
%         v2                                 ------------------


% IMPORTANTE: Solo devuelve el valor maximo de correlacion rho y su valor p
% asociado.
% Si queremos obtener el vector que contiene rho y p para cada punto,
% debemos devolver también las variables rho_aux y p_aux.


function [rho_cross, p_cross] = CrossCorr(v1,v2)
    % v1 = sample
    % v2 = referencia
    rho_cross=0; p_cross=0;
    
    if length(v1) ==  length(v2)
        long = 2*length(v2);
    else
        long = length(v2);
    end
    
    for i = 1:2*length(v2)
        % Vamos desplazando el vector y rellenando de 0s los huecos
        if i < length(v2)
            v2_aux = [v2(end-i:end),zeros(1,length(v2)-i-1)];
        else
            v2_aux = [zeros(1,i-length(v2)),v2(1:end-(i-300))];
        end
    
        [rho,p] = corr(v2_aux',v1');
        %plot(t,v1), hold on, plot(t,v2_aux,'r');
        rho_aux(1,i) = rho; 
        p_aux(1,i) = p;
    end
        
    if v1==v2
        pos = 300;
    else
        pos = max(find(rho_aux == max(rho_aux)));
    end
    p_cross = p_aux(1,pos);
    rho_cross = max(rho_aux);
end

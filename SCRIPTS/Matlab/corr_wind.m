
% Adaptacion de la funcion corr para calcular la correlacion entre ventanas
% de 2 vectores.

function [rw, pw] = corr_wind(v1,v2,w)
% w = tamaño de la ventana
    for k=1:length(v1)/w
                [r, p] = corr(v1(1,k*w-9:k*w)',v2(1,k*w-9:k*w)');
                rw(1,k) = r;
                pw(1,k) = p;
    end
end

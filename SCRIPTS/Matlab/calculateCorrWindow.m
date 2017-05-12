
function corr_window = calculateCorrWindow(v1,v2,w)

% A esta funcion le paso los 2 matrices sobre los que calcular la
% correlacion entre sus vectores (a traves de la funcion corr_wind), 
% solo que en lugar de
% calcular la correlacion de todo el vector punto a punto, calcula la
% correlacion en ventanas (de tamaño w) analogas entre ambos vectores.

% Los datos de salida se almacenan en un formato celda, con la siguiente
% informacion en cada columna:
    corr_window = cell(length(w)+1,5);

    % Define each column
    corr_window{1,1} = 'Win. size';
    corr_window{1,2} = 'r_vector';
    corr_window{1,3} = 'p_vector';
    corr_window{1,4} = 'r_max(p_min)';
    corr_window{1,5} = 'p_min';
    corr_window{1,6} = 'mean(r_vector)';

    
    % Index of size window
    for q=1:length(w)
        corr_window{q+1,1} = w(1,q);
    end


   % if Xcorr == 0
        % Calculate r and p-values
        for k=1:length(w)                   % Selecciono la ventana k del vector
            for j = 1:size(v1,1)            % Recorro los vectores de v1
                for i = 1:size(v1,1)        % Recorro los vectores de v2
                    
                    % Calculo la correlación de la ventana k del vector j de
                    % la matriz v1 con la ventana k del vector i de v2.
                    [rw_aux, pw_aux] = corr_wind(v1(j,:),v2(i,:),w(k));
                    
                    % Si las matrices v1 y v2 son iguales, cuando i=j los
                    % vectores seran el mismo. 
                    if v1(j,:) == v2(i,:)
                        pos = 1;
                    else
                        pos = find(pw_aux == min(pw_aux));
                    end
                    
                    % Y guardamos los valores.
                    % Matrix for each window size
                    rw_vector{j,i} = rw_aux;
                    pw_vector{j,i} = pw_aux;
                    p_w(j,i) = min(pw_aux);
                    r_w(j,i) = rw_aux(1,pos);
                    mean_rw_v(j,i) = mean(rw_vector{j,i});
                end
            end
            
            % Cell for all window size
            corr_window{k+1,2} = rw_vector;
            corr_window{k+1,3} = pw_vector;
            corr_window{k+1,4} = r_w;
            corr_window{k+1,5} = p_w;
            corr_window{k+1,6} = mean_rw_v;
        end          
end
function [Xcorr_rw_v, Xcorr_pw_v,Xcorr_rw,Xcorr_pw, Xcorr_mean_rw] = calculateXCorrWindow(v1,v2,w)

% Dado un tamaÃ±o de ventana w, el vector v1 o v2 puede dividirse en un nº
% de ventanas k=length(v1)/w.

% Este script calcula, para cada una de esas ventanas de tamaño w, un
% sliding-correlation window. Enventananado v1 y desplazando punto a punto
% sobre v2, se calcula la correlacion y el p-value en cada uno de esos
% puntos. Los outputs por lo tanto son:
%   - Xcorr_rw_v = Matriz de valores de r para cada punto, cada vector representa r entre la ventana k y v2.
%   - Xcorr_pw_v = Matriz de p-values asociados a cada r de Xcorr_rw_v.
%   - Xcorr_rw = Para p-values < 0.01, el mayor valor de correlacion
%                encontrado; cada valor representa r_mean entre la ventana k y v2.
%   - Xcorr_pw = P-value asociado a Xcorr_rw; cada valor representa r_mean entre la ventana k y v2.
%   - Xcorr_mean_rw = Valor medio de r; cada valor representa r_mean entre la ventana k y v2.

    %for t=1:length(w)
            for j = 1:size(v1,1)
                for i = 1:size(v1,1)
                    n = 1;
                    for k=1:length(v1)/w
                        x1 = v1(j, k*w-9:k*w);
                        [rw_aux2, pw_aux2] = Xcorr_w(x1,v2(i,:));
        
                        if v1(j,:) == v2(i,:)
                            pos = 1;
                        else
                            pos = find(pw_aux2 == min(pw_aux2));
                        end
                
                        % Para cada par de ts (i,j), se generan n vectores, 
                        % donde n = length(v2)/w(k);
                        windows_rv(n,:) = rw_aux2;
                        windows_pv(n,:) = pw_aux2;
                        windows_r(n,:) = rw_aux2(pos);
                        windows_p(n,:) = pw_aux2(pos);
                        windows_mean(n,:) = mean(rw_aux2);
                        n = n+1;
                    end
                
                    % La matriz windows_x se genera para cada par de vectores
                    % (i,j), es decir, se generan 11x11 celdas, donde cada
                    % celda contiene una matriz windows_x de nx: elementos:
                    Xcorr_rw_v{j,i} = windows_rv;
                    Xcorr_pw_v{j,i} = windows_pv;
                    Xcorr_rw{j,i} = windows_r;
                    Xcorr_pw{j,i} = windows_p;
                    Xcorr_mean_rw{j,i} = windows_mean;
                end
            end
            
            % Y, por ultimo, esto se guarda para cada tamaÃ±o de ventana, 
            %corr_window{k+1,2} = rw_vector_aux;
            %corr_window{k+1,3} = pw_vector_aux;
            %corr_window{k+1,4} = rw_aux;
            %corr_window{k+1,5} = pw_aux;
            %corr_window{k+1,6} = mean_rw_aux;
        %end
end

%% FFT - Spectrum parameters:

% Esta funcion esta optimizada para el caso de los 11 ROIs de cerdo. Para
% otros usos, repasar parametrizacion de tamaño de matrices, 'names', y nº de subplots.

function SIGNALS = Spect(Fs, signals)%, names)
T=1/Fs;
L=length(signals);                          % Longitud de la señal
t=(0:L-1)*T;                                % Vector de tiempos
%NFFT = 2^nextpow2(L);                      % Next power of 2 from length of roi_ts (512)
f = Fs/2*linspace(0,1,L/2+1);               %NFFT/2 + 1); % Vector de frecuencias

SIGNALS = zeros(size(signals));             %NFFT);

figure, suptitle('FFT(ROIs)'), hold on;
n_rows = fix(size(signals,1)/3);                 % Plot de 3 columnas
n_col = fix(size(signals,1)/n_rows)+1;      % Y filas=plots_totales/3

for k=1:size(signals,1)
    SIGNALS(k,:) = fft(signals(k,:),L)/L;   %NFFT)/L;  % NFFT proporciona las dimensiones
    Y = SIGNALS(k,:);
    subplot(n_rows, n_col, k);
    plot(f,2*abs(Y(1:L/2+1)),'b');          %NFFT/2 +1)));
    hold on;
    xlabel('Frequency (Hz)');
    ylabel('|Y(f)|');
    %title(names(1*(k)));                    % Selecciono nombre de la cell "names"
 
end
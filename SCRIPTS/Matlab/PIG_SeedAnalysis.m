% Script para realizar un seed-based analysis entre distintas ROIS de cerdo.

% El c�digo hace:
%   1. Cargar timeseries de las ROIs --> matriz roi_ts
%   2. Representacion en frecuencia --> ver frecuencias de corte
%   3. Filtro a partir de las frecuencias de corte seleccionadas
%   4. Cálculo de correlaciones entre ROIs (Pearson) + p-value
%   5. Cálculo de correlación cruzada entre ROIs + p-value (2 metodos)
%   6. Calculo de correlacion con ventanas (window-sliding)
%   7. Cálculo correlaciones cruzadas con ventanas pequeñas? (en funcion de
%   resultados del paso 6)

clear all
close all
clc

%% 1. LOAD DATA
% Cargamos Timeseries extraidas de las mascaras del funcional:
[roi_ts, names] = ROIpigs;

% IMPORTANTE!!: Colocar roi_ts de forma que cada fila sea el timeseries de
% un ROI (nº ROIs x puntos timeseries. Si no, modificar los bucles: 
% size(roi_ts,1) --> size(roi_ts,2)


%% 2. FFT
% Representamos su espectro para comprobar el filtrado:
%ROI_ts = Spect(Fs, signals);
%ROI_ts = Spect(0.5, roi_ts, names);  %Fs = 0.5 -> TR=2

%% 3. FILTER




%% 4. CORRELATIONS
for j = 1:size(roi_ts,1)
    for i = 1:size(roi_ts,1)
        [r(i,j), p(i,j)] = corr(roi_ts(j,:)',roi_ts(i,:)');
    end
end

%% 5. CROSS-CORR

for j = 1:size(roi_ts,1)
    for i = 1:size(roi_ts,1)
        % CROSS - CORR NORMALIZED (DANI)
        % help: r = getCrossCorrelation(Sample, Ref)
        % Devuelve el valor maximo de correlacion para 2 vectores dados
        r_aux = getCrossCorrelation(roi_ts(j,:),roi_ts(i,:));
        Xcorr_r(j,i) = r_aux;
        % hay que hacer la transformada a p-value
        
        % CROSS - CORR STEP BY STEP (with p-value)
        % help: [rho_cross, p_cross] = CrossCorr(v1,v2)
        % Devuelve el valor maximo de correlacion y su p-value asociado
        % para 2 vectores dados.
        [rho2, p2] = CrossCorr(roi_ts(j,:), roi_ts(i,:));
        Xcorr_r2(j,i) = rho2;
        Xcorr_p2(j,i) = p2;
    end
end


%% 6. VENTANAS DE CORRELACION
% Correlacion normal (Step by step method)
w=[10,15,30,60,120];
corr_window = calculateCorrWindow(roi_ts, roi_ts, w);

% Correlacion cruzada
w=60;
[Xcorr_rw_v, Xcorr_pw_v, Xcorr_rw, Xcorr_pw, Xcorr_mean_rw] = calculateXCorrWindow(roi_ts, roi_ts, w);


clear r_aux rho2 p2 w i j
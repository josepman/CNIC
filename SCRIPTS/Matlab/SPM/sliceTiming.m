function sliceTiming(pwd, listaNiftis, nSlices, TR, order);

% Añadir al script la opcion de pedir cosas por teclado;

% Script para realizar el Slice-Timing Correction. Primero recopila los
% ficheros que queremos corregir, indica el SliceOrder, el timing y los
% distintos argumentos que necesitamos pasarle a la orden spm_slice_timing:

%help spm_slice_timing

    files = spm_select('List', pwd, 'listaNiftis.nii');

% AYUDA: '^r01.nii' Se queda solo con los ficheros que empiezan con r01

    % SliceOrder indica el orden de adquisicion de cada slice (ascendente,
    % descendente, interleaved...)
    if order==1
        % Ascendente: 
        sliceOrder = 1:35;
    elseif order==2
        % Descendente:
        sliceOrder = 35:-1:1;
    elseif order==3
        % Interleaved:
        sliceOrder = [1:2:35 2:2:35];
    elseif
        printf('Seleccione order correctamente')
    end
    
    %nSlices = 36;
    refSlice = 1;
    TR = 2;
    TA = TR - (TR/nSlices);     % Tiempo qe se tarda en adquirir todos los slices despues de adquirir el 1º
    time1 = TA/(nSlices-1);     % Tiempo de adquisicion entre slices
    time2 = TR-TA;
    timing = [time1 time2];
end
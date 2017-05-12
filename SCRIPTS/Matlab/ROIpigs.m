


function [roi_ts, names] = ROIpigs
        clear all
        clc

    %% DATA LOAD
    load ts_anteriorcingulatedcortexmask_func.txt; 
    load ts_csfmask_func.txt;
    load ts_graymask_func.txt;
    load ts_hipothalamusmask_func.txt;
    load ts_insularcortexmask_func.txt;
    load ts_motorcortexleftmask_func.txt;
    load ts_motorcortexrightmask_func.txt;
    load ts_occipitalmask_func.txt;
    load ts_periaqueductalmask_func.txt;
    load ts_posteriorcingulatedcortexmask_func.txt;
    load ts_prefrontalmask_func.txt;

    roi_ts=zeros(11,300);
    roi_ts(1,:)=ts_anteriorcingulatedcortexmask_func - mean(ts_anteriorcingulatedcortexmask_func);
    roi_ts(2,:)=ts_csfmask_func - mean(ts_csfmask_func);
    roi_ts(3,:)=ts_graymask_func - mean(ts_graymask_func);
    roi_ts(4,:)=ts_hipothalamusmask_func - mean(ts_hipothalamusmask_func);
    roi_ts(5,:)=ts_insularcortexmask_func - mean(ts_insularcortexmask_func);
    roi_ts(6,:)=ts_motorcortexleftmask_func - mean(ts_motorcortexleftmask_func);
    roi_ts(7,:)=ts_motorcortexrightmask_func - mean(ts_motorcortexrightmask_func);
    roi_ts(8,:)=ts_occipitalmask_func - mean(ts_occipitalmask_func);
    roi_ts(9,:)=ts_periaqueductalmask_func - mean(ts_periaqueductalmask_func);
    roi_ts(10,:)=ts_posteriorcingulatedcortexmask_func - mean(ts_posteriorcingulatedcortexmask_func);
    roi_ts(11,:)=ts_prefrontalmask_func - mean(ts_prefrontalmask_func);

    %roi_ts_sm = reshape(smooth(roi_ts),11,300);

    %ts_graymask_func = gpuArray(ts_graymask_func); %Para pasarlo a objeto de GPU
    %ts_graymask_func = gather(ts_graymask_func);    %Para pasar de objeto GPU a tipo double


    % Generamos lista de nombres
    names = cell(1,11);
    names{1,1} = 'ACC';
    names{1,2} = 'CSF';
    names{1,3} = 'GM';
    names{1,4} = 'Hipotalamus';
    names{1,5} = 'InsulaCortex';
    names{1,6} = 'MotorL';
    names{1,7} = 'MotorR';
    names{1,8} = 'Occipital';
    names{1,9} = 'Periaqueductal';
    names{1,10} = 'PCC';
    names{1,11} = 'Prefrontal';

end
function importDCM2NII(pwd,xxxx)

    % Script para convertir los DICOMS a NIFTII. Para ello hacemos uso del
    % compando spm_dicom_convert de SPM. Este comando necesita que le pasemos
    % como argumento los headers de la secuencia, por lo que primero los
    % extraemos y los guardamos en una lista con spm_select.

    % Seleccionamos los DICOMS que queramos en la carpeta pwd y nos la guarda como una lista
    % Esto nos guarda los img y los hdr
    files = spm_select('List', pwd, 'xxxx_.*'); 
    hdr = spm_dicom_headers(files); % nos quedamos con los hdr
    spm_dicom_convert(hdr); % Y convertimos los DICOMs a NIFTII

    % Los guardamos todos en un mismo NIFTII a traves de fsl
    % para utilizar comandos de fsl tenemos que tener el "spm path pointing
    % towards that directory (directory of fsl)"
    unix('/usr/local/fsl/bin/fslmerge -t output list_inputs*.nii')

    % unix sirve para ejecutar cualquier comando desde unix shell (para iOS tb?)

    % Realmente, el merge nos da un output con formato .nii.gz. Le podemos
    % eliminar el .gz con gunzip:
    unix('/usr/local/fsl/bin/gunzip output.nii.gz')

    %Podemos comprobar que estan todos los archivos y las dimensiones son
    %correctas a traves de AFNI o fsl:
    %!3dinfo output.nii
    %!fslhdinfo output.nii

end
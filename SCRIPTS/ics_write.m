function success=ics_write(volinfo,vol)
% volinfo: spm compatible volume info struct
% vol    : volume data in matrix form
% success: 0 if write could not be performed
%
% Fabian Wenzel 2006/05/11


[pth,fil,ext] = fileparts(volinfo.fname);

switch volinfo.dim(4)
    case 4*256 %int26
        tag_format='integer';
        tag_sign  ='signed';
        tag_bits  =16;
        tag_scil  ='g3d';
        datatype  ='int16';
    case 132*256 % uint16
        tag_format='integer';
        tag_sign  ='unsigned';
        tag_bits  =16;
        tag_scil  ='g3d';
        datatype  ='uint16';
    case 16*256  % float
        tag_format='real';
        tag_sign  ='signed';
        tag_bits  =32;
        tag_scil  ='f3d';
        datatype  ='float';
    case 64*256  % double
        tag_format='real';
        tag_sign  ='signed';
        tag_bits  =64;
        tag_scil  ='f3d';
        datatype  ='double';
    otherwise
        error('Unsupported data type %d\n',volinfo.dim(4));
        success=0; return;
end

% Write ics
filename = fullfile(pth,[fil '.ics']);
fid = fopen(filename,'wt');
if fid == -1,
    error('Cannot write file %s\n',filename);
    success=0; return;
end
fprintf(fid,'\nics_version 1.0\nfilename\t%s\n',fil);
fprintf(fid,'layout\tparameters\t4\nlayout\torder\tbits\tx\ty\tz\n');
fprintf(fid,'layout\tsizes\t%d\t%d\t%d\t%d\n',tag_bits,volinfo.dim(1),volinfo.dim(2),volinfo.dim(3));
fprintf(fid,'layout\tcoordinates\tvideo\nlayout\tsignificant_bits\t%d\n',tag_bits);
fprintf(fid,'representation\tformat\t%s\nrepresentation\tsign\t%s\n',tag_format,tag_sign);
fprintf(fid,'representation\tcompression\tuncompressed\n');
fprintf(fid,'representation\tbyte_order');
for i=1:tag_bits/8
    fprintf(fid,'\t%d',i);
end
fprintf(fid,'\nrepresentation\tSCIL_TYPE\t%s\n',tag_scil);
if isfield(volinfo,'ContentTime')
    fprintf(fid,'contentTime of 1st slice\t%s\n',volinfo.ContentTime);
end
fclose(fid);

% Write ids
filename = fullfile(pth,[fil '.ids']);
fid = fopen(filename,'wb','l');
if fid == -1,
    error('Cannot write file %s\n',filename);
    success=0; return;
end;
fwrite(fid,reshape(vol,1,[]),datatype);
fclose(fid);

% Write inf
filename = fullfile(pth,[fil '.inf']);
fid = fopen(filename,'wt');
if fid == -1,
    error('Cannot write file %s\n',filename);
    success=0; return;
end;

fprintf(fid,'VERSION 1\nGREY_LOGICAL_DEPTH %d\n',tag_bits);
fprintf(fid,'GEO_ORIGIN %f %f %f\n',volinfo.mat(1,4),volinfo.mat(2,4),volinfo.mat(3,4));
fprintf(fid,'GEO_EXTENT %d %d %d\n',abs(volinfo.mat(1,1))*volinfo.dim(1),abs(volinfo.mat(2,2))*volinfo.dim(2),abs(volinfo.mat(3,3)*volinfo.dim(3)));
fprintf(fid,'SIZE %d %d %d\n#SLICEGAP 0\n',volinfo.dim(1),volinfo.dim(2),volinfo.dim(3));
if isfield(volinfo,'iop')
    fprintf(fid,'GEO_AXIS_X %f %f %f\n',volinfo.iop(1,1),volinfo.iop(2,1),volinfo.iop(3,1));
    fprintf(fid,'GEO_AXIS_Y %f %f %f\n',volinfo.iop(1,2),volinfo.iop(2,2),volinfo.iop(3,2));
    fprintf(fid,'GEO_AXIS_Z %f %f %f\n',volinfo.iop(1,3),volinfo.iop(2,3),volinfo.iop(3,3));
else
    fprintf(fid,'GEO_AXIS_X 1 0 0\nGEO_AXIS_Y 0 1 0\nGEO_AXIS_Z 0 0 1\n');
end
fclose(fid);

success=1;
return;


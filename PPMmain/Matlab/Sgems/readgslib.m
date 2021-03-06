%
% This function reads realizations in Gslib format and stores them in a
% matrix
%
% Author: Celine Scheidt
% Date: November 2007



function data = readgslib(filename,icol)
%% Input parameters:

%   - filename: Name of the file containing the realizations
%   - icol: realization index to return (optional)

%% Output parameters:

%   - data: matrix of dimensions [nx*ny*nz,nrealizations] containing the 
%           realizations (one column corresponds to one realization)  

    fid = fopen(filename, 'r');
    tline = textscan(fid,'%s (%fx%fx%f) ',1);

    % dimensions of the grid    
    nx = tline{2};
    ny = tline{3};
    nz = tline{4};

    ncol = fscanf(fid, '%d\n', 1);

    for i=1:ncol
        tline = fgetl(fid);
    end

    data  = fscanf(fid, '%f', [1 inf]);
    data = reshape(data,ncol,nx*ny*nz);
    data = data';

    if nargin == 2
        data = data(:,icol);
    end

fclose(fid);

%
% This function reads HGS output files (0.observation_well_flow.XX.dat) and returns the values of
% the desired property for steady state problem.
%
% Author: Thomas HERMANS
% Date: October 2012


function data = read_HGS_well(inputfile,prop)

%% Input parameters:

%   - inputfile: Name of the file to read, must be something like
%   [WorkingDirectory /prefixHGS 'o.observation_well_flow.P' num2str(i) '.dat']
%   - prop: Properties that should be returned, must be
%   "H","Q","X","Y","Z" or "Node"  

%% Output parameters:

%   - data: value of the output response 


    fid = fopen(inputfile,'r');
    % open the file for reading
    % Don't take the first line into account
    tline = fgetl(fid);
    tline = fgetl(fid);
 
    data_tot = fscanf(fid, '%f %f %f %f %f %f');

    switch prop
        case 'H'
            data = data_tot(1);
        case 'Q'
            data = data_tot(2);
        case 'X'
            data = data_tot(3);
        case 'Y'
            data = data_tot(4);
        case 'Z'
            data = data_tot(5);
        case 'Node'
            data = data_tot(6);
        otherwise
            error(['UNABLE TO READ PROPERTY: ' prop]);
    end

    fclose(fid);

end
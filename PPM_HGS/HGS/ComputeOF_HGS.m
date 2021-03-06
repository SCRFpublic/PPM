%
% This function computes the value of the objective function for a given realization

% Note:  The flow simulation is performed using HGS
%
% Author: Thomas Hermans
% Date: November 2012

function OF = ComputeOF_HGS(WorkingDirectory,facies_file,... 
    SimulationDeck,SimulationProp,SimulationArraySize,response,PropResponse)

% function OF = ComputeOF_HGS(WorkingDirectory,facies_file,... 
%     SimulationDeck,response,facies_perms,snesim_input,PropResponse,...
%     TS_distance,distance_type)

%% Input parameters:
%   - WorkingDirectory: Full path where simulations should be performed
%   - real: Facies realization to be evaluated
%   - SimulationDeck: Full file name of the HGS grok file
%   - SimulationProp: Full file name of the HGS mprops file
%   - response: 2D or 3D array containing the responses observed at each
%               well
% T.H. This can be done through mprops in grok file
%   - facies_perms: vector containing the permeability values for each
%                   facies
%   - snesim_input: snesim input parameters
%   - PropResponse: Response to be read
%   - TS_distance: time-steps used to compute the distance
%   - distance_type: type of distance to use ('euclidean','cityblock',etc.)
%                    see help from pdist

%% Output parameters:
%   - OF: objective function for a given realization



%% 1. Evaluate the response for the given model (uses 3dsl)

% transform facies relazation in zones for HGS
disp('Transform facies into zones for HGS')
Zone_name = [WorkingDirectory '/Zone'];
FaciesToZones(facies_file,Zone_name);

% Launch HGS
prefix_simu = 'HGSsimul';
disp('Starting HydroGeoSphere simulation')
LaunchHGS(SimulationDeck,SimulationProp,SimulationArraySize,Zone_name,WorkingDirectory,prefix_simu);
disp('HydroGeoSphere Simulation done')

%% 2. Read the output response

response_tot = response;
file_resp = [WorkingDirectory '/' prefix_simu];
for i=1:length(response_tot)
    inputfile = [file_resp 'o.observation_well_flow.P' num2str(i) '.dat'];
    response_tot(i) = read_HGS_well(inputfile,PropResponse);
end


%% 3. Compute the objective function
% OF = compute_OF_wells(nb_wells,response_tot,distance_type);
% OF = OF';
OF = sqrt(sum((response - response_tot).^2)/length(response));
fprintf('The objective function of this realization is %f ',OF)
end
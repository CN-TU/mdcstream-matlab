%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% nClusters = setNClusters(value)
%
% Description: This function configures the number of clusters for the dataset.
%   
%
% Inputs:
%   value: the nClusters configuration value. Can be either 'one', 
%          'few' or 'many'.
%
% Outputs:
%   nClusters: the number of clusters
%
% Author:     Denis Ojdanic <denis.ojdanic@yahoo.com>
% Supervisor: Félix Iglesias Vázquez <felix.iglesias@nt.tuwien.ac.at>
% Date: 12.05.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

function nClusters = setNClusters(value)

switch  value
    case 'one' 
        nClusters = 1;
        
    case 'few'
        nClusters = randi([2 10]);
    
    case 'many'
        nClusters = randi([11 40]);
    otherwise
        error('setNClusters:ConfigurationError', 'Wrong input for clusters = %s',  value);
end

end


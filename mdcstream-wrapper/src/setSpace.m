%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% [alpha, alphaFactor] = setSpace(value, nOutliers, nClusters, dimensions)
%
% Description: This function configures the space of the dataset.
%   
%
% Inputs:
%   value: the space configuration value. Can be either 'tight' or
%          'extensive'.
%   nOutliers: the number of outliers
%   nClusters: the number of clusters
%   dimensions: the number of dimensions
%
% Outputs:
%   alpha: the alpha value 
%   alphaFactor: the alpha factor
%
% Author:     Denis Ojdanic <denis.ojdanic@yahoo.com>
% Supervisor: Félix Iglesias Vázquez <felix.iglesias@nt.tuwien.ac.at>
% Date: 12.05.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

function [alpha, alphaFactor] = setSpace(value, nOutliers, nClusters, dimensions)

CONST = constants('space');

alphaFactor = [];
alpha = [];

switch value
    
    case 'tight' 
        nInt = 2 + ceil( (nOutliers + nClusters) / dimensions );
        alpha = [];
        for i = 1 : dimensions
            alpha = [alpha, nInt];
        end
        
    case 'extensive' 
        alphaFactor = randf(CONST.MIN_ALPHA_FACTOR, CONST.MAX_ALPHA_FACTOR);
    
    otherwise
        error('setSpace:ConfigurationError', 'Wrong input for space = %s', value);
end

end


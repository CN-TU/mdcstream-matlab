%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% [config] = initializeDefaultValues(config)
%
% Description: This function configures the stationarity of the dataset.
%   
%
% Inputs:
%   config.
%       scenarioName:     The name of the scenario
%       nOfDataSets:      The number of dataset for a scenario
%       dimensions:       Number of dimensions
%       stationary:       Stationarity value
%       outliers:         Outliers value
%       clusters:         Number of clusters value
%       densityDiff:      The density difference value
%       space:            The size of the data space
%       movingClusters:   Whether cluster should move over time
%       overlap:          Cluster overlap
%
% Outputs:
%   config: An initialized struct with the values from above
%
% Author:     Denis Ojdanic <denis.ojdanic@yahoo.com>
% Supervisor: Félix Iglesias Vázquez <felix.iglesias@nt.tuwien.ac.at>
% Date: 12.05.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

function [config] = initializeDefaultValues(config)

DEFAULT = constants('default');

if ~isfield(config,'seed')
    config.seed = DEFAULT.SEED;
    warning('Using random seed = %s', DEFAULT.SEED);
end

if ~isfield(config,'dimensions')
    config.dimensions = DEFAULT.DIMENSIONS;
    warning('Using default value for dimensions = %s', DEFAULT.DIMENSIONS);
end

if ~isfield(config,'clusters')
    config.clusters = DEFAULT.CLUSTERS;
    warning('Using default value for clusters = %s', DEFAULT.CLUSTERS);
end

if ~isfield(config,'outliers')
    config.outliers = DEFAULT.OUTLIERS;
    warning('Using default value for outliers = %s', DEFAULT.OUTLIERS);
end


if ~isfield(config,'densityDiff')
    config.densityDiff = DEFAULT.DENSITY_DIFF;
    warning('Using default value for densityDiff = %s', DEFAULT.DENSITY_DIFF);
end


if ~isfield(config,'overlap')
    config.overlap = DEFAULT.OVERLAP;
    warning('Using default value for overlap = %s', DEFAULT.OVERLAP);
end


if ~isfield(config,'space')
    config.space = DEFAULT.SPACE;
    warning('Using default value for space = %s', DEFAULT.SPACE);
end

if ~isfield(config,'stationary')
    config.stationary = DEFAULT.STATIONARY;
    warning('Using default value for stationary = %s', DEFAULT.STATIONARY);
end

if ~isfield(config,'movingClusters')
    config.movingClusters = DEFAULT.MOVING_CLUSTERS;
    warning('Using default value for movingClusters = %s', DEFAULT.MOVING_CLUSTERS);
end
end


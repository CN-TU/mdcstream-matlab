%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% [config] = createMdcstreamConfiguration( configIn, nClusters, outlierFlag )
%
% Description: 
%   The function takes the user config as input, initializes all values and
%   creates a Mdcstream configuration
%
% Inputs:
%   configIn.
%       seed:              seed for the generation of random values
%       tbsDistribution:   the distribution function to create time between
%                          samples
%       mu:                the mean of the distribution
%       sigma:             the variance of the distribution
%       simultaneous:      percentage of how many datapoints have a 
%                          simultaneous time sample
%       maxSimulatenous:   maximum amount of consecutive simultaneous time
%                          samples
%       stationary:        whether time samples should be stationary or 
%                          non-stationary 
%       startTime:         start time of the clusters 
%       startAfterCluster: cluster starts after another cluster finishes
%       nTimeSamples:      total number of time samples
%       refillClusters:    which clusters should refill the gap between the 
%                          number of input data and the nTimeSamples 
%       displacement:      a factor of how much the clusterpoints are 
%                          displaced 
%       displacementRate:  percentage of datapoints after which displacement 
%                          gets applied to remaining clusterpoints
%       vectorChangeRate:  percentage of datapoints after which the
%                          direction of the displacement changes
%       nClusters:         the number of clusters
%       outlierFlag:       whether the input dataset for Mdcstream contains
%                          any outliers. 
%
% Outputs:
%   config.
%       <fieldsFromInput>: initialized fields
%
% Author:     Denis Ojdanic <denis.ojdanic@yahoo.com>
% Supervisor: Félix Iglesias Vázquez <felix.iglesias@nt.tuwien.ac.at>
% Date: 16.04.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 


function [config] = createMdcstreamConfiguration( configIn, nClusters, outlierFlag )
    
loadDefaultStreamConstants;

if ~exist('configIn') || isempty(configIn)
    configIn = [];
    warning('Using default values for the whole configuration');
end

if ~isfield(configIn,'seed')
    configIn.seed = DEFAULT_SEED;
    warning('Using default value for seed = %d', DEFAULT_SEED);
end

if ~isfield(configIn,'tbsDistribution')
    configIn.tbsDistribution = DEFAULT_TBS_DISTRIBUTION;
    warning('Using default value for tbsDistribution = %d', DEFAULT_TBS_DISTRIBUTION);
end

if ~isfield(configIn,'mu')
    configIn.mu = DEFAULT_MU;
    warning('Using default value for mu = %d', DEFAULT_MU);
end

if ~isfield(configIn,'sigma')
    configIn.sigma = DEFAULT_SIGMA;
    warning('Using default value for sigma = %d', DEFAULT_SIGMA);
end

if ~isfield(configIn,'simultaneous')
    configIn.simultaneous = DEFAULT_SIMULTANEOUS;
    warning('Using default value for simultaneous = %d', DEFAULT_SIMULTANEOUS);
end

if ~isfield(configIn,'maxSimultaneous')
    configIn.maxSimultaneous = DEFAULT_MAX_SIMULTANEOUS;
    warning('Using default value for maxSimultaneous = %d', DEFAULT_MAX_SIMULTANEOUS);
end

if ~isfield(configIn,'stationary')
    configIn.stationary = DEFAULT_STATIONARY;
    warning('Using default value for stationary = %d', DEFAULT_STATIONARY);
end

if ~isfield(configIn,'startTime')
    configIn.startTime = DEFAULT_START_TIME;
    warning('Using default value for startTime = %d', DEFAULT_START_TIME);
end

if ~isfield(configIn,'startAfterCluster')
    configIn.startAfterCluster = DEFAULT_START_AFTER_CLUSTER;
    warning('Using default value for startAfterCluster = %d', DEFAULT_START_AFTER_CLUSTER);
end

if ~isfield(configIn,'nTimeSamples')
    configIn.nTimeSamples = DEFAULT_N_TIME_SAMPLES;
    warning('Using default value for nTimeSamples = %d', DEFAULT_N_TIME_SAMPLES);
end

if ~isfield(configIn,'refillClusters')
    configIn.refillClusters = DEFAULT_REFILL_CLUSTERS;
    warning('Using default value for refillClusters = %d', DEFAULT_REFILL_CLUSTERS);
end

if ~isfield(configIn,'displacement')
    configIn.displacement = DEFAULT_DISPLACEMENT;
    warning('Using default value for displacement = %d', DEFAULT_DISPLACEMENT);
end

if ~isfield(configIn,'displacementRate')
    configIn.displacementRate = DEFAULT_DISPLACEMENT_RATE;
    warning('Using default value for displacementRate = %d', DEFAULT_DISPLACEMENT_RATE);
end

if ~isfield(configIn,'vectorChangeRate')
    configIn.vectorChangeRate = DEFAULT_VECTOR_CHANGE_RATE;
    warning('Using default value for vectorChangeRate = %d', DEFAULT_VECTOR_CHANGE_RATE);
end


rng(configIn.seed); % Establishing random seed


if configIn.stationary == 0
    tbsDistribution = setProperty(configIn.tbsDistribution, 'tbsDistribution', nClusters, 'nClusters');
    mu = setProperty(configIn.mu, 'mu', nClusters, 'nClusters');
    sigma = setProperty(configIn.sigma, 'sigma', nClusters, 'nClusters');
else
    tbsLength = size(configIn.tbsDistribution, 2);
    if tbsLength ~= 1
       error('createMdcstreamConfiguration:ConfigurationError', "Length of tbs distribution = %d has to be 1 in stationary case", tbsLength); 
    end
    tbsDistribution = configIn.tbsDistribution;
    
    muLength = size(configIn.mu, 2);
    if muLength ~= 1
       error('createMdcstreamConfiguration:ConfigurationError', "Length of mu = %d has to be 1 in stationary case", muLength); 
    end
    mu = configIn.mu;
    
    sigmaLength = size(configIn.sigma, 2);
    if sigmaLength ~= 1
       error('createMdcstreamConfiguration:ConfigurationError', "Length of sigma = %d has to be 1 in stationary case", sigmaLength); 
    end
    sigma = configIn.sigma;
end


if configIn.simultaneous < 0 || configIn.simultaneous >= 1 
    error('createMdcstreamConfiguration:ConfigurationError', "Simultaneous = %d has to be in a range of [0, 1[ ",  configIn.simultaneous); 
end


startTime = setProperty(configIn.startTime, 'startTime', nClusters, 'nClusters');
startAfterCluster = setProperty(configIn.startAfterCluster, 'startAfterCluster', nClusters, 'nClusters');


if outlierFlag
    number = nClusters - 1;
    label = 'nClusters - 1 (no outliers)';
else
    number = nClusters;
    label = 'nClusters (containing outliers)';
end

refillClusters = setProperty(configIn.refillClusters, 'refillClusters', number, 'label');
displacement = setProperty(configIn.displacement, 'displacement', number, label);
displacementRate = setProperty(configIn.displacementRate, 'displacementRate', number, label);
vectorChangeRate = setProperty(configIn.vectorChangeRate, 'vectorChangeRate', number, label);


config.tbsDistribution   = tbsDistribution;
config.mu                = mu;
config.sigma             = sigma;
config.simultaneous      = configIn.simultaneous;
config.maxSimultaneous   = configIn.maxSimultaneous;
config.stationary        = configIn.stationary;
config.startTime         = startTime;
config.startAfterCluster = startAfterCluster;
config.nTimeSamples      = configIn.nTimeSamples;
config.refillClusters    = refillClusters;
config.displacement      = displacement;
config.displacementRate  = displacementRate;
config.vectorChangeRate  = vectorChangeRate;
    
end
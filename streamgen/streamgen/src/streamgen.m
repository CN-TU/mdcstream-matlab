%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% [data] = streamgen(data, config)
%
% Description: generates synthetic stream data labels for datasets
%   
%
% Inputs:
%   config.
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
%
% Outputs:
%   data.
%       .dataPoints        output matrix containing data points         
%       .label             array containing the labels of the data points
%       .streamDataLabel   array containing the time samples of the data
%                          points
%
% Author:     Denis Ojdanic <denis.ojdanic@yahoo.com>
% Supervisor: Félix Iglesias Vázquez <felix.iglesias@nt.tuwien.ac.at>
% Date: 01.04.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
function [data] = streamgen(data, userConfig)

if ~exist('userConfig')
    userConfig = [];
end

%%% extract input data
dataPointsIn      = data.dataPoints;
labelIn           = data.label;
[nInputData, nDimensions] = size(dataPointsIn);
dataIn = [dataPointsIn, labelIn];

clusterLabels = unique(labelIn);
outlierFlag = size(clusterLabels(clusterLabels==0),1);
nClusters = size(clusterLabels, 1);

config = createStreamGenConfiguration(userConfig, nClusters, outlierFlag);

%%% extract configuration
tbsDistribution   = config.tbsDistribution;
mu                = config.mu;
sigma             = config.sigma;
simultaneous      = config.simultaneous;
maxSimultaneous   = config.maxSimultaneous;
stationary        = config.stationary;
startTime         = config.startTime;
startAfterCluster = config.startAfterCluster;
nTimeSamples      = config.nTimeSamples;
refillClusters    = config.refillClusters;
displacement      = config.displacement;
displacementRate  = config.displacementRate;
vectorChangeRate  = config.vectorChangeRate;


%%% start creating time between samples
if stationary
    dataIn = dataIn(randperm(size(dataIn, 1)), :);
    timeBetweenSamples = stationaryErgodicTimeBetweenSamples(tbsDistribution, nInputData, mu, sigma);
    
else
    mixedData = [];
    pointsPerCluster = [];
    
    for iCluster = 1 : nClusters
        if(min(labelIn) == 0)  % if outliers exist
            clusterPoints = dataIn(dataIn(:, nDimensions + 1) == iCluster - 1, :);
        else
            clusterPoints = dataIn(dataIn(:, nDimensions + 1) == iCluster, :);
        end
        
        pointsPerCluster = [pointsPerCluster, size(clusterPoints, 1)];
        mixedClusterPoints = clusterPoints(randperm(pointsPerCluster(iCluster)), :);
        mixedData = [mixedData; mixedClusterPoints];
    end
    
    cumsumPerCluster = nonStationaryErgodicTimeBetweenSamples(tbsDistribution, pointsPerCluster, mu, sigma); 
    
    if(any(startTime) || any(startAfterCluster))
        cumsumPerCluster = addClusterStartTime(cumsumPerCluster, pointsPerCluster, startTime, startAfterCluster);
    end
    mixedData = [mixedData, cumsumPerCluster]; % labelPerCluster
    sortedPerStreamLabel = sortrows(mixedData, nDimensions + 2);
    dataIn = sortedPerStreamLabel(:, 1 : nDimensions + 1);
    
    timeSamples = [0; sortedPerStreamLabel(:, nDimensions + 2)]; % ensure to have all elements, add zero at the beginning  
    timeBetweenSamples = diff(timeSamples);
end

%%% add simultaneous samples
if(simultaneous > 0)
    timeBetweenSamples = addSimultaneousSamples(simultaneous, maxSimultaneous, timeBetweenSamples);
end
streamDataLabel = cumsum(timeBetweenSamples);

%%% refill datapoints
if nTimeSamples > 0
    [dataIn, streamDataLabel] = refillDataPoints(refillClusters, nTimeSamples, dataIn, streamDataLabel);
end

%%% wandering clusters
if any(displacement) 
    outputData = createMovingClusters([dataIn, streamDataLabel], displacement, displacementRate, vectorChangeRate);
else
    outputData = [dataIn, streamDataLabel];
end

data.dataPoints = outputData(:, 1 : nDimensions);
data.label = outputData(:, nDimensions + 1);
data.streamDataLabel = outputData(:, nDimensions + 2);
end


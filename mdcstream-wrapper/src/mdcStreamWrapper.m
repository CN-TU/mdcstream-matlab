%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% [data, configuration] = mdcStreamWrapper(configIn)
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
%   dataOut: data contains the resulting mdcgen data and streamgen data
%   configOut: contains the mdcgen and streamgen configuration 
%
% Author:     Denis Ojdanic <denis.ojdanic@yahoo.com>
% Supervisor: Félix Iglesias Vázquez <felix.iglesias@nt.tuwien.ac.at>
% Date: 12.05.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

function [dataOut, configOut] = mdcStreamWrapper(configIn)
addpath(genpath('utilities'));
addpath(genpath('../../mdcgen-matlab/config_build/src/'));
addpath(genpath('../../mdcgen-matlab/mdcgen/src'));
addpath(genpath('../../mdcgen-matlab/extra_tools'));
addpath(genpath('../streamgen/config_build/src'));
addpath(genpath('../streamgen/streamgen/src'));
addpath(genpath('../streamgen/display'));

% ---- initialize seed

warning off

if ~exist('configIn') || isempty(configIn)
    configIn = [];
    warning('Using default values for the whole configuration');
end
config = initializeDefaultValues(configIn);

seed = config.seed;
rng(seed);


% ---- nDataPoints
CONST = constants('nDataPoints');
nTotalPoints = randi([CONST.MIN_NPOINTS CONST.MAX_NPOINTS]);

% ---- Dimensions
dimensions = setDimensions(config.dimensions);

% ---- nClusters
nClusters = setNClusters(config.clusters);

% ---- nOutliers
nOutliers = setNOutliers(config.outliers, nTotalPoints);

nClusterPoints = nTotalPoints - nOutliers;


% ---- densityDiff
[multivariate, compactness, minClusterMass, distribution] = setDensityDiff(config.densityDiff, nClusters, nClusterPoints); 

% ---- Space
[alpha, alphaFactor] = setSpace(config.space, nOutliers, nClusters, dimensions);


mdcConfig.seed = seed;
mdcConfig.nDimensions = dimensions;
mdcConfig.nDatapoints = nClusterPoints;
mdcConfig.nOutliers = nOutliers;
mdcConfig.nClusters = nClusters;

mdcConfig.distribution = distribution;
mdcConfig.multivariate = multivariate;
mdcConfig.compactness = compactness;
mdcConfig.minimumClusterMass = minClusterMass;
mdcConfig.alphaFactor = alphaFactor;
mdcConfig.alpha = alpha;

warning off
tempMDCConfig = createMDCGenConfiguration(mdcConfig);

[centroids, intersectionIndex, dimensionIndex] = insertCentroids(tempMDCConfig.nIntersections, dimensions, nClusters, nOutliers, tempMDCConfig.compactness);

% ---- overlap
if nClusters > 1 && config.space == "tight"
    tempMDCConfig.compactness = setOverlap(config.overlap, centroids, tempMDCConfig.compactness, tempMDCConfig.nIntersections, nClusters, tempMDCConfig.distribution);
end

% ---- stationary
[stationary, mu, sigma, startTime, startAfterCluster] = setStationarity(config.stationary, tempMDCConfig.pointsPerCluster, nClusters, nOutliers);

% ---- moving clusters
[displacement, displacementRate, vectorChangeRate] = setMovingClusters(config.movingClusters, nClusters, tempMDCConfig.compactness);

streamConfig.seed = seed;
streamConfig.tbsDistribution = 0;
streamConfig.mu              = mu;
streamConfig.sigma           = sigma;
streamConfig.simultaneous    = randf(0, 0.1);

streamConfig.stationary = stationary;
streamConfig.startAfterCluster = startAfterCluster;
streamConfig.startTime = startTime;

streamConfig.displacement = displacement;
streamConfig.displacementRate = displacementRate;
streamConfig.vectorChangeRate = vectorChangeRate;

% logConfig(mdcConfig, tempMDCConfig, streamConfig);


warning off

% create and insert cluster points 
[ mdcData, dataPoints, dataPointsLabel ] = insertClusterPoints( tempMDCConfig, centroids );

% create and insert outliers
if nOutliers > 0
    outliers = insertOutliers(intersectionIndex, dimensionIndex, tempMDCConfig.nIntersections, tempMDCConfig.nClusters, tempMDCConfig.nOutliers, tempMDCConfig.nDimensions);
    dataPoints = [dataPoints; outliers];
    outliersLabel = zeros(nOutliers, 1);
    dataPointsLabel = [dataPointsLabel; outliersLabel];
end

mdcData.dataPoints = dataPoints;
mdcData.label = dataPointsLabel;

dataOut = streamgen(mdcData, streamConfig);

configOut = {mdcConfig; streamConfig};

end



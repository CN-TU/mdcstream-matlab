function [] = mdcstream_help( input )

if ~exist('input', 'var') || isempty(input)
  input = '';
end

addpath(genpath('config_build/src'));
addpath(genpath('mdcstream/src'));
addpath(genpath('display'));
addpath(genpath('data_provider'));

switch input
    case 'example'
        fprintf('\n---------------------- configuration example --------------------\n\n');
        fprintf("%% Copy this example to a matlab script to get started             \n");
        fprintf("                                                                   \n");
        fprintf('warning on                                                         \n');
        fprintf("warning('backtrace', 'off');                                       \n");
        fprintf("                                                                   \n");
        fprintf("addpath(genpath('config_build/src'));                              \n");
        fprintf("addpath(genpath('mdcstream/src'));                                 \n");
        fprintf("addpath(genpath('display'));                                       \n");
        fprintf("addpath(genpath('data_provider'));                                 \n");
        fprintf("                                                                   \n");
        fprintf("config.displacement = 0.1;                                         \n");
        fprintf("config.displacementRate = 0.1;                                     \n");
        fprintf("data = dataProvider(1000, 2, 3, 3);                                \n");
        fprintf("result = mdcstream(data, config);                                  \n");
        fprintf("displayStream(result);                                             \n");
        fprintf('\n-------------------- configuration example end ------------------\n');
        fprintf("                                                                   \n");
        

    case 'input'

        fprintf('--------------------- Configuration options ---------------------\n\n');
        fprintf('config                                                         \n');
        fprintf('  .seed:              [scalar] seed for random number generator    \n');
        fprintf("\n");
        fprintf('  .tbsDistribution:   [scalar, array] defines distribution function to use for time samples \n');
        fprintf('                      (0) random     | (1) Uniform | (2) Gaussian |  (3) Logistic \n');
        fprintf('                      (4) Triangular | (5) Gamma   | (6) Gap or ring-shaped \n');
        fprintf("\n");
        fprintf('  .mu:                [scalar, array] the mean of the distribution    \n');
        fprintf("\n");
        fprintf('  .sigma:             [scalar, array]  the variance of the distribution    \n');
        fprintf("\n");
        fprintf('  .simultaneous:      [scalar]  percentage of how many datapoints have a simultaneous time sample    \n');
        fprintf("\n");
        fprintf('  .maxSimultaneous:   [scalar]  maximum amount of consecutive simultaneous time samples    \n');
        fprintf("\n");
        fprintf('  .stationary:        [scalar] whether time samples should be stationary or on-stationary     \n');
        fprintf("\n");
        fprintf('  .startTime:         [scalar, array] start time of the clusters     \n');
        fprintf("\n");
        fprintf('  .startAfterCluster: [array] cluster starts after another cluster finishes   \n');
        fprintf("\n");
        fprintf('  .nTimeSamples:      [scalar] total number of time samples    \n');
        fprintf("\n");
        fprintf('  .refillClusters:    [acalar, array] flag for which clusters should refill the gap between the number of input data and the nTimeSamples    \n');
        fprintf("\n");
        fprintf('  .displacement:      [scalar, array] a factor of how much the clusterpoints are displaced     \n');
        fprintf("\n");
        fprintf('  .displacementRate:  [scalar, array] percentage of datapoints after which displacement gets applied to remaining clusterpoints    \n');
        fprintf("\n");
        fprintf('  .vectorChangeRate:  [scalar, array] percentage of datapoints after which the direction of the displacement changes    \n');
        fprintf("\n");
        fprintf('------------------- Configuration options end -------------------\n\n\n\n');
    
    case 'output'

    fprintf('---------------------------- Outputs ----------------------------\n\n');
    fprintf('result \n');
    fprintf('  .dataPoints        [matrix] containing data points coordinates               \n');
    fprintf('  .label             [array] containing the cluster labels of the data points     \n');
    fprintf('  .streamDataLabel   [array] containing the time stamps for each data points \n');
    fprintf("\n");
    fprintf('-------------------------- Outputs end --------------------------\n\n');
    
    
    case 'seed'
        fprintf('\n%% Example on how to configure seed: \n\n');
        fprintf('config.seed = 18; \n');
        fprintf("data = dataProvider(1000, 2, 3, 3);                \n");
        fprintf('[ result ] = mdcstream(data, config );             \n\n');
    
    case 'tbsDistribution'
        fprintf('\tbsDistribution to select: \n\n');
        fprintf('  (1) Uniform \n');
        fprintf('  (2) Gaussian \n');
        fprintf('  (3) Logistic \n');
        fprintf('  (4) Triangular \n');
        fprintf('  (5) Gamma \n');
        fprintf('  (6) Gap or ring-shaped \n');
        fprintf('\n%% Example on how to configure tbsDistribution: \n\n');
        fprintf('%% tbsDistribution as scalar; \n');
        fprintf('config.tbsDistribution = 1; \n\n');
        fprintf('%% OR \n\n');
        fprintf('%% tbsDistribution as array. Length has to match nClusters; \n');
        fprintf('config.tbsDistribution = [1 3 3 4]; \n\n');
        fprintf("data = dataProvider(1000, 2, 3, 3);                \n");         
        fprintf('[ result ] = mdcstream(data, config );             \n\n');
        
    case 'mu'
        fprintf('\n%% Example on how to configure mu: \n\n');
        fprintf('config.mu = 6; \n\n');
        fprintf('%% OR \n\n');
        fprintf('%% mu as array. Length has to match nClusters; \n');
        fprintf('config.mu = [6 2 3 6]; \n\n');
        fprintf("data = dataProvider(1000, 2, 3, 3);                \n");         
        fprintf('[ result ] = mdcstream(data, config );             \n\n');
        
    case 'sigma'
        fprintf('\n%% Example on how to configure sigma: \n\n');
        fprintf('config.sigma = 0.3; \n\n');
        fprintf('%% OR \n\n');
        fprintf('%% sigma as array. Length has to match nClusters; \n');
        fprintf('config.sigma = [0.6 0.2 0.3 0.5]; \n\n');
        fprintf("data = dataProvider(1000, 2, 3, 3);                \n");         
        fprintf('[ result ] = mdcstream(data, config );             \n\n');
        
    case 'simultaneous'
        fprintf('\n%% Example on how to configure simultaneous: \n\n');
        fprintf('config.simultaneous = 0.5; \n\n');
        fprintf("data = dataProvider(1000, 2, 3, 3);                \n");         
        fprintf('[ result ] = mdcstream(data, config );             \n\n');
        
    case 'maxSimultaneous'
        fprintf('\n%% Example on how to configure maxSimultaneous: \n\n');
        fprintf('config.maxSimultaneous = 150; \n\n');
        fprintf("data = dataProvider(1000, 2, 3, 3);                \n");         
        fprintf('[ result ] = mdcstream(data, config );             \n\n');
        
    case 'stationary'
        fprintf('\n%% Example on how to configure stationary: \n\n');
        fprintf('config.stationary = 0; \n\n');
        fprintf("data = dataProvider(1000, 2, 3, 3);                \n");         
        fprintf('[ result ] = mdcstream(data, config );             \n\n');

    case 'startTime'
        fprintf('\n%% Example on how to configure startTime: \n\n');
        fprintf('%% startTime as scalar; \n');
        fprintf('config.startTime = 300; \n\n');
        fprintf('%% OR \n\n');
        fprintf('%% startTime as array. Length has to match nClusters; \n');
        fprintf('config.startTime = [300 200 500 300]; \n\n');
        fprintf("data = dataProvider(1000, 2, 3, 3);                \n");         
        fprintf('[ result ] = mdcstream(data, config );             \n\n');
       
    case 'startAfterCluster'
        fprintf('\n%% Example on how to configure startAfterCluster: \n\n');
        fprintf('config.startAfterCluster = [0 3 1 1]; \n\n');
        fprintf("data = dataProvider(1000, 2, 3, 3);                \n");         
        fprintf('[ result ] = mdcstream(data, config );             \n\n');
               
    case 'nTimeSamples'
        fprintf('\n%% Example on how to configure nTimeSamples: \n\n');
        fprintf('config.nTimeSamples = 100000; \n\n');
        fprintf("data = dataProvider(1000, 2, 3, 3);                \n");         
        fprintf('[ result ] = mdcstream(data, config );             \n\n');
        
    case 'refillClusters'
        fprintf('\n%% Example on how to configure refillClusters: \n\n');
        fprintf('%% refillClusters as scalar; \n');
        fprintf('config.refillClusters = 1; \n\n');
        fprintf('%% OR \n\n');
        fprintf('%% refillClusters as array. Length has to match nClusters; \n');
        fprintf('config.refillClusters = [0 1 1]; \n\n');
        fprintf("data = dataProvider(1000, 2, 3, 3);                \n");         
        fprintf('[ result ] = mdcstream(data, config );             \n\n');
        
    case 'displacement'
        fprintf('\n%% Example on how to configure displacement: \n\n');
        fprintf('%% displacement as scalar; \n');
        fprintf('config.displacement = 0.5; \n\n');
        fprintf('%% OR \n\n');
        fprintf('%% displacement as array. Length has to match nClusters; \n');
        fprintf('config.refillClusters = [0.5 0.1 0.1]; \n\n');
        fprintf("data = dataProvider(1000, 2, 3, 3);                \n");
        fprintf('[ result ] = mdcstream(data, config );             \n\n');
        
    case 'displacementRate'
        fprintf('\nExample on how to configure displacementRate: \n\n');
        fprintf('%% displacementRate as a scalar \n');
        fprintf('config.displacementRate = 0.4; \n\n');
        fprintf('%% OR \n\n');
        fprintf('%% displacementRate as array. Length has to match nClusters; \n');
        fprintf('config.displacementRate = [0.4 0.3 0.2]; \n');
        fprintf("data = dataProvider(1000, 2, 3, 3);                \n");         
        fprintf('[ result ] = mdcstream(data, config );             \n\n');
        
    case 'vectorChangeRate'
        fprintf('\nExample on how to configure vectorChangeRate: \n\n');
        fprintf('%% vectorChangeRate as a scalar \n');
        fprintf('config.vectorChangeRate = 0.5; \n\n');
        fprintf('%% OR \n\n');
        fprintf('%% vectorChangeRate as array. Length has to match nClusters; \n');
        fprintf('config.vectorChangeRate = [0.1 0.1 0.3]; \n');
        fprintf("data = dataProvider(1000, 2, 3, 3);                \n");         
        fprintf('[ result ] = mdcstream(data, config );             \n\n');
        
    otherwise
        fprintf('-------------------------- Usage --------------------------\n\n');
        fprintf('\nUsage: >> stream_help [OPTION] \n\n');
        fprintf('Following values can be inserted for [OPTION]:  \n\n');
        fprintf("example ... to display a basic hello world example for mdcstream     \n");
        fprintf('input   ... to display all possible input config config     \n');
        fprintf('outut   ... to display mdcstream output config     \n\n');
        fprintf('To display examples for each configuration parameter enter for example:     \n');
        fprintf('>> stream_help tbsDistribution     \n');
        fprintf('This shows examples for configuration options for each field     \n');
        fprintf('------------------------------------------------------------\n\n');
end

end
 








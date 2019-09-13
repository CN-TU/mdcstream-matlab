%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% function generateDataSets(p)
%
% Description: This function takes the user scenarios, generates the data
%              and saves the data and the configuration to corresponding 
%              files.
%   
%
% Inputs:
%   p.
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
%   rootFolder: then name of the root folder for the generated data
%
%
% Outputs:
%   The resulting datapoints,  the configuration and the scenario are saved
%   to files
%
% Author:     Denis Ojdanic <denis.ojdanic@yahoo.com>
% Supervisor: Félix Iglesias Vázquez <felix.iglesias@nt.tuwien.ac.at>
% Date: 12.05.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
function generateDataSets(p, rootFolder)

warning('backtrace', 'off')

if(~exist('rootFolder'))
    rootFolder = 'msdData';
end
mkdir(rootFolder); 


if isfield(p,'seed')
    seed = p.seed; 
else
    seed = RandStream.shuffleSeed;
end
rng(seed);

for iScenario = 1 : size(p.scenarioName, 2)
    fprintf("Generating %d datasets for scenario: %s \n", p.nOfDataSets{iScenario}, p.scenarioName{iScenario});
    
    scenarioFolder = [rootFolder, '/', p.scenarioName{iScenario}];
    dataFolder = [scenarioFolder, '/data'];
    arffFolder = [scenarioFolder, '/arff'];
    configFolder = [scenarioFolder, '/config'];
    
    if(~exist(scenarioFolder))
       mkdir(scenarioFolder); 
    end
    
    if(~exist(dataFolder))
       mkdir(dataFolder); 
    end
    
    if(~exist(arffFolder))
       mkdir(arffFolder); 
    end
    
    if(~exist(configFolder))
       mkdir(configFolder); 
    end

    mdc.dimensions        = p.dimensions{iScenario};
    mdc.stationary        = p.stationary{iScenario};
    mdc.outliers          = p.outliers{iScenario};
    mdc.clusters          = p.clusters{iScenario};
    mdc.densityDiff       = p.densityDiff{iScenario};
    mdc.space             = p.space{iScenario};
    mdc.movingClusters    = p.movingClusters{iScenario};
    mdc.overlap           = p.overlap{iScenario};
    save(strcat(scenarioFolder, "/", p.scenarioName{iScenario}, "_params", ".mat"), 'mdc');
    
    for jDataSet = 1 : p.nOfDataSets{iScenario}
        
        mdc.seed = randi([1 100000000], 1, 1);
        
        [result, configuration] = mdcStreamWrapper(mdc);
                
        save(strcat(dataFolder, "/", p.scenarioName{iScenario}, "_data_"  , int2str(jDataSet), ".mat"), 'result');
        save(strcat(configFolder, "/", p.scenarioName{iScenario}, "_config_", int2str(jDataSet), ".mat"), 'configuration');
        
        % save as arff file for MOA
        data = [result.dataPoints, result.label, result.streamDataLabel];
        data = sortrows(data, size(result.dataPoints, 2) + 2);
        data = data(:, 1 : size(result.dataPoints, 2) + 1);
        writeArff( data, strcat(arffFolder, "/"),  strcat(p.scenarioName{iScenario}, "_data_", int2str(jDataSet)) );   
    end
end

end


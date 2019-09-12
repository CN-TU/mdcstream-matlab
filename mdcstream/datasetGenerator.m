addpath(genpath('src'));


% p.scenarioName     = {'scenarioA' , 'scenarioB'};
% p.nOfDataSets     = {2            , 2};
% 
% p.dimensions      = {'two'        , 'two'};
% p.stationary      = {'sequential' , 'stationary'};
% p.outliers        = {'medium'     , 'many'}; 
% p.clusters        = {'many'       , 'few'};
% p.densityDiff     = {'two'        , 'no'};
% p.space           = {'tight'      , 'tight'};
% p.movingClusters  = {'no'         , 'few'};
% p.overlap         = {'no'         , 'no'};

p.scenarioName     = {'scenarioA' };
p.nOfDataSets     = {1            };

p.dimensions      = {'two'        };
p.stationary      = {'nonstationary' };
p.outliers        = {'medium'        }; 
p.clusters        = {'many'       };
p.densityDiff     = {'two'        };
p.space           = {'tight'      };
p.movingClusters  = {'no'         };
p.overlap         = {'no'         };

p.nDatapoints = 10000;

generateMDCStream(p, 'dataRoot');
%load("dataRoot/set/data/set_data_1.mat");
%displayStatic(result);

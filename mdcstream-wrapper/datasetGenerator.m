
clear

addpath(genpath('src'));

p.seed = 14;
p.scenarioName    = {'scenarioA' };
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

generateDataSets(p, 'dataRoot');

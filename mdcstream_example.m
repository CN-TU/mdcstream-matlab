

warning on                                                         
warning('backtrace', 'off');                                       
                                                                   
addpath(genpath('config_build/src'));                              
addpath(genpath('mdcstream/src'));                                 
addpath(genpath('display'));                                       
addpath(genpath('data_provider'));                                 

fprintf('Creating MDCGen dataset ... \n');
p.seed = 1;                
config.seed = 15;
config.nDatapoints = 3000;                                         
config.nDimensions = 2;                                            
config.nClusters = 3;                                              
config.nOutliers = 200;                                              
config.distribution = 0;  
config.compactness = [0.02, 0.05, 0.1];  
data = mdcgen( p );                                   

fprintf('Creating MDCStream dataset ... \n');
config.displacement = 0.1;                                         
config.displacementRate = 0.1;                                     
data = mdcstream(data, config);             

fprintf('Displaying dataset (last datapoints)... \n');
displayRecent(data);
%fprintf('Displaying dataset (all datapoints)... \n');
%displayStream(data);       

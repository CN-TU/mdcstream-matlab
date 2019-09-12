% p: paramters
clear
close all
warning on
warning('backtrace', 'off')


if(~isdeployed)
  cd(fileparts(which('example.m')));
end

addpath(genpath('../mdcgen-matlab-master/config_build/src/'));
addpath(genpath('../mdcgen-matlab-master/mdcgen/src'));
addpath(genpath('../mdcgen-matlab-master/extra_tools'));
addpath(genpath('../streamgen-matlab-master/config_build/src'));
addpath(genpath('../streamgen-matlab-master/streamgen/src'));
addpath(genpath('../streamgen-matlab-master/display'));


fprintf('Generating parameters ... \n');


p.nDimensions = 2; 
p.nDataPoints = 9568 ;
p.nOutliers = 432;
p.nClusters = 12; 
p.multivariate =  -1.00; 
p.compactness = [ 1.13  0.80  0.45  1.26  0.45  0.85  0.63  1.20  1.35  1.43  1.67  0.21]; 


p.alpha =  [224.00  224.00 ];



s.tbsDistribution = 0 ;
s.mu = [ 9.00  3.80  4.14  3.58  1.97  3.36  3.87  4.02  3.99  1.84  1.78  3.96  2.91 ];
s.sigma = [ 0.90  0.54  0.33  0.17  0.92  0.12  0.31  0.68  0.90  0.63  0.35  0.98  0.44 ];
s.stationary = 0 ;

s.startTime =  0.00 ;
s.startAfterCluster =  [0.00  0.00  1.00  2.00  3.00  4.00  5.00  6.00  7.00  8.00  9.00  10.00  11.00 ];




fprintf('Starting mdcgen ... \n');
tic

[ mdcData ] = mdcgen( createMDCGenConfiguration(p) );
fprintf('Mdcgen finished ... ');
toc

fprintf('Starting streamgen ... \n');
tic
resultWrapper = streamgen(mdcData, s);
fprintf('Streamgen finished ... ');
toc
displayRecent(resultWrapper, 1, 2);



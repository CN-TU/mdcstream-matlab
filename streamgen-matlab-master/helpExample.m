clear
close all
warning on
warning('backtrace', 'off')

if(~isdeployed)
  cd(fileparts(which('example.m')));
end

addpath(genpath('config_build/src'));
addpath(genpath('streamgen/src'));
addpath(genpath('display'));
addpath(genpath('data_provider'));

data = dataProvider(1000, 2, 3, 3);

%s.seed = 5;
s.tbsDistribution = [2 3 1 6];
s.mu              = 3;

s.sigma           = 1;
%s.simultaneous    = 0.9;
%s.maxSimultaneous = 4;
s.stationary      = 0;
%s.startTime       = [0, , 0, 200];
%s.startAfterCluster = [2 3 4 0];
s.nTimeSamples    = 1105;
s.refillClusters  = [4 0 0 0 ];
s.displacement = [0.08 0.05 0.05];
s.displacementRate = [0.4, 0.05, 0.05];
s.vectorChangeRate = [0.2, 0.3, 0.4];


result = streamgen(data, s);
displayStatic(result);








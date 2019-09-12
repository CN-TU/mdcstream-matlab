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


% general data 
p.seed = 8;                       % p.sd
p.nDimensions = 2; 
p.nDatapoints = 3000;        % p.M : 
p.nOutliers = 5;              % p.out
p.nClusters = 3;      % p.k
%p.clusterMass = ;
%p.minimumClusterMass = 0;   


%p.alphaFactor = [3, 3];
%p.alpha = 1;  % p.N   
p.scale = 1;

% cluster shape
% 1 - Uniform, 2 - Normal, 3 - Logistic, 4 - Triangular, 5 - Gamma, 6 Ring
p.distribution = 1;      % p.d (scalar, for all clusters, vector, each cluster independent...)
%p.distributionFlag = 6;      % R9 distribution, on, off
p.multivariate = -1;        % R8: choose mutivariate
p.correlation = 0;
p.compactness = [0.05 0.05 0.05];          % compactness of clusters
p.rotation = 0;        % p.rot
p.nNoise = 0;     % R19: noisy dimensions


p.validity.Silhouette=0;
p.validity.Gindices=0;

% dist(1).binProbability = [0.4,0,0.2,0,0.4];
% dist(1).edges = [2,3,4,5,6,7];
dist(1).binProbability = [0.4,0,0.2,0,0.4];
dist(1).edges = [-1,-0.9,-0.1,0.1,0.9,1];

%dist(1).edges = [-1, -0.7, -0.2, 0.2, 0.7, 1];
%dist(2).edges = [1, 4];



fprintf('Starting mdcgen ... \n');
tic

config = createMDCGenConfiguration(p, dist);
[ mdcData ] = mdcgen( config );
fprintf('Mdcgen finished ... ');
toc
%scatter(mdcData.dataPoints(:,1),mdcData.dataPoints(:,2),10,'fill');
%axis([0 1 0 1])



%s.seed = 7;
s.tbsDistribution = 0;
s.mu              = 10;
s.sigma           = 1;
s.simultaneous    = 0;
%s.maxSimultaneous = 4;
s.stationary      = 0;
%s.startTime       = [0, , 0, 200];
%s.startAfterCluster = [0 0 : p.nClusters - 1];

%s.nTimeSamples    = 1305;
%s.refillClusters  = 1;
s.displacement = 0.5 * p.compactness;  % 0.1 - 0.5 * comp
s.displacementRate = [0.1, 0.01, 0.2]; % 0.05 - 0.1
%s.vectorChangeRate = [0, 0, 0];




data = streamgen(mdcData, s);
%displayStream(data);
displayStatic(data);












%scatter(data.dataPoints(:,1),data.dataPoints(:,2),10,'fill');

% scatter3(result.dataPoints(:,1),result.dataPoints(:,2),result.dataPoints(:,3),5,'fill');
% 
% 
% scatter(subplot(2,2,1),result.dataPoints(:,1),result.dataPoints(:,2),5,'fill');
% scatter(subplot(2,2,2),result.dataPoints(:,1),result.dataPoints(:,3),5,'fill');
% scatter(subplot(2,2,3),result.dataPoints(:,2),result.dataPoints(:,3),5,'fill');

% axis([0 1 0 1 0 1])






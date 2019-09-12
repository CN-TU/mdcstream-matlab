%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% [mu, sigma, startTime] = assignNonStationaryClusterValues(nClusters, approxPPCluster, CONST)
%
% Description: This function creates nonstationary cluster values
%   
%
% Inputs:
%   nClusters: the number of clusters
%   approxPPCluster: the approximated points per cluster
%   CONST: struct containing constants needed
%
% Outputs:
%   mu: the mu value for the clusters
%   sigma: the simga value for the clusters
%   startTime: the start time for the clusters
%
% Author:     Denis Ojdanic <denis.ojdanic@yahoo.com>
% Supervisor: Félix Iglesias Vázquez <felix.iglesias@nt.tuwien.ac.at>
% Date: 12.05.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

function [mu, sigma, startTime] = assignNonStationaryClusterValues(nClusters, approxPPCluster, CONST)
mu = [];
sigma = [];
startTime = [];

%first cluster remains for the whole dataset, the second
%cluster appears to guarantee non stationarity, the others are
%assigned randomly
if nClusters == 1
    randValues = 1;
    
elseif nClusters == 2
    randValues = [1 2];
    
else
    randValues = [1 2 randi(3, nClusters - 2, 1)'];
end

for i = 1 : nClusters
    switch randValues(i)
        case 1 % remains
            mu = [mu randf(CONST.MIN_REMAIN_MU, CONST.MAX_REMAIN_MU)];
            startTime = [startTime 0];
            
        case 2 % appears
            mu = [mu randf(CONST.MIN_MU, CONST.MAX_MU)];
            appearTime = floor((approxPPCluster * CONST.MAX_REMAIN_MU) * randf(0.1, 0.5));
            startTime = [startTime appearTime];
            
        case 3 % disapears
            mu = [mu randf(CONST.MIN_MU, CONST.MAX_MU)];
            startTime = [startTime 0];
    end
    
    sigma = [sigma randf(CONST.MIN_SIGMA, CONST.MAX_SIGMA)];
end

end


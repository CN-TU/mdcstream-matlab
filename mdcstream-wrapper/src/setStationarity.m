%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% [stationary, mu, sigma, startTime, startAfterCluster] = setStationarity(value, ppCluster, nClusters, nOutliers) 
%
% Description: This function configures the stationarity of the dataset.
%   
%
% Inputs:
%   value: the stationarity configuration value. Can be either 'stationary', 
%          'sequential' or 'nonstationary'.
%   ppCluster: the points per cluster
%   nClusters: the number of clusters
%   nOutliers: the number of outliers
%
% Outputs:
%   stationary: the stationarity flag
%   mu: the mu values for the clusters and outliers
%   sigma: the sigma values for the clusters and outliers
%   startTime: the start time for the clusters
%   startAfterCluster: the sequence for cluster start
%
% Author:     Denis Ojdanic <denis.ojdanic@yahoo.com>
% Supervisor: Félix Iglesias Vázquez <felix.iglesias@nt.tuwien.ac.at>
% Date: 12.05.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

function [stationary, mu, sigma, startTime, startAfterCluster] = setStationarity(value, ppCluster, nClusters, nOutliers)

CONST = constants('stationary');

startAfterCluster= 0;
startTime = 0;

switch value
    case 'stationary' % none
        stationary = 1;     
        mu              = randf(CONST.MIN_MU, CONST.MAX_MU);
        sigma           = randf(CONST.MIN_SIGMA, CONST.MAX_SIGMA);

    case 'sequential' % clusters appear sequentially, outliers in between
         stationary = 0;
         mu = [];
         sigma = [];
         
         if nOutliers > 0
            startAfterCluster = [0 0 2 : nClusters];  
            
            % mu and sigma for clusters
            for i = 2 : nClusters + 1
               mu = [mu randf(CONST.MIN_MU, CONST.MAX_MU)]; 
               sigma = [sigma randf(CONST.MIN_SIGMA, CONST.MAX_SIGMA)]; 
            end
            
            % mu and sigma for outliers
            outMu = floor(((sum(ppCluster) ) * mean(mu)) / nOutliers);
            mu = [outMu, mu];
            sigma = [outMu / 10, sigma];
            
         else
            % mu and sigma for clusters
            startAfterCluster = 0 : nClusters - 1;   
            for i = 1 : nClusters 
               mu = [mu randf(CONST.MIN_MU, CONST.MAX_MU)]; 
               sigma = [sigma randf(CONST.MIN_SIGMA, CONST.MAX_SIGMA)]; 
            end
         end
        
    case 'nonstationary' % some clusters apper, some dissapear, some remain
        stationary = 0;
        
        approxPPCluster = floor(sum(ppCluster) / nClusters);
       
        if nOutliers > 0
         
           [mu, sigma, startTime] = assignNonStationaryClusterValues(nClusters, approxPPCluster, CONST);
            
            % mu and sigma for outliers
            outMu = ( max(ppCluster) * max(mu)) / nOutliers;
            mu = [outMu, mu];
            sigma = [outMu / 10, sigma];
            startTime = [0, startTime];
         
        else   
            [mu, sigma, startTime] = assignNonStationaryClusterValues(nClusters, approxPPCluster, CONST);
        end
        
    otherwise
        error('setStationary:ConfigurationError', 'Wrong input for stationary = %s', value);
end
end


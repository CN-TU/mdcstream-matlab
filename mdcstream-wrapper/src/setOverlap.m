%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% [compactness] = setOverlap(value, centroids, compactnessIn, nIntersections, nClusters, distribution)
%
% Description: This function configures the overlap of the dataset.
%   
%
% Inputs:
%   value: the overlap configuration value. Can be either 'no' or 'yes'
%   centroids: the coordinates of the cluster centroids
%   compactnessIn: the compactess to adapt
%   nIntersections: the number of intersections to place clusters and
%                   outliers
%   nClusters: the number of clusters
%   distribution: the distribution type for the cluster shape
%
% Outputs:
%   compactness: the calculated compactness
%
% Author:     Denis Ojdanic <denis.ojdanic@yahoo.com>
% Supervisor: Félix Iglesias Vázquez <felix.iglesias@nt.tuwien.ac.at>
% Date: 12.05.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

function [compactness] = setOverlap(value, centroids, compactnessIn, nIntersections, nClusters, distribution)

compactnessIn = compactnessIn * max(max(nIntersections));

CONST = constants('overlap');

switch value
    case "no"
       overlapFactor = CONST.NO_OVERLAP_FACTOR;
    case "yes"
       overlapFactor = CONST.OVERLAP_FACTOR;
    otherwise
        error('setStationary:ConfigurationError', 'Wrong input for overlap = %s', value);
end

d = pdist(centroids);
distMatrix = squareform(d);

for i = 1 : nClusters
    dist = distMatrix(i, :);
    dist(dist == 0) = [];
    minDist = min(dist);
     
    switch distribution(1, i)
        case 1
            distFactor = CONST.DISTRIBUTION_ONE;
        case 2
            distFactor = CONST.DISTRIBUTION_TWO;
        case 3
            distFactor = CONST.DISTRIBUTION_THREE;
        case 4
            distFactor = CONST.DISTRIBUTION_FOUR;
        case 5
            distFactor = CONST.DISTRIBUTION_FIVE;
        case 6
            distFactor = CONST.DISTRIBUTION_SIX;        
    end
    
    compactness(i) = compactnessIn(i) * overlapFactor * distFactor * minDist; 
end

end


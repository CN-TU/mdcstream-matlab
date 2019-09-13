%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% displayStream(data, dim1, dim2, speed)
%
% Description: This function provides example input data to test mdcstream
%   
% Inputs:
%   nDataPoints: number of datapoints
%   nDimensions: number of dimensions
%   nClusters: number of clusters
%   nOutliers: number of ouliers
%
% Output:
%   data 
%       .dataPoints: coordiantes of the datapoints
%       .label: label representing cluster name
%
% Author:     Denis Ojdanic <denis.ojdanic@yahoo.com>
% Supervisor: Félix Iglesias Vázquez <felix.iglesias@nt.tuwien.ac.at>
% Date: 25.04.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

function data = dataProvider(nDataPoints, nDimensions, nClusters, nOutliers)

minPointsPerCluster = floor((nDataPoints - nOutliers) / (3 * nClusters));
pointsPerCluster = diff([0,sort(randperm((nDataPoints - nOutliers) - 1, nClusters - 1)), (nDataPoints - nOutliers)]);

[smallestCluster, indexMin] = min(pointsPerCluster);

while (smallestCluster < minPointsPerCluster)
    missingPoints =  minPointsPerCluster - pointsPerCluster(indexMin) ;
    pointsPerCluster(indexMin) = minPointsPerCluster;
    
    while(missingPoints > 0)
        
        [~, indexMax] = max(pointsPerCluster);
        remainingPoints = pointsPerCluster(indexMax) - missingPoints;
        if (remainingPoints > minPointsPerCluster)
            pointsPerCluster(indexMax) = remainingPoints;
            missingPoints = 0;
        else
            pointsToGive = pointsPerCluster(indexMax) - minPointsPerCluster;
            pointsPerCluster(indexMax) = pointsPerCluster(indexMax) - pointsToGive;
            missingPoints = missingPoints - pointsToGive;
        end
    end
    [smallestCluster, indexMin] = min(pointsPerCluster);
end

fprintf('dataProvider: pointsPerCluster = %d \n', pointsPerCluster(1 : nClusters));

points = [];
label = [];
if(nOutliers > 0)
    points = [points; rand(nOutliers, nDimensions)];
    label = [label; zeros(nOutliers, 1)];
end

for iCluster = 1 : nClusters
    clusterPoints = 0.1 * rand(pointsPerCluster(iCluster), nDimensions);
    clusterPoints =  bsxfun(@plus, clusterPoints, ((rand(1, nDimensions) > 0.5) * 2 - 1) .* rand(1, nDimensions));
    points = [points; clusterPoints];
    label = [label; iCluster * ones(pointsPerCluster(iCluster), 1)];
    
end

data.dataPoints = points;
data.label = label;

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% outputData = createMovingClusters(mdcData, displacement, displacementRate, vectorChangeRate )
%
% Description: This function takes an input mdcData set and modifies the
%              location of the datapoints to create moving clusters
%   
%
% Inputs:
%   mdcData: The complete dataset consisting of datapoints, cluster labels
%            and stream data labels
%   displacement: a factor of how much the clusterpoints are displaced 
%   displacementRate: percentage of datapoints after which displacement 
%                     gets applied to remaining clusterpoints
%   vectorChangeRate: percentage of datapoints after which the direction
%                     of the displacement changes
%
%
% Outputs:
%   outputData: The complete dataset consisting of the moved datapoints,
%               cluster labels and stream data labels
%
% Author:     Denis Ojdanic <denis.ojdanic@yahoo.com>
% Supervisor: Félix Iglesias Vázquez <felix.iglesias@nt.tuwien.ac.at>
% Date: 19.04.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

function outputData = createMovingClusters(mdcData, displacement, displacementRate, vectorChangeRate)

[~, aux] = size(mdcData);
nDimensions = aux - 2;

label = mdcData(:, nDimensions + 1);
clusterLabels = unique(label);
outputData = [];

if any(~clusterLabels) % contains outliers
    nClusters = size(clusterLabels, 1) - 1;
    outputData = mdcData(mdcData(:, nDimensions + 1) == 0, :);
else
    nClusters = size(clusterLabels, 1);
end


for iCluster = 1 : nClusters
    
    cluster = mdcData(mdcData(:, nDimensions + 1) == iCluster, :);
    nPoints = size(cluster, 1);
    
    if displacement(iCluster) > 0 && displacementRate(iCluster) < 1

        vector = ((rand(1, nDimensions) > 0.5) * 2 - 1) .* rand(1, nDimensions);
        normalized = sqrt(nDimensions) * bsxfun(@rdivide, vector, rms(vector')') / nDimensions;
        displacementVector = displacement(iCluster) * normalized;

        factor = 1;
        factorVector = 1;
        shiftBy = 0;
        
        for iPoint = 1 : nPoints

            if(vectorChangeRate(iCluster) < 1)
               if(iPoint > factorVector * vectorChangeRate(iCluster) * nPoints) 
                   vector = ((rand(1, nDimensions) > 0.5) * 2 - 1) .* rand(1, nDimensions);
                   normalized = sqrt(nDimensions) * bsxfun(@rdivide, vector, rms(vector')') / nDimensions;
                   displacementVector = displacement(iCluster) * normalized;
                   factorVector = factorVector + 1;
               end
            end
            
            if ( iPoint > factor * displacementRate(iCluster) * nPoints)     
                shiftBy = shiftBy + displacementVector;
                factor = factor + 1;
            end

            cluster(iPoint, 1 : nDimensions) = cluster(iPoint, 1 : nDimensions) + shiftBy;
        end
    end
    outputData = [outputData; cluster];
end


end


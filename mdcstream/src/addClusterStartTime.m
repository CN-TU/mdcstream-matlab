%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% [clusterTbs] = addClusterStartTime(timeSamplesIn, pointsPerCluster, startTime, startAfterCluster)
%
% Description: This function adds a time offset to the time samples.
%   
% Inputs:
%   timeSamplesIn: time samples of the datapoints
%   pointsPerCluster: number of datapoints per cluster
%   startTime: time offset to add to a specific cluster
%   startAfterCluster: indicates after the last timestamp of which cluster 
%                      the configured cluster should start its own time stamp 
%
% Outputs:
%   timeSamplesOut: Time samples with modified start time
%
% Author:     Denis Ojdanic <denis.ojdanic@yahoo.com>
% Supervisor: Félix Iglesias Vázquez <felix.iglesias@nt.tuwien.ac.at>
% Date: 02.04.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

function [timeSamplesOut] = addClusterStartTime(timeSamplesIn, pointsPerCluster, startTime, startAfterCluster)

pointsCumsum = [0, cumsum(pointsPerCluster)];
timeSamplesOut = [];
nClusters = size(pointsPerCluster, 2);

if ( any(startAfterCluster) ) 
    
    if size(startAfterCluster(startAfterCluster == 0), 2) == 0 
        error('addClusterStartTime:ConfigurationError', "In startAfterCluster no starting cluster is marked with 0 ");   
    end

    if ( size(startAfterCluster(startAfterCluster > nClusters), 2) || size(startAfterCluster(startAfterCluster < 0), 2) )
        error('addClusterStartTime:ConfigurationError', "Wrong value for startAfterCluster. Clusters to start after are in range from 1 and %d", nClusters);
    end
    
    for i = 1 : nClusters
       if startAfterCluster(i) == i
           error('addClusterStartTime:ConfigurationError', "Cluster %d may not start after itself", i);
       end
    end
end


clustersToEdit = find(startAfterCluster == 0);

while size(clustersToEdit) > 0
    
    iCluster = clustersToEdit(1);
    clusterStart = pointsCumsum(iCluster) + 1;
    clusterStop = pointsCumsum(iCluster + 1);
    
    if startAfterCluster(iCluster) > 0
        startAfter = timeSamples(startAfterCluster(iCluster)).cluster(end); 
    else
        startAfter = 0;
    end
    
    timeSamples(iCluster).cluster = timeSamplesIn(clusterStart : clusterStop)' + startTime(iCluster) + startAfter;
    
    clustersToEdit = [clustersToEdit, find(startAfterCluster == iCluster)];
    clustersToEdit(1) = [];
end   

timeSamplesOut = [timeSamplesOut, timeSamples(1 : nClusters).cluster]';

end


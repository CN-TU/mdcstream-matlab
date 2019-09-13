%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% [data, streamDataLabel] = refillDataPoints(refillClusters, nTimeSamples, data, streamDataLabel)
%
% Description: Adds datapoints to input dataset depending on the difference
%              between nTimesamples and nDatapoints of input data
%   
% Inputs:
%   refillClusters:  flag for which clusters to use to refill the dataset
%   nTimeSamples:    number of expected datapoints
%   data:         base dataset with actual number of datapoints
%   streamDataLabel: stream data label for the data
%
% Outputs:
%   data:         the output dataset with added datapoints       
%   streamDataLabel: the ouput stream data lebel set with added datapoints
%
% Author:     Denis Ojdanic <denis.ojdanic@yahoo.com>
% Supervisor: Félix Iglesias Vázquez <felix.iglesias@nt.tuwien.ac.at>
% Date: 20.04.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

function [data, streamDataLabel] = refillDataPoints(refillClusters, nTimeSamples, data, streamDataLabel)

[nInputData, col] = size(data);
nDimensions = col -1;

if ~any(refillClusters)
   error('refillDataPoints:ConfigurationError', 'All elements of refillClusters are set to 0'); 
end

if nTimeSamples < nInputData && nTimeSamples > 0
   data = data(1 : nTimeSamples, :);
   streamDataLabel = streamDataLabel(1 : nTimeSamples);
   
elseif nTimeSamples > nInputData
    if all(refillClusters ~= 0) % refill dataset
        
        pointsToAdd = nTimeSamples - nInputData;
        while(pointsToAdd > 0)
            
            if(pointsToAdd >= nInputData )
                n = nInputData;
            else
                n = pointsToAdd;
            end
            
            data = [data; data(1 : n, :)];
            lastLabel = streamDataLabel(end);
            labelsToAdd = streamDataLabel + lastLabel;
            streamDataLabel = [streamDataLabel; labelsToAdd(1 : n)];
            pointsToAdd = pointsToAdd - n;
        end
    else
        refillPool = [data, streamDataLabel];
        lastLabel = streamDataLabel(end);
        
        for i = 1 : size(refillClusters, 2)
            
            if(refillClusters(i) == 0)
                refillPool(refillPool(:, nDimensions + 1) == i, :) = [];
            end
        end
        
        nRefillPoints = size(refillPool, 1);
        refillStreamDataLabel = refillPool(:, nDimensions + 2);
        pointsToAdd = nTimeSamples - nInputData;
        
        while(pointsToAdd > 0)
            
            if(pointsToAdd >= nRefillPoints )
                n = nRefillPoints;
            else
                n = pointsToAdd;
            end
            
            data = [data; refillPool(1 : n, 1 : nDimensions + 1)];
            labelsToAdd = refillStreamDataLabel + lastLabel;
            streamDataLabel = [streamDataLabel; labelsToAdd(1 : n )];
            
            pointsToAdd = pointsToAdd - n;
            lastLabel = streamDataLabel(end);
        end
            
    end
end
end


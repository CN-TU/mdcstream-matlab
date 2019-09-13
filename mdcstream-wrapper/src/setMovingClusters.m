%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% [displacement, displacementRate, vectorChangeRate] = setMovingClusters(value, nClusters, compactness)
%
% Description: This function configures the cluster movement.
%   
%
% Inputs:
%   value: the movement configuration value. Can be either 'no', 
%          'few' or 'all'.
%   nClusters: the number of clusters
%   compactness: the compactness of the clusters
%
% Outputs:
%   displacement: the factor for the displacement vector 
%   displacementRate: the rate to apply the displacement vector
%   vectorChangeRate: the rate to change the displacement vector
%
% Author:     Denis Ojdanic <denis.ojdanic@yahoo.com>
% Supervisor: Félix Iglesias Vázquez <felix.iglesias@nt.tuwien.ac.at>
% Date: 12.05.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

function [displacement, displacementRate, vectorChangeRate] = setMovingClusters(value, nClusters, compactness)

CONST = constants('moving');

displacement = [];
displacementRate = [];
vectorChangeRate = [];

switch value
    case 'no' % none
        displacement = 0;
        displacementRate = 0;
        vectorChangeRate = 0;

    case 'few' % 10 - 25 percent
        threshold = randf(0.1, 0.25);
        
        displacement = [displacement compactness(1)];

        displacementRate = [displacementRate randf(CONST.MIN_DISPLACEMENT_RATE, CONST.MAX_DISPLACEMENT_RATE)];
        vectorChangeRate = [vectorChangeRate randf(CONST.MIN_VECTOR_CHANGE_RATE, CONST.MAX_VECTOR_CHANGE_RATE)];
        count = 1;    
        for i = 1 : nClusters - 1
            if (count / nClusters) < threshold
                count = count + 1;
                displacement = [displacement compactness(i)];
                displacementRate = [displacementRate randf(CONST.MIN_DISPLACEMENT_RATE, CONST.MAX_DISPLACEMENT_RATE)];
                vectorChangeRate = [vectorChangeRate randf(CONST.MIN_VECTOR_CHANGE_RATE, CONST.MAX_VECTOR_CHANGE_RATE)];
            else
                displacement = [displacement 0];
                displacementRate = [displacementRate 0];
                vectorChangeRate = [vectorChangeRate 0];
            end
        end
        
        
    case 'all' % all
        for i = 1 : nClusters
            displacement = [displacement compactness(i)];
            displacementRate = [displacementRate randf(CONST.MIN_DISPLACEMENT_RATE, CONST.MAX_DISPLACEMENT_RATE)];
            vectorChangeRate = [vectorChangeRate randf(CONST.MIN_VECTOR_CHANGE_RATE, CONST.MAX_VECTOR_CHANGE_RATE)];
        end
        
    otherwise
        error('setMovingClusters:ConfigurationError', 'Wrong input for movingClusters = %s', value);
end

end


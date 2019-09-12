%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% [multivariate, compactness, minClusterMass, distribution] = setDensityDiff(value, nClusters, nClusterPoints)
%
% Description: This function configures the density difference of the dataset.
%   
%
% Inputs:
%   value: the density difference configuration value. Can be either 'no', 
%          'two' or 'many'.
%   nClusters: the number of clusters
%   nClusterPoints: the number of outliers
%
% Outputs:
%   multivariate: the multivariate flag
%   compactness: the compacntess value for the clusters
%   minClusterMass: the minimum cluster mass
%   distribution: the cluster distribution
%
% Author:     Denis Ojdanic <denis.ojdanic@yahoo.com>
% Supervisor: Félix Iglesias Vázquez <felix.iglesias@nt.tuwien.ac.at>
% Date: 12.05.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

function [multivariate, compactness, minClusterMass, distribution] = setDensityDiff(value, nClusters, nClusterPoints)


CONST = constants('density');

compactness = [];
distribution = [];
multivariate = [];
minClusterMass = 0;

switch value
    
    case 'no'
        compactness = randf(CONST.MIN_COMPACTNESS, CONST.MAX_COMPACTNESS);
        
        minClusterMass = floor(nClusterPoints / nClusters);
        distribution = randi(6) * ones(1, nClusters);
        multivariate = sign(rand()-0.5);
        
    case 'two' 
       
        compactnessOne = randf(CONST.MIN_COMPACTNESS, CONST.MAX_COMPACTNESS / 2);
        compactnessTwo = randf(CONST.MAX_COMPACTNESS / 2, CONST.MAX_COMPACTNESS);
        
        distributionOne = randi(6);
        distributionTwo = randi(6);
        while(distributionTwo == distributionOne)
            distributionTwo = randi(6);
        end
        
        for i = 1 : nClusters
            if(mod(i, 2) == 1)
                compactness = [compactness compactnessOne];
                distribution = [distribution distributionOne];
            else
                compactness = [compactness compactnessTwo];
                distribution = [distribution distributionTwo];
            end
            multivariate = [multivariate, sign(rand()-0.5)];
        end
        
    case 'many'
        distribution = randi(6, nClusters, 1)';
        for i = 1 : nClusters
           multivariate = [multivariate, sign(rand()-0.5)];
           compactness = [compactness randf(CONST.MIN_COMPACTNESS, CONST.MAX_COMPACTNESS)];           
        end
    otherwise
        error('setDensityDiff:ConfigurationError', 'Wrong input for densityDiff = %s', value);
end

end


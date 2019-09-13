%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% timeBetweenSamples = nonStationaryErgodicTimeBetweenSamples(tbsDistribution, nDataPoints, mu, sigma)
%
% Description: This function creates a non stationary ergodic time between
%              samples distribution.
%   
% Inputs:
%   tbsDistribution: time between samples distribution to use
%   pointsPerCluster: number of datapoints per cluster
%   mu: mu represents the center of the distribution
%   sigma: deviation around mu
%
% Outputs:
%   clusterTbs: time between samples per cluster with corresponding cluster
%               label
%
% Author:     Denis Ojdanic <denis.ojdanic@yahoo.com>
% Supervisor: Félix Iglesias Vázquez <felix.iglesias@nt.tuwien.ac.at>
% Date: 12.04.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
function [clusterTbs] = nonStationaryErgodicTimeBetweenSamples(tbsDistribution, pointsPerCluster, mu, sigma)

for i = 1 : size(tbsDistribution, 2)
    if tbsDistribution(i) == 0
        tbsDistribution(i) = 1 + floor(6 * rand());
    end
end

clusterTbs = [];
nClusters = size(tbsDistribution, 2);

for iCluster = 1 : nClusters

    switch tbsDistribution(iCluster) 
        case 1, probabilityDistribution = makedist('Uniform', 'Lower', mu(iCluster) - sigma(iCluster), 'Upper', mu(iCluster) + sigma(iCluster));
        case 2, probabilityDistribution = makedist('Normal', 'mu', mu(iCluster), 'sigma', sigma(iCluster));      
        case 3, probabilityDistribution = makedist('Logistic', 'mu', mu(iCluster), 'sigma', sigma(iCluster));
        case 4, probabilityDistribution = makedist('Triangular', 'a', mu(iCluster) - sigma(iCluster), 'b', mu(iCluster), 'c', mu(iCluster) + sigma(iCluster));
        case 5, probabilityDistribution = makedist('Uniform', 'Lower', mu(iCluster) - sigma(iCluster), 'Upper', mu(iCluster) + sigma(iCluster));
            %case 5, probabilityDistribution = makedist('Gamma', 'a', 2 + 8 * rand(), 'b', sigma(iCluster) / 5);
        case 6, probabilityDistribution = makedist('Normal', 'mu', mu(iCluster), 'sigma', sigma(iCluster)); % Ring distribution
        otherwise, error('nonStationaryErgodicTimeBetweenSamples:ConfigurationError', "Wrong tbs distribution specified = %d.", tbsDistribution(iCluster));
    end

    timeBetweenSamples = random(probabilityDistribution, pointsPerCluster(iCluster), 1);

    if size(timeBetweenSamples(timeBetweenSamples < 0), 1) > 0
        timeBetweenSamples(timeBetweenSamples < 0) = timeBetweenSamples(timeBetweenSamples < 0) * - 1;
        warning('Tbs distribution adapted for cluster = %d due to negative tbs values. ', iCluster);
    end

    if tbsDistribution(iCluster) == 6
        Npi = random(probabilityDistribution, 2 * pointsPerCluster(iCluster), 1);
        a25 = quantile(Npi, 0.251);
        a75 = quantile(Npi, 0.749);
        timeBetweenSamples = Npi(Npi < a25 | Npi > a75)';
        timeBetweenSamples = timeBetweenSamples(1 : pointsPerCluster(iCluster))';

        if size(timeBetweenSamples(timeBetweenSamples < 0), 1) > 0
            timeBetweenSamples(timeBetweenSamples < 0) = timeBetweenSamples(timeBetweenSamples < 0) * - 1;
            warning('Tbs distribution adapted for cluster = %d due to negative tbs values. ', iCluster);
        end

    end
    clusterTbs = [clusterTbs; cumsum(timeBetweenSamples)];
end

end


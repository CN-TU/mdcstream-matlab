%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% timeBetweenSamples = stationaryErgodicBetweenSamples(tbsDistribution, nDataPoints, mu, sigma)
%
% Description: This function creates a stationary ergodic time between
%              samples distribution.
%   
% Inputs:
%   tbsDistribution: time between samples distribution to use
%   nDataPoints: number of datapoints
%   mu: mu represents the center of the distribution
%   sigma: deviation around mu
%
% Outputs:
%   timeBetweenSamples: time between samples 
%
% Author:     Denis Ojdanic <denis.ojdanic@yahoo.com>
% Supervisor: Félix Iglesias Vázquez <felix.iglesias@nt.tuwien.ac.at>
% Date: 02.04.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
function [timeBetweenSamples] = stationaryErgodicTimeBetweenSamples(tbsDistribution, nDataPoints, mu, sigma)

if tbsDistribution == 0
    tbsDistribution = 1 + floor(6 * rand());
end

switch tbsDistribution 
    case 1, probabilityDistribution = makedist('Uniform', 'Lower', mu - sigma, 'Upper', mu + sigma);
    case 2, probabilityDistribution = makedist('Normal', 'mu', mu, 'sigma', sigma);      
    case 3, probabilityDistribution = makedist('Logistic', 'mu', mu, 'sigma', sigma);
    case 4, probabilityDistribution = makedist('Triangular', 'a', mu - sigma, 'b', mu, 'c', mu + sigma);
    case 5, probabilityDistribution = makedist('Uniform', 'Lower', mu - sigma, 'Upper', mu + sigma);
   % case 5, probabilityDistribution = makedist('Gamma', 'a', 2 + 8 * rand(), 'b', sigma / 5);
    case 6, probabilityDistribution = makedist('Normal', 'mu', mu, 'sigma', sigma); % Ring distribution
    otherwise, error('stationaryErgodicTimeBetweenSamples:ConfigurationError', "Wrong tbs distribution specified = %d.", tbsDistribution);
end


timeBetweenSamples = random(probabilityDistribution, nDataPoints, 1);

if size(timeBetweenSamples(timeBetweenSamples < 0), 1) > 0
    timeBetweenSamples(timeBetweenSamples < 0) = timeBetweenSamples(timeBetweenSamples < 0) * - 1;
    warning('Tbs distribution adapted due to negative tbs values. ');
end

if tbsDistribution == 6
    Npi = random(probabilityDistribution, 2 * nDataPoints, 1);
    a25 = quantile(Npi, 0.251);
    a75 = quantile(Npi, 0.749);
    timeBetweenSamples = Npi(Npi < a25 | Npi > a75)';
    timeBetweenSamples = timeBetweenSamples(1 : nDataPoints)';
    
    if size(timeBetweenSamples(timeBetweenSamples < 0), 1) > 0
        timeBetweenSamples(timeBetweenSamples < 0) = timeBetweenSamples(timeBetweenSamples < 0) * - 1;
        warning('Tbs distribution adapted due to negative tbs values. ');
    end
    
end


end


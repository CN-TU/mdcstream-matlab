%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% nOutliers = setNOutliers(value, nTotalPoints)
%
% Description: This function configures the number of outliers of the dataset.
%   
%
% Inputs:
%   value: the nOuliers configuration value. Can be either 'no', 
%          'few', 'medium' or 'many'.
%   nTotalPoints: the total amount of points for the dataset
%
% Outputs:
%   nOutliers: the number of outliers
%
% Author:     Denis Ojdanic <denis.ojdanic@yahoo.com>
% Supervisor: Félix Iglesias Vázquez <felix.iglesias@nt.tuwien.ac.at>
% Date: 12.05.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

function nOutliers = setNOutliers(value, nTotalPoints)

switch value
    case 'no'
        nOutliers = 0;
    case 'few' % 0 - 5 percent
        nOutliers = floor(randf(0.01, 0.05) * nTotalPoints);

    case 'medium' % 5 - 15 percent
        nOutliers = floor(randf(0.05, 0.15) * nTotalPoints);
        
    case 'many' % 15 - 40 percent
        nOutliers = floor(randf(0.15, 0.4) * nTotalPoints);
    otherwise
        error('setNOutliers:ConfigurationError', 'Wrong input for outliers = %s', value);
end

end


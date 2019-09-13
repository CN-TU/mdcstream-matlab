%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% imensions = setDimensions(value) 
%
% Description: This function configures the number of dimensions for the dataset.
%   
%
% Inputs:
%   value: the nDimensions configuration value. Can be either 'two', or 'many'.
%
% Outputs:
%   dimensions: the number of dimensions
%
% Author:     Denis Ojdanic <denis.ojdanic@yahoo.com>
% Supervisor: Félix Iglesias Vázquez <felix.iglesias@nt.tuwien.ac.at>
% Date: 12.05.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

function dimensions = setDimensions(value)

switch value
    case 'two' %% 2 dimensions
        dimensions = 2;
        
    case 'many'  % 3 - 30 dimensions
        dimensions = randi([3 30]); 
    otherwise
        error('setDimensions:ConfigurationError', 'Wrong input for dimensions = %s', value);
end

end


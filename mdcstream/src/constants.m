%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% CONST = constants(select)
%
% Description: This function contains the constants for msdgen
%   
%
% Inputs:
%   select: selects which constants to return
%
% Outputs:
%   CONST: a struct containint the selected constants
%
% Author:     Denis Ojdanic <denis.ojdanic@yahoo.com>
% Supervisor: Félix Iglesias Vázquez <felix.iglesias@nt.tuwien.ac.at>
% Date: 12.05.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

function CONST = constants(select)

switch select
  
    case 'nDataPoints' 
        CONST.MAX_NPOINTS = 10000;
        CONST.MIN_NPOINTS = 10000;
        
    case 'moving'
        CONST.MIN_DISPLACEMENT_RATE = 0.03;
        CONST.MAX_DISPLACEMENT_RATE = 0.1;
        
        CONST.MIN_VECTOR_CHANGE_RATE = 0.1;
        CONST.MAX_VECTOR_CHANGE_RATE = 0.2;
        
    case 'stationary'
        CONST.MAX_MU = 10;
        CONST.MIN_MU = 2;
        
        CONST.MAX_SIGMA = 2;
        CONST.MIN_SIGMA = 0.1;
        
        % MIN and MAX Mu for nonstationary clusters that are visible 
        % throughout the whole time of the dataset 
        CONST.MAX_REMAIN_MU = 30;
        CONST.MIN_REMAIN_MU = 20;
        
        
    case 'space'
        % constants for the extensive space
        CONST.MIN_ALPHA_FACTOR = 10;
        CONST.MAX_ALPHA_FACTOR = 20;
    
    case 'density'
        % initial compactness range
        CONST.MIN_COMPACTNESS = 0.02;
        CONST.MAX_COMPACTNESS = 0.2;
        
    case 'overlap'
        CONST.NO_OVERLAP_FACTOR = 0.5;
        CONST.OVERLAP_FACTOR = 4;
        
        CONST.DISTRIBUTION_ONE = 0.8;
        CONST.DISTRIBUTION_TWO = 0.5;
        CONST.DISTRIBUTION_THREE = 0.2;
        CONST.DISTRIBUTION_FOUR = 0.7;
        CONST.DISTRIBUTION_FIVE = 0.4;
        CONST.DISTRIBUTION_SIX = 0.2;
        
        
    case 'default'
        CONST.SEED = RandStream.shuffleSeed;  
        CONST.DIMENSIONS = 'two';
        CONST.CLUSTERS = 'few';
        CONST.OUTLIERS = 'few';
        CONST.DIFF = 'no';
        CONST.OVERLAP = 'no';
        CONST.DENSITY_DIFF = 'no';
        CONST.SPACE = 'tight';
        CONST.STATIONARY = 'stationary';
        CONST.MOVING_CLUSTERS = 'no'; 
        
               
    otherwise
        error('constants:initializationError', 'Using wrong constant selector %s', select);
        
end






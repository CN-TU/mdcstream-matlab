%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% timeBetweenSamples = addSimultaneousSamples(simultaneous, maxSimultaneous, timeSamples)
%
% Description: This function creates simultaneous time samples
%
% Inputs:
%   simultaneous: percentage of time samples to be simultaneous
%   maxSimultaneous: the maximum number of consecutive simultaneous time
%                    samples
%   timeBetweenSamples: time between samples to use
%
% Outputs:
%   timeBetweenSamples: time between samples with simultaneous samples
%
% Author:     Denis Ojdanic <denis.ojdanic@yahoo.com>
% Supervisor: Félix Iglesias Vázquez <felix.iglesias@nt.tuwien.ac.at>
% Date: 02.04.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
function [timeBetweenSamples] = addSimultaneousSamples(simultaneous, maxSimultaneous, timeBetweenSamples)

nDataPoints = size(timeBetweenSamples, 1);

if simultaneous > 0 
   indices = randperm(nDataPoints - 1, floor(nDataPoints * simultaneous) ) + 1; % ensure not to select first element
   timeBetweenSamples(indices) = 0;
end

if maxSimultaneous > 0 && simultaneous > 0
    threshold = ((maxSimultaneous - 1) / maxSimultaneous) - 0.1; % -0.1 to increase performance

    if(simultaneous > threshold)
       error('addSimultaneousSamples:ConfigurationError', "Simultaneous = %d can be maximally %d for given maxSimultaneous = %d ", simultaneous, threshold, maxSimultaneous);  
    end

    consecutiveCount = 0;
    done = false;
    
    while(~done)
        sorted = true;
        
        for i = 1 : nDataPoints
            
            if(timeBetweenSamples(i) == 0)    
                consecutiveCount = consecutiveCount + 1;
                if consecutiveCount >= maxSimultaneous
                    sorted = false;
                    j = i;
                    while (j <= nDataPoints)
                        j = j + 1;
                        if(j > nDataPoints)
                            j = 1; 
                        end
                        if(timeBetweenSamples(j) > 0)
                           swap = timeBetweenSamples(j);
                           timeBetweenSamples(j) = timeBetweenSamples(i);
                           timeBetweenSamples(i) = swap;
                           consecutiveCount = 0;
                           break;
                        end
                    end
                end
            else
               consecutiveCount = 0; 
            end
        end
        if(sorted)
            done = true;
        end
    end
end

end % function end






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% displayStream(data, dim1, dim2, speed)
%
% Description: This function displays a dataset in a continuous figure
%   
% Inputs:
%   data: Data to display
%   dim1: dimension one to display
%   dim2: dimension two to display
%   speed: fraction for displaying speed of the figure
%
% Author:     Denis Ojdanic <denis.ojdanic@yahoo.com>
% Supervisor: Félix Iglesias Vázquez <felix.iglesias@nt.tuwien.ac.at>
% Date: 25.04.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

function displayStream(data, dim1, dim2, speed)

if ~exist('data') 
    error('displayStream:InputArgument', 'No data provided to display'); 
end

if ~isfield(data,'dataPoints')
    error('displayStream:InputArgument', 'No dataPoints provided to display'); 
end

if ~isfield(data,'streamDataLabel')
    error('displayStream:InputArgument', 'No streamDataLabel provided to display'); 
end

if ~exist('dim1') 
   dim1 = 1; 
end

if ~exist('dim2')
   dim2 = 2; 
end

if ~exist('speed')
   speed = 0.005; 
end

points = data.dataPoints;
streamLabel = data.streamDataLabel;

nDimensions = size(points, 2);

if dim1 > nDimensions || dim2 > nDimensions
   error('displayStream:InputArgument', 'Dimensions to display can not exceed maximum number of dataset dimensions = %d', nDimensions); 
end


lastSplit = -100000000;
percent = 0;

max1 = max(points(:, dim1));
min1 = min(points(:, dim1));

max2 = max(points(:, dim2));
min2 = min(points(:, dim2));

length = max([abs(max1 - min1) abs(max2 - min2)]) / 2 + 0.2;
middle1 = (max1 + min1) / 2;
middle2 = (max2 + min2) / 2;


close all
figure

hold on

% figure size
axis([(middle1 - length) (middle1 + length) (middle2 - length) (middle2 + length)]); 
grid on

tic
fprintf('Drawing plot ');

lastLabel = max(data.streamDataLabel);
split = lastLabel * speed;
for i = 1 : split : lastLabel
    
    scatter(points(streamLabel > lastSplit & streamLabel < i,dim1),points(streamLabel > lastSplit & streamLabel < i,dim2),10,'fill', 'b');
    pause(0.05);
    lastSplit = i;
    
    passed = (i / lastLabel) * 100;
    if passed > percent
        fprintf('.');
        percent = percent + 10;
    end
end


fprintf(' finished. \n');
toc
fprintf('\n');

end


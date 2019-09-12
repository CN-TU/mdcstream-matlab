%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% displayStatic(data, dim1, dim2)
%
% Description: This function displays a dataset 
%   
% Inputs:
%   data: Data to display
%   dim1: dimension one to display
%   dim2: dimension two to display
%
% Author:     Denis Ojdanic <denis.ojdanic@yahoo.com>
% Supervisor: Félix Iglesias Vázquez <felix.iglesias@nt.tuwien.ac.at>
% Date: 25.04.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

function displayStatic(dataIn, dim1, dim2)


if ~exist('dataIn') 
    error('displayStream:InputArgument', 'No data provided to display'); 
end

if ~isfield(dataIn,'dataPoints')
    error('displayStream:InputArgument', 'No dataPoints provided to display'); 
end

if ~exist('dim1') 
   dim1 = 1; 
end

if ~exist('dim2')
   dim2 = 2; 
end

%data = [dataIn.dataPoints, dataIn.label, dataIn.streamDataLabel];

points = dataIn.dataPoints;
nDimensions = size(points, 2);

if dim1 > nDimensions || dim2 > nDimensions
   error('displayStream:InputArgument', 'Dimensions to display can not exceed maximum number of dataset dimensions = %d', nDimensions); 
end

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
%axis([-2 2 -2 2])

grid on

fprintf('Drawing plot...\n'); 
scatter(points(:,dim1),points(:,dim2),10,'fill', 'b');
tic 
toc

end


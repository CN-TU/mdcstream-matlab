%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% function writeArff(data, path, fname)
%
% Description: 
%   This function creates a .arff file based on an input dataset
%
% Inputs:
%   data:   m x n matrix where m is the number of data points and n - 1 is
%           the number of features. The last column is the class as integer
%   path:   path to the folder to save the data
%   fname:  the name of the outputfile without extension
%
% Outputs:
%   Creates an .arff file
%
% Author: Denis Ojdanic
% Date: 20.06.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

function writeArff(data, path, fname)

nDimensions = size(data,2)-1;
filename = strcat(path, fname,'.arff');
outFile = fopen (filename, 'w+');

relation = strcat('@relation',{' '},fname,'-weka.filters.unsupervised.attribute.NumericToNominal-Rlast');
fprintf (outFile, '%s\n', char(relation));

for dataColumn = 1 : nDimensions
    fprintf (outFile, '@attribute %s numeric\n',num2str(dataColumn));
end

nClasses = max(unique(data(:,end)));
classText=strcat('@attribute class {');

for iClass = 1 : nClasses
   classText = strcat(classText, num2str(iClass - 1),{','});    
end
classText = strcat(classText,num2str(iClass),{'}'});

fprintf (outFile, '%s\n\n',char(classText));
fprintf (outFile,'@data\n');
fclose(outFile);
dlmwrite (filename, data, '-append' );

end


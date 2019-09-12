warning('backtrace', 'off')
%clear

if(~isdeployed)
  cd(fileparts(which('msdgenExample.m')));
end

addpath(genpath('src'));


p.dimensions      = 'two';
p.stationary      = 'sequential';
p.outliers        = 'few'; 
p.clusters        = 'few';
p.densityDiff     = 'many';
p.space           = 'tight';
p.movingClusters  = 'no';
p.overlap         = 'no';
        
fprintf("\n\n --------------------------------- \n");
fprintf("        RUNNING NEW EXAMPLE \n");
fprintf(" --------------------------------- \n\n");
[result, ~] = mdcStream(p);               
      

data = [result.dataPoints, result.label, result.streamDataLabel];
data = sortrows(data, size(result.dataPoints, 2) + 2);
data = data(:, 1 : size(result.dataPoints, 2) + 1);

%writeArff(data, "/home/denis/master/masterThesis/master-thesis/msdgen-matlab-master/", "data");
%writeArff(data, "/home/denis/master/masterThesis/master-thesis/msdgen-matlab-master/dataRoot/scenarioA/arff/", "lala");
%writeArff(data, "", "lala");
%fprintf(" ------------done------------ \n\n");

displayStatic(result);
displayStream(result);
displayRecent(result);
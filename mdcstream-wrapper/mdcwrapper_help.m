function [] = mdcwrapper_help()

fprintf('--------------------- Configuration options ---------------------\n\n');
fprintf('.seed:             A seed to replicate the data sets. If not configured mdcstream-wrapper will use random seed.\n');
fprintf('.scenarioName:     The name of the scenario                        \n');
fprintf('.nOfDataSets:      Number of data sets per scenario   \n');
fprintf("\n");
fprintf(".dimensions:       ['two', 'many']                                Number of dimensions  \n");
fprintf(".stationarity:     ['stationary', 'sequential', 'nonstationary']  Time behaviour of the data set \n");
fprintf(".outliers:         ['no', 'few', 'medium', 'many']                Number of outliers \n");
fprintf(".clusters:         ['one', 'few', 'many']                         Number of clusters \n");
fprintf(".densityDiff:      ['two', 'many']                                Densities of the clusters \n");
fprintf(".space:            ['tight', 'extensive']                         Represents the overall space for the datapoints \n");
fprintf(".movingClusters:   ['no', 'few', 'all']                           Whether clusters should move over time \n");
fprintf(".overlap:          ['no', 'yes']                                  Cluster overlap (only in tight spave) \n");
fprintf('\n------------------- Configuration options end -------------------\n\n\n\n');
end
 








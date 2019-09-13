function logConfig(mdcConfig, tempMDCConfig, streamConfig)


fprintf('\n ---------- MDCGen ---------- \n\n' );
print(mdcConfig.seed, 'seed');
fprintf('nDimensions = %d \n', mdcConfig.nDimensions);
fprintf('nDataPoints = %d \n', mdcConfig.nDatapoints);
fprintf('nOutliers = %d ( %.2f %%) \n', mdcConfig.nOutliers, 100 * (mdcConfig.nOutliers / (mdcConfig.nDatapoints + mdcConfig.nOutliers)));
fprintf('nClusters = %d \n', mdcConfig.nClusters);
print(mdcConfig.distribution, 'distribution');
print(tempMDCConfig.pointsPerCluster, 'pointsPerCluster');
print(mdcConfig.multivariate, 'multivariate');
print(mdcConfig.compactness, 'compactness');
fprintf('minimumClusterMass = %d \n', mdcConfig.minimumClusterMass);
fprintf('alphaFactor = %d \n', mdcConfig.alphaFactor);
print(mdcConfig.alpha, 'alpha');



fprintf('\n ---------- STREAMGEN ---------- \n\n' );
fprintf('tbsDistribution = %d \n', streamConfig.tbsDistribution);
print(streamConfig.mu, 'mu');
print(streamConfig.sigma, 'sigma');
fprintf('simultaneous = %d \n', streamConfig.simultaneous);
fprintf('stationary = %d \n', streamConfig.stationary);
print(streamConfig.startTime, 'startTime');
print(streamConfig.startAfterCluster, 'startAfterCluster');

print(streamConfig.displacement, 'displacement');
print(streamConfig.displacementRate, 'displacementRate');
print(streamConfig.vectorChangeRate, 'vectorChangeRate');


fprintf('--------------------------------------------\n\n' );

end


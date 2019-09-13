classdef MdcstreamTest < matlab.unittest.TestCase

        
    properties
        inputData;
        config;
        streamConfig;
        result;
        nClusters;
        pointsPerCluster;
        nDimensions = 3;
        outlierFlag;
        referenceResult;
    end
    
    methods(TestMethodSetup)
        function setup(this)
            addpath(genpath('../src'));
            addpath(genpath('../../config_build/src'));
            warning off
            rng(18);
            this.config.tbsDistribution = 1;
            this.config.mu = 3;
            this.config.sigma = 0.2;
            this.config.simultaneous = 0;
            this.config.maxSimultaneous = 0;
            this.config.stationary = 1;
            this.config.startTime = 0;
            this.config.startAfterCluster = 0;
            this.config.nDataPoints = [];
            this.config.nTimeSamples = 0;
            this.nClusters = 1;
            this.pointsPerCluster = [];
            this.nDimensions = 3;
            this.outlierFlag = 0;
        end
    end
    
    methods (Test)
        
        %%% R001 %%%        
        %%% R003 %%%
        %%% R018 %%%
        %%% R019 %%%
        function testUniformTbsDistribution(this)
            givenTbsDistributionIsSetTo(1, this);
            givenNDatapointsIsSetTo(10000, this);
            givenMuIsSetTo(0.5, this);
            givenSigmaIsSetTo(0.2, this);
            whenMdcstreamIsCalled(this);
            thenStreamDataLabelDistributionPerClusterShouldBe(1 , this);
        end
        
        %%% R002 %%% 
        function testConstantTbs(this)
            givenTbsDistributionIsSetTo(1, this);
            givenNDatapointsIsSetTo(100, this);
            givenMuIsSetTo(1, this);
            givenSigmaIsSetTo(0.0000002, this);
            whenMdcstreamIsCalled(this);
            thenStreamDataLabelShouldBeConstant(this);
        end
        
        %%% R001 %%%
        %%% R003 %%%
        function testGaussianTbsDistribution(this)
            givenTbsDistributionIsSetTo(2, this);
            givenNDatapointsIsSetTo(10000, this);
            givenMuIsSetTo(2, this);
            givenSigmaIsSetTo(0.4, this);
            whenMdcstreamIsCalled(this);
            thenStreamDataLabelDistributionPerClusterShouldBe(2 , this);
        end
        
        %%% R001 %%%
        %%% R003 %%%
        function testLogisticTbsDistribution(this)
            givenTbsDistributionIsSetTo(3, this);
            givenNDatapointsIsSetTo(50000, this);
            givenMuIsSetTo(7, this);
            givenSigmaIsSetTo(0.2, this);
            whenMdcstreamIsCalled(this);
            thenStreamDataLabelDistributionPerClusterShouldBe(3 , this);
        end
        
        %%% R001 %%%
        %%% R003 %%%
        function testTriangularTbsDistribution(this)
            givenTbsDistributionIsSetTo(4, this);
            givenNDatapointsIsSetTo(50000, this);
            givenMuIsSetTo(2, this);
            givenSigmaIsSetTo(0.2, this);
            whenMdcstreamIsCalled(this);
            thenStreamDataLabelDistributionPerClusterShouldBe(4 , this);
        end
        
        %%% R001 %%%
        %%% R003 %%%
        function testRingTbsDistribution(this)
            givenTbsDistributionIsSetTo(6, this);
            givenNDatapointsIsSetTo(50000, this);
            givenMuIsSetTo(3, this);
            givenSigmaIsSetTo(0.2, this);
            whenMdcstreamIsCalled(this);
            thenStreamDataLabelDistributionPerClusterShouldBe(6 , this);
        end
        
        %%% R005 %%%
        function testSimultaneousSamples(this)
            givenTbsDistributionIsSetTo(2, this);
            givenNDatapointsIsSetTo(5000, this);
            givenNTimeSamplesIsSetTo(10000, this);
            givenSimultaneousIsSetTo(0.1, this);
            whenMdcstreamIsCalled(this);
            thenPercentageOfSimultaneousStreamDataLabelsShouldBe(0.1, this);
        end
        
        %%% R006 %%%
        function testMaxSimultaneousSamples(this)
            givenTbsDistributionIsSetTo(2, this);
            givenNDatapointsIsSetTo(50000, this);
            givenSimultaneousIsSetTo(0.5, this);
            givenMaxSimultaneousIsSetTo(3, this);
            whenMdcstreamIsCalled(this);
            thenConsecutiveSimultaneousTimeSamplesShouldNotExceed(3, this);
        end
        
        %%% R007 %%%
        function testReproduceDataSet(this)
            givenNDatapointsIsSetTo(100, this);
            givenSeedIsSetTo(18, this);
            givenMdcstreamIsCalled(this);
            this.referenceResult = this.result;
            
            givenSeedIsSetTo(18, this);
            whenMdcstreamIsCalled(this);
            thenOutputDatasetsAreEqual(this);
        end
        
        %%% R009 %%%
        function testNonStationaryData_A(this)
            givenNClustersIsSetTo(4, this);
            givenTbsDistributionIsSetTo([1 2 1 3], this);
            givenNDatapointsIsSetTo(100000, this);
            givenMuIsSetTo([2, 2, 3, 4], this);
            givenSigmaIsSetTo([0.2, 0.2, 0.2, 0.2], this);
            givenStationaryIsSetTo(0, this);
            whenMdcstreamIsCalled(this);
            thenPercentageOfSimultaneousStreamDataLabelsShouldBeZero(this);
            thenStreamDataLabelDistributionPerClusterShouldBe([1 2 1 3], this);
        end
        
        %%% R009 %%%
        function testNonStationaryData_B(this)
            givenNClustersIsSetTo(2, this);
            givenTbsDistributionIsSetTo([1 2], this);
            givenNDatapointsIsSetTo(1120000, this);
            givenMuIsSetTo([2, 2], this);
            givenSigmaIsSetTo([0.00002, 0.00002], this);
            givenStationaryIsSetTo(0, this);
            whenMdcstreamIsCalled(this);
            thenPercentageOfSimultaneousStreamDataLabelsShouldBeZero(this);
            thenStreamDataLabelDistributionPerClusterShouldBe([1 2], this);            
        end
        
        %%% R009 %%%
        function testSimultaneousSamplesForNonStationaryData(this)
            givenNClustersIsSetTo(2, this);
            givenTbsDistributionIsSetTo([1 2], this);
            givenNDatapointsIsSetTo(10000, this);
            givenMuIsSetTo([2, 2], this);
            givenSigmaIsSetTo([0.00002, 0.00002], this);
            givenStationaryIsSetTo(0, this);
            givenSimultaneousIsSetTo(0.3, this);
            whenMdcstreamIsCalled(this);
            thenPercentageOfSimultaneousStreamDataLabelsShouldBe(0.3, this);
        end
        
        %%% R013 %%%
        function testStartTimeForClusters(this)
            givenNClustersIsSetTo(3, this);
            givenTbsDistributionIsSetTo([1 2 1], this);
            givenNDatapointsIsSetTo(10000, this);
            givenMuIsSetTo([2, 2, 2], this);
            givenSigmaIsSetTo([0.2, 0.2 0.2], this);
            givenStationaryIsSetTo(0, this);
            givenStartTimeIsSetTo([5, 40, 33], this);
            whenMdcstreamIsCalled(this);
            thenClusterStreamDataLabelStartTimeShouldBe([5, 40, 33], this);
        end
        
        %%% R014 %%%
        function testStartAfterCluster(this)
            givenNClustersIsSetTo(2, this);
            givenTbsDistributionIsSetTo([1 2], this);
            givenNDatapointsIsSetTo(100, this);
            givenMuIsSetTo([1, 1], this);
            givenSigmaIsSetTo([0.0002, 0.0002], this);
            givenStationaryIsSetTo(0, this);
            givenStartAfterClusterIsSetTo([0 1], this);         
            whenMdcstreamIsCalled(this);
            thenClusterStreamDataLabelStartTimeShouldBe([0, 51], this);
        end
        
        
        
        function testStartAfterCluster_B(this)
            givenNClustersIsSetTo(20, this);
            givenTbsDistributionIsSetTo(ones(1, 20), this);
            givenNDatapointsIsSetTo(100000, this);
            givenMuIsSetTo(ones(1, 20), this);
            givenSigmaIsSetTo(0.2 * ones(1, 20), this);
            givenStationaryIsSetTo(0, this);
            givenStartAfterClusterIsSetTo(0 : 19, this);         
            whenMdcstreamIsCalled(this);
            thenClustersShouldBeInSequentialOrder(0 : 20, this);
        end
        
        
        %%% R010 %%%
        %%% R011 %%%
        %%% R012 %%%
        function testNTimeSamplesGreaterThanNDataPoints_B(this)
            givenNDatapointsIsSetTo(100, this);
            givenNTimeSamplesIsSetTo(250, this);
            givenRefillClustersIsSetTo(1, this);
            whenMdcstreamIsCalled(this);
            thenNumberOfOutputDataPointsShouldBe(250, this);
        end
        
        %%% R010 %%%
        %%% R011 %%%
        %%% R012 %%%
        function testNTimeSamplesWithRefillClusters(this)
            givenNClustersIsSetTo(3, this);
            givenNDatapointsIsSetTo(30, this);
            givenNTimeSamplesIsSetTo(75, this);
            givenRefillClustersIsSetTo([1 0 1], this);
            whenMdcstreamIsCalled(this);
            thenNumberOfOutputDataPointsShouldBe(75 , this);
        end
    end
    
    methods
        
        function givenSeedIsSetTo(seed, this)
            this.config.seed = seed;
        end
        
        function givenStartAfterClusterIsSetTo(start, this)
           this.config.startAfterCluster = start; 
        end  
        
        function givenRefillClustersIsSetTo(refill, this)
           this.config.refillClusters = refill; 
        end       
        
        function givenNTimeSamplesIsSetTo(n, this)
           this.config.nTimeSamples = n; 
        end
        
        function givenMdcstreamConfigurationWasCreated(this)
            this.streamConfig = createMdcstreamConfiguration(this.config, this.nClusters, this.outlierFlag); 
        end
             
        function givenStartTimeIsSetTo(st, this)
           this.config.startTime = st; 
        end
        
        function givenNClustersIsSetTo(n, this)
            this.nClusters = n;
            this.config.startTime = zeros(1, n);
        end
        
        function givenStationaryIsSetTo(stat, this)
            this.config.stationary = stat;
        end
        
        function givenMaxSimultaneousIsSetTo(max, this)
           this.config.maxSimultaneous = max; 
        end
        
        function givenSimultaneousIsSetTo(sim, this)
           this.config.simultaneous = sim; 
        end
        
        function givenNDatapointsIsSetTo(n, this)
            this.inputData.dataPoints = rand(n,this.nDimensions);
            
            if(this.outlierFlag == 1)
               clusterLabels = this.nClusters + 1;
               dataPointLabel = 0;
            else
               clusterLabels = this.nClusters;
               dataPointLabel = 1;
            end
            
            
            C = 1;
            for i = 1 : n
                label(i) = dataPointLabel;
                if i > (C * n) / clusterLabels
                   this.pointsPerCluster = [this.pointsPerCluster, i - sum(this.pointsPerCluster)];
                   C = C + 1; 
                   dataPointLabel = dataPointLabel + 1; 
                end
            end
            this.pointsPerCluster = [this.pointsPerCluster, i - sum(this.pointsPerCluster)];
            this.inputData.label = label';
        end
        
        function givenTbsDistributionIsSetTo(tbsDistro, this)
            this.config.tbsDistribution = tbsDistro;
        end
        
        function givenMuIsSetTo(mu, this)
           this.config.mu = mu; 
        end
        
        function givenSigmaIsSetTo(sig, this)
           this.config.sigma = sig; 
        end
        
        function givenMdcstreamIsCalled(this)
            whenMdcstreamIsCalled(this);
        end
        
        function whenMdcstreamIsCalled(this)
            this.result = mdcstream(this.inputData, this.config);
        end
        
        function thenOutputDatasetsAreEqual(this)
            this.verifyEqual(this.result.dataPoints, this.referenceResult.dataPoints, "Output dataset dataPoints do not match");
            this.verifyEqual(this.result.label, this.referenceResult.label, "Output dataset labels do not match");
            this.verifyEqual(this.result.streamDataLabel, this.referenceResult.streamDataLabel, "Output dataset labels do not match");
        end
        
        function thenStreamDataLabelShouldBeConstant(this)
            label = this.result.streamDataLabel;
            nPoints = size(label, 1);
            this.verifyEqual(label, [1 : nPoints]', 'RelTol', 0.01,  "No constat tbs");
            
        end
        
        function thenStreamDataLabelDistributionPerClusterShouldBe(expectedDistro, this)
            data = [this.result.label, this.result.streamDataLabel];
            
            for i = 1 : this.nClusters
                this.result.streamDataLabel = data(data(:,1) == i, 2);
                
                switch(expectedDistro(i))
                    case 1
                        [ratioInner, ratioOuter] = extractInnerOuterRatio(this.config.mu(i), this.config.sigma(i) / 2, this);
                        this.verifyEqual(ratioInner, 0.5, 'RelTol', 0.15, "Stream data label is not uniform");
                        this.verifyEqual(ratioOuter, 0.5, 'RelTol', 0.15, "Stream data label is not uniform");
                        
                    case 2
                        [ratioInner, ratioOuter] = extractInnerOuterRatio(this.config.mu(i), this.config.sigma(i), this);
                        this.verifyEqual(ratioInner, 0.642, 'RelTol', 0.15, "Stream data label is not gaussian");
                        this.verifyEqual(ratioOuter, 0.358, 'RelTol', 0.15, "Stream data label is not gaussian");
                        
                    case 3
                        [ratioInner, ratioOuter] = extractInnerOuterRatio(this.config.mu(i), this.config.sigma(i), this);
                        this.verifyEqual(ratioInner, 0.463, 'RelTol', 0.15, "Stream data label is not logistic");
                        this.verifyEqual(ratioOuter, 0.536, 'RelTol', 0.15, "Stream data label is not logistic");
                        
                    case 4
                        [ratioInner, ratioOuter] = extractInnerOuterRatio(this.config.mu(i), this.config.sigma(i) / 2, this);
                        this.verifyEqual(ratioInner, 0.75, 'RelTol', 0.15, "Stream data label is not triangular");
                        this.verifyEqual(ratioOuter, 0.25, 'RelTol', 0.15, "Stream data label is not triangular");
                        
                    case 6
                        [ratioInner, ratioOuter] = extractInnerOuterRatio(this.config.mu(i), this.config.sigma(i) / 4, this);
                        this.verifyEqual(ratioInner, 0, 'RelTol', 0.15, "Stream data label is not ring");
                        this.verifyEqual(ratioOuter, 1, 'RelTol', 0.15, "Stream data label is not ring");
                end
            end 
        end
        
        function thenPercentageOfSimultaneousStreamDataLabelsShouldBeZero(this)
            nLabels = size(this.result.streamDataLabel, 1);
            nUniqueElements = size(unique(this.result.streamDataLabel), 1);
            nSimultaneous = nLabels - nUniqueElements;
            
            ratio = nSimultaneous / nLabels;
            
            this.verifyEqual(ratio, 0, "Stream data labels are simultaneous"); 
        end
     
        function thenPercentageOfSimultaneousStreamDataLabelsShouldBe(expectedPercent, this)
            nLabels = size(this.result.streamDataLabel, 1);
            nUniqueElements = size(unique(this.result.streamDataLabel), 1);
            nSimultaneous = nLabels - nUniqueElements;
            
            ratio = nSimultaneous / nLabels;
            
            this.verifyEqual(ratio, expectedPercent, 'RelTol', 0.001, "Stream data labels are not simultaneous as expected");
        end
        
        function thenConsecutiveSimultaneousTimeSamplesShouldNotExceed(max, this)
            
            count = 0;
            res = true;
            nPoints = size(this.result.streamDataLabel, 1);
            
            for i = 2 : nPoints
                
                if(this.result.streamDataLabel(i - 1) == this.result.streamDataLabel(i))
                    count = count + 1;
                    if (count > max)
                        res = false;
                    end
                else
                    count = 0;
                end
            end
            
            this.verifyTrue(res, "Max simultaneous stream data labels exceeds configured value");
        end
        
        function thenClustersShouldBeInSequentialOrder(expectedOrder, this)
            res = true;
            for iCluster = 1 : size(expectedOrder, 2) - 1
                idxLast = find(this.result.label == iCluster, 1, 'last');
                idxFirst = find(this.result.label == iCluster + 1, 1, 'first');
                if(this.result.streamDataLabel(idxLast) > this.result.streamDataLabel(idxFirst))
                    res = false;
                end
            end
            this.verifyTrue(res, 'The clusters are not in sequential order');
        end
        
        function thenClusterStreamDataLabelStartTimeShouldBe(expectedStartTime, this)
            for iCluster = 1 : size(expectedStartTime, 2)
                idxFirst = find(this.result.label == iCluster, 1, 'first');
                
                this.verifyEqual(this.result.streamDataLabel(idxFirst), expectedStartTime(iCluster) + this.config.mu(iCluster), 'RelTol', this.config.sigma(iCluster), 'The expected start time does not match the start time of the stream data labels');
            end
        end
        
        function thenNumberOfOutputDataPointsShouldBe(expectedN, this)
           actualN = size(this.result.streamDataLabel, 1);
           this.verifyEqual(actualN, expectedN, 'Expected nDatapoints not equal to actual nDatapoints');
        end
        
       
        function [ratioInner, ratioOuter] = extractInnerOuterRatio(mu, cutoff, this)
            elements = diff(this.result.streamDataLabel);
            nElements = size(this.result.streamDataLabel, 1);
            
            elements = elements - mu;
            
            innerElements = elements(elements > -cutoff & elements < cutoff);
            outerElements = elements(elements < -cutoff | elements > cutoff);
            
            nInnerElements = size(innerElements, 1);
            nOuterElements = size(outerElements, 1);
            
            ratioInner = nInnerElements / nElements;
            ratioOuter = nOuterElements / nElements;
        end
    end
end


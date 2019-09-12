classdef RefillDataPointsTest < matlab.unittest.TestCase

    
    properties
        nDimensions;
        mdcData;
        outlierFlag;
        nClusters;
        clusterLabel;
        nTimeSamples;
        streamDataLabel;
        refillClusters;
        actualData;
        actualStreamLabel;
    end
    
    methods(TestMethodSetup)
        function setup(this)
            addpath(genpath('../src'));
            rng(20);
            this.nDimensions = 3;
            this.outlierFlag = 0;
            this.nClusters = 4;
            this.refillClusters = 1; 
        end
    end
    
    methods (Test)
        
        function testNTimeSamplesSmallerThanNDataPoints(this)
            givenNDatapointsIsSetTo(100, this);
            givenNTimeSamplesIsSetTo(50, this);
            whenRefillDataPointsIsCalled(this);
            thenNumberOfOutputDataPointsShouldBe(50 , this);
            thenAddedPointsShouldHaveContinuingStreamDataLabel(this);
        end
        
        function testNTimeSamplesGreaterThanNDataPoints_A(this)
            givenNDatapointsIsSetTo(100, this);
            givenNTimeSamplesIsSetTo(150, this);
            givenRefillClustersIsSetTo(1, this);
            whenRefillDataPointsIsCalled(this);
            thenNumberOfOutputDataPointsShouldBe(150 , this);
            thenAddedPointsShouldHaveContinuingStreamDataLabel(this);
        end
        
        function testNTimeSamplesGreaterThanNDataPoints_B(this)
            givenNDatapointsIsSetTo(100, this);
            givenNTimeSamplesIsSetTo(250, this);
            givenRefillClustersIsSetTo(1, this);
            whenRefillDataPointsIsCalled(this);
            thenNumberOfOutputDataPointsShouldBe(250 , this);
            thenAddedPointsShouldHaveContinuingStreamDataLabel(this);
        end
        
        function testNTimeSamplesWithRefillClusters_A(this)
            givenNClustersIsSetTo(3, this);
            givenNDatapointsIsSetTo(30, this);
            givenNTimeSamplesIsSetTo(75, this);
            givenRefillClustersIsSetTo([1 0 1], this);
            whenRefillDataPointsIsCalled(this);
            thenNumberOfOutputDataPointsShouldBe(75 , this);
            thenAddedPointsShouldHaveContinuingStreamDataLabel(this);
        end
        
        function testNTimeSamplesWithRefillClusters_B(this)
            givenNClustersIsSetTo(7, this);
            givenNDatapointsIsSetTo(50, this);
            givenNTimeSamplesIsSetTo(200, this);
            givenRefillClustersIsSetTo([1 0 1 1 0 0 1], this);
            whenRefillDataPointsIsCalled(this);
            thenNumberOfOutputDataPointsShouldBe(200 , this);
            thenAddedPointsShouldHaveContinuingStreamDataLabel(this);
        end
        
        function testErrorIfClusterStartsAfterItself(this)
            givenNDatapointsIsSetTo(50, this);
            givenNTimeSamplesIsSetTo(200, this);
            whenRefillClustersIsSetTo([0 0 0 0], this);
            this.verifyError(@()refillDataPoints(this.refillClusters, this.nTimeSamples, this.mdcData, this.streamDataLabel),'refillDataPoints:ConfigurationError');  
        end
    end
    
    methods
        
        function whenRefillClustersIsSetTo(refill, this)
           givenRefillClustersIsSetTo(refill, this);
        end
       
        function givenRefillClustersIsSetTo(refill, this)
           this.refillClusters = refill; 
        end       
        
        function givenNTimeSamplesIsSetTo(n, this)
           this.nTimeSamples = n; 
        end
        
       
        function givenNClustersIsSetTo(n, this)
            this.nClusters = n;
        end
        
        function givenNDatapointsIsSetTo(n, this)
            this.mdcData = rand(n,this.nDimensions);
            
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
                   C = C + 1; 
                   dataPointLabel = dataPointLabel + 1; 
                end
            end
            this.clusterLabel = label';
            this.streamDataLabel = [1 : n]';
        end
                  
        function whenRefillDataPointsIsCalled(this)
            [this.actualData, this.actualStreamLabel] = refillDataPoints(this.refillClusters, this.nTimeSamples, this.mdcData, this.streamDataLabel);
        end
        
        function thenNumberOfOutputDataPointsShouldBe(expectedN, this)
           actualN = size(this.actualStreamLabel, 1);
           this.verifyEqual(actualN, expectedN, 'Expected nDatapoints not equal to actual nDatapoints');
        end
        
        function thenAddedPointsShouldHaveContinuingStreamDataLabel(this)
            this.verifyEqual(this.actualStreamLabel, [1 : this.nTimeSamples]', 'Stream data label not matching');
        end
      
    end
end


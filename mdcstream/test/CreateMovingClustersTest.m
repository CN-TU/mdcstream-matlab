classdef CreateMovingClustersTest < matlab.unittest.TestCase

     properties
        pointsPerCluster;
        clusterLabel;
        nDimensions;
        mdcData;
        result;
        displacement;
        displacementRate;
        vectorChangeRate;
    end
   
    methods(TestMethodSetup)
        function setup(this)
            addpath(genpath('../src'));
            rng(20);
            this.clusterLabel = [];
            this.nDimensions = 3;
            this.vectorChangeRate = 1;
        end
    end
    
    methods (Test)
        
        %%% R015 %%%
        %%% R016 %%%
        function testDataIsNotDisplacedWhenNoDisplacementSpecified(this)
            givenPointsPerClusterIsSetTo([0 5], this);
            givenDisplacementIsSetTo([0 0], this);
            givenDisplacementRateIsSetTo([1 0.5], this);
            whenCreateMovingClustersIsCalled(this);
            thenMdcDataShouldNotHaveMoved(this);
        end
        
        %%% R015 %%%
        %%% R016 %%%
        function testDataIsNotDisplacedWhenNoDisplacementRateIsSpecified(this)
            givenPointsPerClusterIsSetTo([0 5], this);
            givenDisplacementIsSetTo([0 0.5], this);
            givenDisplacementRateIsSetTo([0 0], this);
            whenCreateMovingClustersIsCalled(this);
            thenMdcDataShouldNotHaveMoved(this);
        end

        %%% R015 %%%
        %%% R016 %%%
        function testClusterIsDisplaced(this)
            givenPointsPerClusterIsSetTo([0, 10], this);
            givenDisplacementIsSetTo(0.8, this);
            givenDisplacementRateIsSetTo(0.1, this);
            whenCreateMovingClustersIsCalled(this);
            thenMdcDataShouldHaveMovedForCluster([0 1], this);
        end
        
        %%% R015 %%%
        %%% R016 %%%
        function testMultipleClustersDisplaced(this)
            givenPointsPerClusterIsSetTo([0, 10, 5, 5], this);
            givenDisplacementIsSetTo([0.2 0.4 0], this);
            givenDisplacementRateIsSetTo([0.5, 0.5 1], this);
            whenCreateMovingClustersIsCalled(this);
            thenMdcDataShouldHaveMovedForCluster([0 1 1 0], this);
        end
        
        %%% R015 %%%
        %%% R016 %%%
        function testOutliersAreNotDisplaced(this)
            givenPointsPerClusterIsSetTo([5, 10, 10], this);
            givenDisplacementIsSetTo([0.1, 0], this);
            givenDisplacementRateIsSetTo([0.5, 1], this);
            whenCreateMovingClustersIsCalled(this);
            thenMdcDataShouldHaveMovedForCluster([0 1 0], this);
        end
        
        %%% R015 %%%
        %%% R016 %%%
        function testDataIsDisplaced_A(this)
            givenDataIsSetTo([1; 1; 1; 1; 1; 1; 1; 1; 1; 1], this);
            givenDisplacementIsSetTo(1, this);
            givenDisplacementRateIsSetTo(0.5, this);
            whenCreateMovingClustersIsCalled(this);
            thenMdcDataPointsShouldBe([1; 1; 1; 1; 1; 2; 2; 2; 2; 2], this);
        end
        
        %%% R015 %%%
        %%% R016 %%%
        function testDataIsDisplaced_B(this)
            givenDataIsSetTo([1; 1; 1; 1; 1; 1; 1; 1; 1; 1], this);
            givenDisplacementIsSetTo(1, this);
            givenDisplacementRateIsSetTo(0.25, this);
            whenCreateMovingClustersIsCalled(this);
            thenMdcDataPointsShouldBe([1; 1; 2; 2; 2; 3; 3; 4; 4; 4], this);
        end
        
        %%% R015 %%%
        %%% R016 %%%
        function testDataIsDisplaced_C(this)
            givenDataIsSetTo([1; 1; 1; 1; 1; 1; 1; 1; 1; 1], this);
            givenDisplacementIsSetTo(2, this);
            givenDisplacementRateIsSetTo(0.5, this);
            whenCreateMovingClustersIsCalled(this);
            thenMdcDataPointsShouldBe([1; 1; 1; 1; 1; 3; 3; 3; 3; 3], this);
        end
        
        %%% R015 %%%
        %%% R016 %%%
        %%% R017 %%%
        function testDataIsDisplacedWithVectorChangeRate(this)
            givenDataIsSetTo([1; 1; 1; 1; 1; 1; 1; 1; 1; 1], this);
            givenDisplacementIsSetTo(2, this);
            givenDisplacementRateIsSetTo(0.5, this);
            givenVectorChangeRateIsSetTo(0.1, this);
            whenCreateMovingClustersIsCalled(this);
            thenMdcDataPointsShouldBe([1; 1; 1; 1; 1; -1; -1; -1; -1; -1], this);
        end
    end
    
    methods
        
        function givenVectorChangeRateIsSetTo(rate, this)
           this.vectorChangeRate = rate; 
        end
        
        function givenDataIsSetTo(data, this)
            this.nDimensions = 1;
            this.mdcData = [data, ones(size(data, 1), 2)];
        end
        
        function givenDisplacementRateIsSetTo(r, this)
           this.displacementRate = r; 
        end
        
        function givenDisplacementIsSetTo(dis, this)
           this.displacement = dis; 
        end
        
        function givenPointsPerClusterIsSetTo(n, this)
            this.pointsPerCluster = n;
            nClusters = size(this.pointsPerCluster, 2);
            data = [];
            label = [];
            for iCluster = 1 : nClusters
                
                nPoints = this.pointsPerCluster(iCluster);
                data = [data; rand(nPoints, this.nDimensions) ];
                label = [label; (iCluster - 1) * ones(nPoints, 1) ];
                
            end
            streamLabel = 1 : size(data, 1);
            this.mdcData = [data, label, streamLabel']; 
            this.vectorChangeRate = ones(1, nClusters);
        end
                     
        function whenCreateMovingClustersIsCalled(this)
            this.result = createMovingClusters(this.mdcData, this.displacement, this.displacementRate, this.vectorChangeRate);
        end
        
        function thenMdcDataShouldNotHaveMoved(this)
           res = verifyDataHasMoved(this.result(:, 1 : this.nDimensions), this.mdcData(:, 1 : this.nDimensions), false, this);
           this.verifyFalse(res, "data has moved");
        end
        
        function thenMdcDataShouldHaveMoved(this)
           res = verifyDataHasMoved(this.result(:, 1 : this.nDimensions), this.mdcData(:, 1 : this.nDimensions), true, this);
           this.verifyFalse(res, "data has moved");
        end
        
        function thenMdcDataShouldHaveMovedForCluster(movedFlag, this)
            nClusters = size(movedFlag, 2);
            res = [];
            for i = 1 : nClusters
                clusterResult = this.result(this.result(:, this.nDimensions + 1) == i - 1, :);
                clusterGiven = this.mdcData(this.mdcData(:, this.nDimensions + 1) == i - 1, :);            
                res = [res verifyDataHasMoved(clusterResult, clusterGiven, movedFlag(i), this)];
            end
            this.verifyEqual(res, movedFlag, "Not all clusters moved correctly");
        end
        
        function thenMdcDataPointsShouldBe(expected, this)
           this.verifyEqual(this.result(:, 1), expected, "Data does not match"); 
        end
        
        function hasMoved = verifyDataHasMoved(actual, expected, shouldHaveMoved,this)
           hasMoved = false;
           difference = actual(:, 1 : this.nDimensions) - expected(:, 1 : this.nDimensions);
                      
           if shouldHaveMoved
                if ( ~isempty( difference(difference ~= 0) ) )
                    hasMoved = true;
                end
           else
                if ( isempty( difference(difference ~= 0) ) )
                    hasMoved = false;
                end
           end
        end
        
    end
end


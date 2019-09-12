classdef AddClusterStartTimeTest < matlab.unittest.TestCase
        
    properties
        tbsCumsumPerCluster;
        pointsPerCluster;
        startTime;
        startAfterCluster;
        result;
    end
   
    methods(TestMethodSetup)
        function setup(this)
            addpath(genpath('../src'));
            rng(20);
            this.tbsCumsumPerCluster = [];
        end
    end
    
    methods (Test)
        
        function testClusterWithStartTime(this)
            givenPointsPerClusterIsSetTo([50, 30, 20], this);
            givenStartTimeIsSetTo([100, 12, 22], this);
            whenAddClusterStartTimeIsCalled(this);
            thenClusterStreamDataLabelStartTimeShouldBe([100, 12, 22], this);
        end
        
        function testClusterStartTimeStartsAfterCluster_A(this)
            givenPointsPerClusterIsSetTo([50, 30], this);
            givenStartAfterClusterIsSetTo([0 1], this);
            whenAddClusterStartTimeIsCalled(this);
            thenClusterStreamDataLabelStartTimeShouldBe([0, 49], this);
        end
        
        function testClusterStartTimeStartsAfterCluster_B(this)
            givenPointsPerClusterIsSetTo([10, 10], this);
            givenStartAfterClusterIsSetTo([2 0], this);
            whenAddClusterStartTimeIsCalled(this);
            thenClusterStreamDataLabelStartTimeShouldBe([9, 0], this);
        end
        
        function testStartTimeAndStartAfterClusterForFourClusters_A(this)
            givenPointsPerClusterIsSetTo([10, 10, 10, 10], this);
            givenStartAfterClusterIsSetTo([0 1 1 2], this);
            givenStartTimeIsSetTo([10, 0, 10, 20], this);
            whenAddClusterStartTimeIsCalled(this);
            thenClusterStreamDataLabelStartTimeShouldBe([10, 19, 29, 48], this);
        end
        
        function testStartTimeAndStartAfterClusterForFourClusters_B(this)
            givenPointsPerClusterIsSetTo([10, 10, 10, 10], this);
            givenStartAfterClusterIsSetTo([3 1 0 2], this);
            whenAddClusterStartTimeIsCalled(this);
            thenClusterStreamDataLabelStartTimeShouldBe([9, 18, 0, 27], this);
        end
        
        function testStartTimeAndStartAfterClusterForFourClusters_C(this)
            givenPointsPerClusterIsSetTo([10, 10, 10, 10], this);
            givenStartAfterClusterIsSetTo([2 0 0 3], this);
            givenStartTimeIsSetTo([0, 0, 10, 0], this);
            whenAddClusterStartTimeIsCalled(this);
            thenClusterStreamDataLabelStartTimeShouldBe([9, 0, 10, 19], this);
        end
        
                        
        function testErrorThrownOnWrongStartAfterCluster(this)
            givenPointsPerClusterIsSetTo([10, 10, 10, 10], this);
            whenStartAfterClusterIsSetTo([1 1 2 3], this);
            this.verifyError(@()addClusterStartTime(this.tbsCumsumPerCluster', this.pointsPerCluster, this.startTime, this.startAfterCluster),'addClusterStartTime:ConfigurationError');  
        end
        
        function testErrorOnStartAfterClusterPointingToNonExistingCluster_A(this)
            givenPointsPerClusterIsSetTo([10, 10, 10, 10], this);
            whenStartAfterClusterIsSetTo([0, 0, 5, 0], this);
            this.verifyError(@()addClusterStartTime(this.tbsCumsumPerCluster', this.pointsPerCluster, this.startTime, this.startAfterCluster),'addClusterStartTime:ConfigurationError');  
        end
        
        function testErrorOnStartAfterClusterPointingToNonExistingCluster_B(this)
            givenPointsPerClusterIsSetTo([10, 10, 10, 10], this);
            whenStartAfterClusterIsSetTo([0, 0, -5, 0], this);
            this.verifyError(@()addClusterStartTime(this.tbsCumsumPerCluster', this.pointsPerCluster, this.startTime, this.startAfterCluster),'addClusterStartTime:ConfigurationError');  
        end

        function testErrorIfClusterStartsAfterItself(this)
            givenPointsPerClusterIsSetTo([10, 10, 10, 10], this);
            whenStartAfterClusterIsSetTo([0, 2, 3, 4], this);
            this.verifyError(@()addClusterStartTime(this.tbsCumsumPerCluster', this.pointsPerCluster, this.startTime, this.startAfterCluster),'addClusterStartTime:ConfigurationError');  
        end
    end
    
    methods
        
        function givenPointsPerClusterIsSetTo(ptPerCluster, this)
            this.pointsPerCluster = ptPerCluster;
            for i = 1 : size(ptPerCluster, 2)
                this.tbsCumsumPerCluster = [this.tbsCumsumPerCluster, 1 : ptPerCluster(i) ]; 
            end
            this.tbsCumsumPerCluster = this.tbsCumsumPerCluster - 1;
            this.startTime = zeros(1, size(ptPerCluster, 2));
            this.startAfterCluster = zeros(1, size(ptPerCluster, 2));
        end
        
        function givenStartAfterClusterIsSetTo(start, this)
           this.startAfterCluster = start; 
        end
        
        function givenStartTimeIsSetTo(st, this)
           this.startTime = st; 
        end
        
        function whenStartAfterClusterIsSetTo(start, this)
           givenStartAfterClusterIsSetTo(start, this);
        end
                       
        function whenAddClusterStartTimeIsCalled(this)
            this.result = addClusterStartTime(this.tbsCumsumPerCluster', this.pointsPerCluster, this.startTime, this.startAfterCluster);
        end
               
        function thenClusterStreamDataLabelStartTimeShouldBe(expectedStartTime, this)
            for i = 1 : size(expectedStartTime, 2)
                if i == 1
                    st = this.result(1);
                else
                    aux = cumsum(this.pointsPerCluster(1 : i - 1));
                    st = this.result(aux(end) + 1);
                end
                this.verifyEqual(st, expectedStartTime(i), "The expected start time for cluster = " + i + " does not match the start time.");
            end
        end

    end
end


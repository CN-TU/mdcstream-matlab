classdef AddSimultaneousSamplesTest < matlab.unittest.TestCase
    
    properties
        simultaneous;
        maxSimultaneous;
        timeSamples;
        result;
    end
    
    methods(TestMethodSetup)
        function setup(this)
            addpath(genpath('../src'));
            rng(21);
            this.maxSimultaneous = 0;
        end
    end
    
    methods(Test)
        function testSimultaneousSamples_A(this)
            givenNumberOfTimeSamplesIsSetTo(1000, this);
            givenSimultaneousIsSetTo(0.3, this);
            whenAddSimultaneousSamplesIsCalled(this);
            thenPercentageOfSimultaneousStreamDataLabelsShouldBe(0.3, this);
        end

        function testSimultaneousSamples_B(this)
            givenNumberOfTimeSamplesIsSetTo(5000, this);
            givenSimultaneousIsSetTo(0.5, this);
            whenAddSimultaneousSamplesIsCalled(this);
            thenPercentageOfSimultaneousStreamDataLabelsShouldBe(0.5, this);
        end

        function testMaxSimultaneousSamples_A(this)
            givenNumberOfTimeSamplesIsSetTo(1000, this);
            givenSimultaneousIsSetTo(0.65, this);
            givenMaxSimultaneousIsSetTo(4, this);
            whenAddSimultaneousSamplesIsCalled(this);
            thenConsecutiveSimultaneousTimeSamplesShouldNotExceed(4, this);
        end
        
        function testMaxSimultaneousSamples_B(this)
            givenNumberOfTimeSamplesIsSetTo(5543, this);
            givenSimultaneousIsSetTo(0.4, this);
            givenMaxSimultaneousIsSetTo(2, this);
            whenAddSimultaneousSamplesIsCalled(this);
            thenConsecutiveSimultaneousTimeSamplesShouldNotExceed(2, this);
        end  
                
        function testErrorThrownOnWrongSimultaneous(this)
            givenNumberOfTimeSamplesIsSetTo(100, this);
            this.verifyError(@()addSimultaneousSamples(0.9, 2, this.timeSamples),'addSimultaneousSamples:ConfigurationError');  
        end
    end
    
    methods
        function givenNumberOfTimeSamplesIsSetTo(n, this)
           this.timeSamples = rand(n, 1); 
        end
        
        function givenSimultaneousIsSetTo(simul, this)
           this.simultaneous = simul; 
        end
        
        function givenMaxSimultaneousIsSetTo(max, this)
           this.maxSimultaneous = max; 
        end
        
        function givenNDatapointsIsSetTo(n, this)
            this.nDataPoints = n;
        end
        
        function whenAddSimultaneousSamplesIsCalled(this)
            this.result = addSimultaneousSamples(this.simultaneous, this.maxSimultaneous, this.timeSamples);
        end
        
        function thenPercentageOfSimultaneousStreamDataLabelsShouldBe(expectedPercent, this)
            nLabels = size(this.result, 1);
            nUniqueElements = size(unique(this.result), 1);
            nSimultaneous = nLabels - nUniqueElements;
            
            ratio = nSimultaneous / nLabels;
            
            this.verifyEqual(ratio, expectedPercent, 'RelTol', 0.05, "Stream data labels are not simultaneous as expected");
        end
        
        function thenConsecutiveSimultaneousTimeSamplesShouldNotExceed(max, this)
            
            count = 0;
            res = true;
            nDataPoints = size(this.result, 1);
            
            for i = 2 : nDataPoints
                
                if(this.result(i - 1) == this.result(i))
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
    end
end


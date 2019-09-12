classdef StationaryErgodicTimeBetweenSamplesTest < matlab.unittest.TestCase

        
    properties
        nDataPoints;
        tbsDistribution;
        streamDataLabel;
        sigma;
        mu;
    end
    
    methods(TestMethodSetup)
        function setup(this)
            addpath(genpath('../src'));
            warning off;
            rng(20);
            this.mu = 5;
            this.sigma = 0.2;
        end
    end
    
    methods (Test)
        
        %%% R008 %%%
        function testConstantTbsDistribution_A(this)
            givenTbsDistributionIsSetTo(1, this);
            givenNDatapointsIsSetTo(50000, this);
            givenMuIsSetTo(0.5, this);
            whenStationaryErgodicTimeBetweenSamplesIsCalled(this);
            thenTbsDistributionShouldBeUniform(this);
        end
               
        %%% R008 %%%
        function testGaussianTbsDistribution(this)
            givenTbsDistributionIsSetTo(2, this);
            givenNDatapointsIsSetTo(50000, this);
            givenMuIsSetTo(2, this);
            givenSigmaIsSetTo(0.4, this);
            whenStationaryErgodicTimeBetweenSamplesIsCalled(this);
            thenTbsDistributionShouldBeGaussian(this);
        end
        
        %%% R008 %%%
        function testLogisticTbsDistribution(this)
            givenTbsDistributionIsSetTo(3, this);
            givenNDatapointsIsSetTo(50000, this);
            givenMuIsSetTo(7, this);
            givenSigmaIsSetTo(0.2, this);
            whenStationaryErgodicTimeBetweenSamplesIsCalled(this);
            thenTbsDistributionShouldBeLogistic(this);
        end
        
        %%% R008 %%%
        function testTriangularTbsDistribution(this)
            givenTbsDistributionIsSetTo(4, this);
            givenNDatapointsIsSetTo(50000, this);
            givenMuIsSetTo(2, this);
            givenSigmaIsSetTo(0.2, this);
            whenStationaryErgodicTimeBetweenSamplesIsCalled(this);
            thenTbsDistributionShouldBeTriangular(this);
        end
        
        %%% R008 %%%
        function testRingTbsDistribution(this)
            givenTbsDistributionIsSetTo(6, this);
            givenNDatapointsIsSetTo(50000, this);
            givenMuIsSetTo(3, this);
            givenSigmaIsSetTo(0.2, this);
            whenStationaryErgodicTimeBetweenSamplesIsCalled(this);
            thenTbsDistributionShouldBeRing(this);
        end
        
        %%% R008 %%%
        function testNegativeTimeStampsMovedToPositive_Uniform(this)
            givenTbsDistributionIsSetTo(1, this);
            givenNDatapointsIsSetTo(500, this);
            givenMuIsSetTo(0.01, this);
            whenStationaryErgodicTimeBetweenSamplesIsCalled(this);
            thenTbsValuesShouldBePositive(this);
        end
        
        %%% R008 %%%
        function testNegativeTimeStampsMovedToPositive_Ring(this)
            givenTbsDistributionIsSetTo(6, this);
            givenNDatapointsIsSetTo(500, this);
            givenMuIsSetTo(0.01, this);
            whenStationaryErgodicTimeBetweenSamplesIsCalled(this);
            thenTbsValuesShouldBePositive(this);
        end
        
        %%% R008 %%%
        function testErrorThrownOnWrongTbsDistribution(this)
            givenNDatapointsIsSetTo(500, this);
            this.verifyError(@()stationaryErgodicTimeBetweenSamples(7, this.nDataPoints, this.mu, this.sigma),'stationaryErgodicTimeBetweenSamples:ConfigurationError');       
        end
    end
    
    methods
       
        function givenMuIsSetTo(mu, this)
           this.mu = mu; 
        end
        
        function givenSigmaIsSetTo(sig, this)
           this.sigma = sig; 
        end
        
        function givenNDatapointsIsSetTo(n, this)
            this.nDataPoints = n;
        end
        
        function givenTbsDistributionIsSetTo(tbsDistro, this)
            this.tbsDistribution = tbsDistro;
        end
        
        function whenStationaryErgodicTimeBetweenSamplesIsCalled(this)
            this.streamDataLabel = stationaryErgodicTimeBetweenSamples(this.tbsDistribution, this.nDataPoints, this.mu, this.sigma);
        end
        
        function thenTbsDistributionShouldBeUniform(this)
            [ratioInner, ratioOuter] = extractInnerOuterRatio(this.sigma / 2, this);
            
            this.verifyEqual(ratioInner, 0.5, 'RelTol', 0.15, "Stream data label is not uniform");
            this.verifyEqual(ratioOuter, 0.5, 'RelTol', 0.15, "Stream data label is not uniform");
        end
        
        function thenTbsDistributionShouldBeGaussian(this)
            [ratioInner, ratioOuter] = extractInnerOuterRatio(this.sigma, this);
            
            this.verifyEqual(ratioInner, 0.642, 'RelTol', 0.15, "Stream data label is not gaussian");
            this.verifyEqual(ratioOuter, 0.358, 'RelTol', 0.15, "Stream data label is not gaussian");
        end
        
        function thenTbsDistributionShouldBeLogistic(this)
            [ratioInner, ratioOuter] = extractInnerOuterRatio(this.sigma, this);
            
            this.verifyEqual(ratioInner, 0.463, 'RelTol', 0.15, "Stream data label is not logistic");
            this.verifyEqual(ratioOuter, 0.536, 'RelTol', 0.15, "Stream data label is not logistic");
        end
        
        function thenTbsDistributionShouldBeTriangular(this)
            [ratioInner, ratioOuter] = extractInnerOuterRatio(this.sigma / 2, this);
            
            this.verifyEqual(ratioInner, 0.75, 'RelTol', 0.15, "Stream data label is not triangular");
            this.verifyEqual(ratioOuter, 0.25, 'RelTol', 0.15, "Stream data label is not triangular");
        end
        
        function thenTbsDistributionShouldBeRing(this)
            [ratioInner, ratioOuter] = extractInnerOuterRatio(this.sigma / 4, this);
            
            this.verifyEqual(ratioInner, 0, 'RelTol', 0.15, "Stream data label is not triangular");
            this.verifyEqual(ratioOuter, 1, 'RelTol', 0.15, "Stream data label is not triangular");
        end
        
        function thenTbsValuesShouldBePositive(this)
           negativeValues = size(this.streamDataLabel(this.streamDataLabel < 0), 1);
           this.verifyEqual(negativeValues, 0, "Stream data label Contains negative values");
        end
        

        function [ratioInner, ratioOuter] = extractInnerOuterRatio(cutoff, this)
            elements = this.streamDataLabel;
            nElements = size(this.streamDataLabel, 1);
            
            elements = elements - this.mu;
            
            innerElements = elements(elements > -cutoff & elements < cutoff);
            outerElements = elements(elements < -cutoff | elements > cutoff);
            
            nInnerElements = size(innerElements, 1);
            nOuterElements = size(outerElements, 1);
            
            ratioInner = nInnerElements / nElements;
            ratioOuter = nOuterElements / nElements;
        end
    end
end


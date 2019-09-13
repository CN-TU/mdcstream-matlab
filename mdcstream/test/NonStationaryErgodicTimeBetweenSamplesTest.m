classdef NonStationaryErgodicTimeBetweenSamplesTest < matlab.unittest.TestCase

        
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
            warning off
            rng(20);
            this.tbsDistribution = [1 2 3 1 6];
            this.nDataPoints = [30, 50, 33, 75, 20];
            this.mu = [1.6, 1.9, 2.6, 1.9, 2.6];
            this.sigma = [0.2, 0.3, 0.2, 0.3, 0.2];
        end
    end
    
    methods (Test)
        %%% R004 %%%
        function testVariousNonStationaryTbsDistributionsForMultipleClusters(this)
            givenTbsDistributionIsSetTo([1, 2, 3, 4, 6], this);
            givenNDatapointsIsSetTo([30000, 20000, 10000, 15000, 20000], this);
            whenNonStationaryErgodicTimeBetweenSamplesIsCalled(this);
            thenTbsDistributionsShouldBe([1, 2, 3, 4, 6], this);
        end
        
        function testNegativeTimeStampsMovedToPositive_Uniform(this)
            givenTbsDistributionIsSetTo(1, this);
            givenNDatapointsIsSetTo(300, this);
            givenMuIsSetTo(0.01, this);
            whenNonStationaryErgodicTimeBetweenSamplesIsCalled(this);
            thenTbsValuesShouldBePositive(this);
        end
        
        function testNegativeTimeStampsMovedToPositive_Ring(this)
            givenTbsDistributionIsSetTo(6, this);
            givenNDatapointsIsSetTo(300, this);
            givenMuIsSetTo(0.01, this);
            whenNonStationaryErgodicTimeBetweenSamplesIsCalled(this);
            thenTbsValuesShouldBePositive(this);
        end
        
        function testErrorThrownOnWrongTbsDistribution(this)
            givenNDatapointsIsSetTo(500, this);
            this.verifyError(@()nonStationaryErgodicTimeBetweenSamples(7, this.nDataPoints, this.mu, this.sigma),'nonStationaryErgodicTimeBetweenSamples:ConfigurationError');       
        end
        
    end
    
    methods
        
        function givenMuIsSetTo(mu, this)
           this.mu = mu; 
        end
       
        function givenNDatapointsIsSetTo(n, this)
            this.nDataPoints = n;
        end
        
        function givenTbsDistributionIsSetTo(tbsDistro, this)
            this.tbsDistribution = tbsDistro;
        end
        
        function whenNonStationaryErgodicTimeBetweenSamplesIsCalled(this)
            this.streamDataLabel = nonStationaryErgodicTimeBetweenSamples(this.tbsDistribution, this.nDataPoints, this.mu, this.sigma);
        end
        
        function thenTbsDistributionsShouldBe(expectedDistros, this)
            nClusters = size(this.nDataPoints, 1);
            for i = 1 : nClusters
                [ratioInner, ratioOuter] = extractInnerOuterRatio(this.sigma(i) / 2, i, this);
                switch expectedDistros(i)
                    
                    case 1
                        this.verifyEqual(ratioInner, 0.5, 'RelTol', 0.15, "Stream data label is not uniform");
                        this.verifyEqual(ratioOuter, 0.5, 'RelTol', 0.15, "Stream data label is not uniform");
                    
                    case 2
                        this.verifyEqual(ratioInner, 0.642, 'RelTol', 0.15, "Stream data label is not gaussian");
                        this.verifyEqual(ratioOuter, 0.358, 'RelTol', 0.15, "Stream data label is not gaussian");
                        
                    case 3
                        this.verifyEqual(ratioInner, 0.463, 'RelTol', 0.15, "Stream data label is not logistic");
                        this.verifyEqual(ratioOuter, 0.536, 'RelTol', 0.15, "Stream data label is not logistic");
                        
                    case 4
                        this.verifyEqual(ratioInner, 0.75, 'RelTol', 0.15, "Stream data label is not triangular");
                        this.verifyEqual(ratioOuter, 0.25, 'RelTol', 0.15, "Stream data label is not triangular");
                        
                    case 6
                        this.verifyEqual(ratioInner, 0, 'RelTol', 0.15, "Stream data label is not ring");
                        this.verifyEqual(ratioOuter, 1, 'RelTol', 0.15, "Stream data label is not ring");
                        
                end
            end
        end
        
                
        function thenTbsValuesShouldBePositive(this)
           tbs = diff([0; this.streamDataLabel]);
           negativeValues = size(tbs(tbs < 0), 1); 
           this.verifyEqual(negativeValues, 0, "Stream data label Contains negative values");
        end
        
        function [ratioInner, ratioOuter] = extractInnerOuterRatio(cutoff, iCluster, this)
            if(iCluster == 1)
                start = 1;
            else
                start = this.nDatapoints(iCluster - 1);
            end
            elements = this.streamDataLabel(start : this.nDataPoints(iCluster));
            elementsToUse = diff(elements(:, 1));
            nElements = size(elementsToUse, 1);
            
            elementsToUse = elementsToUse - this.mu(iCluster);
            
            innerElements = elementsToUse(elementsToUse > -cutoff & elementsToUse < cutoff);
            outerElements = elementsToUse(elementsToUse < -cutoff | elementsToUse > cutoff);
            
            nInnerElements = size(innerElements, 1);
            nOuterElements = size(outerElements, 1);
            
            ratioInner = nInnerElements / nElements;
            ratioOuter = nOuterElements / nElements;
        end
    end
end


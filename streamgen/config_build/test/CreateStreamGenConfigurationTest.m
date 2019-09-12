classdef CreateStreamGenConfigurationTest < matlab.unittest.TestCase

    properties
       config;
       nDataPoints;
       nDimensions;
       nClusters;
       outlierFlag;
    end
    
    methods (TestMethodSetup)
        function setup(this)
            addpath(genpath('../src'));
            warning('off');
            this.nClusters = 1;
            this.outlierFlag = 0;
        end
    end
    
    methods (Test)
      
        function testTbsDistribution(this) 
            p.tbsDistribution = 3;
            whenCreateStreamGenConfigurationIsCalled(p, this);
            this.verifyEqual(this.config.tbsDistribution, 3, "tbsDistribution not initialized correctly");
        end 
        
        function testDefaultTbsDistribution(this) 
            loadDefaultStreamConstants;
            whenCreateStreamGenConfigurationIsCalled([], this);
            this.verifyEqual(this.config.tbsDistribution, DEFAULT_TBS_DISTRIBUTION, "tbsDistribution not initialized correctly");
        end 
        
        function testMu(this) 
            p.mu = 3;
            whenCreateStreamGenConfigurationIsCalled(p, this);
            this.verifyEqual(this.config.mu, 3, "mu not initialized correctly");
        end 
        
        function testDefaultMu(this) 
            loadDefaultStreamConstants;
            whenCreateStreamGenConfigurationIsCalled([], this);
            this.verifyEqual(this.config.mu, DEFAULT_MU, "mu not initialized correctly");
        end 
        
        function testSigma(this)
            p.sigma = 0.4;
            whenCreateStreamGenConfigurationIsCalled(p, this);
            this.verifyEqual(this.config.sigma, 0.4, "sigma not initialized correctly");
        end
        
        function testDefaultSigma(this)
            loadDefaultStreamConstants;
            whenCreateStreamGenConfigurationIsCalled([], this);
            this.verifyEqual(this.config.mu, DEFAULT_MU, "sigma not initialized correctly");
        end

        function testSimultaneous(this)
            p.simultaneous = 0.4;
            whenCreateStreamGenConfigurationIsCalled(p, this);
            this.verifyEqual(this.config.simultaneous, 0.4, "simultaneous not initialized correctly");
        end
        
        function testDefaultSimultaneous(this)
            loadDefaultStreamConstants;
            whenCreateStreamGenConfigurationIsCalled([], this);
            this.verifyEqual(this.config.simultaneous, DEFAULT_SIMULTANEOUS, "simultaneous not initialized correctly");
        end
        
        function testMaxSimultaneous(this)
            p.maxSimultaneous = 12;
            whenCreateStreamGenConfigurationIsCalled(p, this);
            this.verifyEqual(this.config.maxSimultaneous, 12, "maxSimultaneous not initialized correctly");
        end
        
        function testDefaultMaxSimultaneous(this)
            loadDefaultStreamConstants;
            whenCreateStreamGenConfigurationIsCalled([], this);
            this.verifyEqual(this.config.maxSimultaneous, DEFAULT_MAX_SIMULTANEOUS, "maxSimultaneous not initialized correctly");
        end
        
        function testStationary(this)
            p.stationary = 0;
            whenCreateStreamGenConfigurationIsCalled(p, this);
            this.verifyEqual(this.config.stationary, 0, "stationary not initialized correctly");
        end
        
        function testDefaultStationary(this)
            loadDefaultStreamConstants;
            whenCreateStreamGenConfigurationIsCalled([], this);
            this.verifyEqual(this.config.stationary, DEFAULT_STATIONARY, "stationary not initialized correctly");
        end

        function testStartTime(this)
            p.startTime = 33;
            whenCreateStreamGenConfigurationIsCalled(p, this);
            this.verifyEqual(this.config.startTime, 33, "startTime not initialized correctly");
        end
        
        function testDefaultStartTime(this)
            loadDefaultStreamConstants;
            whenCreateStreamGenConfigurationIsCalled([], this);
            this.verifyEqual(this.config.startTime, DEFAULT_START_TIME, "startTime not initialized correctly");
        end
        
        function testStartAfterCluster(this)
            p.startAfterCluster = 3;
            whenCreateStreamGenConfigurationIsCalled(p, this);
            this.verifyEqual(this.config.startAfterCluster, 3, "startAfterCluster not initialized correctly");
        end
        
        function testDefaultStartAfterCluster(this)
            loadDefaultStreamConstants;
            whenCreateStreamGenConfigurationIsCalled([], this);
            this.verifyEqual(this.config.startAfterCluster, DEFAULT_START_AFTER_CLUSTER, "startAfterCluster not initialized correctly");
        end
        
        function testNTimeSamples(this)
            p.nTimeSamples = 3333;
            whenCreateStreamGenConfigurationIsCalled(p, this);
            this.verifyEqual(this.config.nTimeSamples, 3333, "nTimeSamples not initialized correctly");
        end
        
        function testDefaultNTimeSamples(this)
            loadDefaultStreamConstants;
            whenCreateStreamGenConfigurationIsCalled([], this);
            this.verifyEqual(this.config.nTimeSamples, DEFAULT_N_TIME_SAMPLES, "startTime not initialized correctly");
        end
        
        function testRefillClusters(this)
            p.refillClusters = [1 0 1];
            this.nClusters = 3;
            whenCreateStreamGenConfigurationIsCalled(p, this);
            this.verifyEqual(this.config.refillClusters, [1 0 1], "refillClusters not initialized correctly");
        end
        
        function testDefaultRefillClusters(this)
            loadDefaultStreamConstants;
            this.nClusters = 3;
            whenCreateStreamGenConfigurationIsCalled([], this);
            this.verifyEqual(this.config.refillClusters, [1 1 1], "refillClusters not initialized correctly");
        end
        
        function testDisplacement(this)
            p.displacement = 0.5;
            this.nClusters = 3;
            whenCreateStreamGenConfigurationIsCalled(p, this);
            this.verifyEqual(this.config.displacement, [0.5 0.5 0.5], "displacement not initialized correctly");
        end
        
        function testDefaultDisplacement(this)
            loadDefaultStreamConstants;
            this.nClusters = 1;
            whenCreateStreamGenConfigurationIsCalled([], this);
            this.verifyEqual(this.config.displacement, DEFAULT_DISPLACEMENT, "displacement not initialized correctly");
        end

        function testDisplacementRate(this)
            p.displacementRate = 0.5;
            this.nClusters = 3;
            whenCreateStreamGenConfigurationIsCalled(p, this);
            this.verifyEqual(this.config.displacementRate, [0.5 0.5 0.5], "displacementRate not initialized correctly");
        end
        
        function testDefaultDisplacementRate(this)
            loadDefaultStreamConstants;
            this.nClusters = 1;
            whenCreateStreamGenConfigurationIsCalled([], this);
            this.verifyEqual(this.config.displacementRate, DEFAULT_DISPLACEMENT_RATE, "displacementRate not initialized correctly");
        end
        
        function testVectorChangeRate(this)
            p.vectorChangeRate = 0.5;
            this.nClusters = 3;
            whenCreateStreamGenConfigurationIsCalled(p, this);
            this.verifyEqual(this.config.vectorChangeRate, [0.5 0.5 0.5], "vectorChangeRate not initialized correctly");
        end
        
        function testDefaultVectorChangeRate(this)
            loadDefaultStreamConstants;
            this.nClusters = 1;
            whenCreateStreamGenConfigurationIsCalled([], this);
            this.verifyEqual(this.config.vectorChangeRate, DEFAULT_VECTOR_CHANGE_RATE, "VectorChangeRate not initialized correctly");
        end
        
        function testErrorThrownOnWrongTbsDistributionLength(this)
            p.tbsDistribution = [2, 1, 4];
            p.stationary = 1;
            this.verifyError(@()createStreamGenConfiguration(p, 3, this.outlierFlag),'createStreamGenConfiguration:ConfigurationError');       
        end
        
        function testErrorThrownOnWrongMuLength(this)
            p.mu = [2, 1, 4];
            p.stationary = 1;
            this.verifyError(@()createStreamGenConfiguration(p, 3, this.outlierFlag),'createStreamGenConfiguration:ConfigurationError');       
        end
        
        function testErrorThrownOnWrongSigmaLength(this)
            p.sigma = [2, 1, 4];
            p.stationary = 1;
            this.verifyError(@()createStreamGenConfiguration(p, 3, this.outlierFlag),'createStreamGenConfiguration:ConfigurationError');       
        end
        
        function testErrorThrownOnWrongSimultaneous(this)
            p.simultaneous = 1;
            this.verifyError(@()createStreamGenConfiguration(p, 3, this.outlierFlag),'createStreamGenConfiguration:ConfigurationError');       
        end
    end
    
    methods
        
        function whenCreateStreamGenConfigurationIsCalled(params, this)
           this.config = createStreamGenConfiguration(params, this.nClusters, this.outlierFlag); 
        end
    end
end


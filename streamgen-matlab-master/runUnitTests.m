import matlab.unittest.TestSuite


if(~isdeployed)
  cd(fileparts(which('runUnitTests.m')));
end

clear

resultsA = run(TestSuite.fromFolder('streamgen/test'));
resultsB = run(TestSuite.fromFolder('config_build/test'));

disp([resultsA, resultsB]);



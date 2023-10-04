classdef TestMatlabEssentialsKit < matlab.unittest.TestCase

  methods (Test)

  function testBase(testCase)
    testCase.verifyEqual(1,1);
  end

  end
end

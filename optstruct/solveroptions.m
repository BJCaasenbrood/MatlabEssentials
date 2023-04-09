classdef solveroptions
    
    properties
        sol;
        Residual;
        AbsTolerance;
        RelTolerance;
        StepTolerance;
        MaxIteration;
        MaxSubIteration;
        MaxBisection;
        Iteration;
        SubIteration;
        Bisection;
        isConverged;
        Flag;
        Display;
        Time;
        TimeHorizon;
        TimeStep;
        SigmoidFactor;
    end
    
    methods
        function obj = solveroptions
            obj.sol           = struct;
            obj.Residual      = 1e6;
            obj.AbsTolerance  = 1e-3;
            obj.RelTolerance  = 1e-3;
            obj.StepTolerance = 1e-6;
            obj.MaxIteration  = 1e3;
            obj.Display       = false;
            obj.isConverged   = false;
            obj.Iteration     = 1;
            obj.SubIteration  = 1;
            obj.Bisection     = 1;
            obj.Time          = 0;
            obj.TimeHorizon   = 1;
            obj.TimeStep      = 1e-3;
            obj.SigmoidFactor = 0;
        end
    end
end


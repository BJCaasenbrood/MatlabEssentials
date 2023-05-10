classdef solveroptions
    
    properties
        sol;
        Residual;
        AbsTolerance;
        RelTolerance;
        StepTolerance;
        CondTolerance;
        MaxIteration;
        MaxSubIteration;
        MaxBisection;
        Iteration;
        SubIteration;
        Bisection;
        isConverged;
        Flag;
        Display;
        DisplayAtEvery;
        isDisplay;
        isLog;
        Time;
        TimeHorizon;
        TimeStep;
        SigmoidFactor;
        Regularization;
    end
    
    methods
        function obj = solveroptions
            obj.sol            = struct;
            obj.Residual       = 1e6;
            obj.AbsTolerance   = 1e-3;
            obj.RelTolerance   = 1e-3;
            obj.StepTolerance  = 1e-6;
            obj.CondTolerance  = 1e4;
            obj.MaxIteration   = 1e3;
            obj.Display        = true;
            obj.DisplayAtEvery = 10;
            obj.isDisplay      = true;
            obj.isLog          = true;
            obj.isConverged    = false;
            obj.Iteration      = 1;
            obj.SubIteration   = 1;
            obj.Bisection      = 1;
            obj.MaxBisection   = 15;
            obj.Time           = 0;
            obj.TimeHorizon    = 1;
            obj.TimeStep       = 1e-3;
            obj.SigmoidFactor  = 0;
            obj.Regularization = 1;
        end
    end
end

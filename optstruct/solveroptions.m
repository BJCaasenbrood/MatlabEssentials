classdef solveroptions
    
    properties
        Residual;
        AbsTolerance;
        RelTolerance;
        StepTolerance;
        MaxIteration;
        Iteration;
        isConverged;
        Flag;
        Display;
    end
    
    methods
        function obj = solveroptions
            obj.Residual      = 1e6;
            obj.AbsTolerance  = 1e-3;
            obj.RelTolerance  = 1e-3;
            obj.StepTolerance = 1e-6;
            obj.MaxIteration  = 1e3;
            obj.Display       = false;
            obj.isConverged   = false;
            obj.Iteration     = 1;
        end
    end
end


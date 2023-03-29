%JUMPSET Evaluate a set of jump conditions and return the corresponding state.
%
% Y = JUMPSET(T, STATE, CONDITION) evaluates the set of jump conditions
% specified by the cell array CONDITION at time T and returns the
% corresponding state from the cell array STATE. CONDITION must be a cell
% array of function handles that accept a scalar time argument and return a
% logical value indicating whether the corresponding jump condition is
% satisfied. STATE must be a cell array of matrices, where each matrix
% corresponds to a state that can be jumped to if the corresponding jump
% condition is satisfied. The output Y is a matrix with the same size as
% the matrices in STATE.
%
% If more than one jump condition is satisfied at time T, JUMPSET returns
% the state corresponding to the first jump condition that is satisfied.
%
% If no jump conditions are satisfied, JUMPSET returns a matrix of zeros
% with the same size as the matrices in STATE.
%
% If an error occurs while evaluating the jump conditions, JUMPSET displays
% an error message and returns an empty array.
%
% Example:
%   T = 0;
%   STATE = {zeros(2), eye(2)};
%   CONDITION = {@(t) (t > 1), @(t) (t <= 1)};
%   Y = jumpset(T, STATE, CONDITION) returns eye(2).
%
% See also ODE45, EVENTS.

function y = jumpset(t,state,condition)
% Check input size and data type
Nc = numel(condition);
Nx = numel(state);
if Nc ~= Nx
    error('Jump set must be equal to state set, both in cell format');
elseif ~isa(condition,'cell') || ~isa(state,'cell')
    error('Jump set and state set must be cell format');
elseif ~isa(condition{1},'function_handle')
    error('Jump conditions must be function_handles');
end

% Check input values and handle errors gracefully
try
    jump = ~~zeros(Nx,1);
    for ii = 1:Nc
        fnc = condition{ii};
        jump(ii) = fnc(t);
    end

    if numel(jump) == 0
        y = state{1} * 0;
    else
        y = state{jump};
    end
    
catch ME
    % Display error message
    fprintf('An error occurred while running jumpset: %s\n', ME.message);
    y = [];
end

end

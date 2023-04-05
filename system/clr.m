%CLR Clear the command window, workspace, and figures, and turn off beep.
%
% CLR() clears the command window, workspace, and all open figures.
% It also turns off the beep sound that MATLAB produces when certain
% errors occur.
%
% Examples:
%   clr clears the command window, workspace, and all open figures.
%
% See also CLC, CLEAR, CLOSE ALL.

function clr
    clc;
    clear;
    close all;
    beep off;
end

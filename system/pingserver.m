%PINGSERVER Check if the computer can connect to the internet.
%
% X = PINGSERVER() sends a single ping packet to www.google.com and returns
% a logical value indicating whether the packet was successfully received
% (true) or not (false). This function can be used to check if the computer
% is currently connected to the internet.
%
% Note that PINGSERVER only works on Windows, Mac, and Linux platforms.
%
% Examples:
%   pingserver() returns true if the computer is currently connected to the
%   internet.
%
% See also SYSTEM.

function x = pingserver

if ismac
    % Code to run on Mac platform
elseif isunix
    % Code to run on Linux platform
    [~,b] = system('ping -c 1 www.google.com');
    n=strfind(b,'loss');
    n1=b(n-10);
elseif ispc
    [~,b] = system('ping -n 1 www.google.com');
    n=strfind(b,'Lost');
    n1=b(n+7);
else
    disp('Platform not supported')
end

if(n1=='0'), x=true; else, x=false; end

end

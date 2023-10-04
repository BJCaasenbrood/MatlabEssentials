function upd = progress(Log, n, varargin)


        % Default Parameter values:
        windowSize = get(0, 'CommandWindowSize');
        defaultbarCharLen = round(windowSize(1) * 0.25);
        defaultUpdStep        = 5;
        defaultstartMsg       = ' ';
        defaultendMsg         = ' ';
        defaultShowremTime    = true;
        defaultShowBar        = true;
        defaultshowPercentage = true;
        defaultshowActualNum  = false;
        defaultshowFinalTime  = true;
        defaultbarCharSymbol  = '━';
        defaultEmptybarCharSymbol = '─';
        
        % Auxiliary functions for checking parameter values:
        ischarsymbol = @(c) (ischar(c) && length(c) == 1);
        ispositiveint = @(x) (isnumeric(x) && mod(x, 1) == 0 && x > 0);
     
        % Register input parameters:
        p = inputParser;
        addRequired(p,'n', ispositiveint);
        addParameter(p, 'barlength', defaultbarCharLen, ispositiveint)
        addParameter(p, 'updatestep', defaultUpdStep, ispositiveint)
        addParameter(p, 'startmsg', defaultstartMsg, @ischar)
        addParameter(p, 'endmsg', defaultendMsg, @ischar)
        addParameter(p, 'showremtime', defaultShowremTime, @islogical)
        addParameter(p, 'showbar', defaultShowBar, @islogical)
        addParameter(p, 'showpercentage', defaultshowPercentage, @islogical)
        addParameter(p, 'showactualnum', defaultshowActualNum, @islogical)
        addParameter(p, 'showfinaltime', defaultshowFinalTime, @islogical)
        addParameter(p, 'barsymbol', defaultbarCharSymbol, ischarsymbol)
        addParameter(p, 'emptybarsymbol', defaultEmptybarCharSymbol, ischarsymbol)
        
        % Parse input arguments:
        parse(p, n, varargin{:});
        n = p.Results.n;
        barCharLen = p.Results.barlength;
        updStep = p.Results.updatestep;
        startMsg = p.Results.startmsg;
        endMsg = p.Results.endmsg;
        showremTime = p.Results.showremtime;
        showBar = p.Results.showbar;
        showPercentage = p.Results.showpercentage;
        showActualNum = p.Results.showactualnum;
        showFinalTime = p.Results.showfinaltime;
        barCharSymbol = p.Results.barsymbol;
        emptybarCharSymbol = p.Results.emptybarsymbol;
        
        % Initialize progress bar:
        bar = [' ', repmat(emptybarCharSymbol, 1, barCharLen), ' '];
        
        nextRenderPoint = 0;
        startTime = tic;
        
        % Initalize block for actual number of completed items:
        ind = 1;
        
        % Start message block:
        startMsgLen = length(startMsg);
        startMsgStart = ind;
        startMsgEnd = startMsgStart + startMsgLen - 1;
        ind = ind + startMsgLen;
        
        % Bar block:
        barLen = length(bar);
        barStart = 0;
        barEnd = 0;
        if showBar
            barStart = ind;
            barEnd = barStart + barLen - 1;
            ind = ind + barLen;
        end
        
        % Actual Num block:
        actualNumDigitLen = numel(num2str(n));
        actualNumFormat = sprintf(' %%%dd/%d', actualNumDigitLen, n);
        actualNumStr = sprintf(actualNumFormat, 0);
        actualNumLen = length(actualNumStr);
        actualNumStart = 0;
        actualNumEnd = 0;
        if showActualNum
            actualNumStart = ind;
            actualNumEnd = actualNumStart + actualNumLen-1;
            ind = ind + actualNumLen;
        end
            
        % Percentage block:
        percentageFormat = sprintf(' %%3d%%%%');
        percentageStr = sprintf(percentageFormat, 0);
        percentageLen = length(percentageStr);
        percentageStart = 0;
        percentageEnd = 0;
        if showPercentage
            percentageStart = ind;
            percentageEnd = percentageStart + percentageLen-1;
            ind = ind + percentageLen;
        end
        
        % Remaining Time block:
        remTimeStr = time2str(Inf);
        remTimeLen = length(remTimeStr);
        remTimeStart = 0;
        remTimeEnd = 0;
        if showremTime
           remTimeStart = ind;
           remTimeEnd = remTimeStart + remTimeLen - 1;
           ind = ind + remTimeLen;
        end
        
        % End msg block:
        endMsgLen = length(endMsg);
        if showBar
            endMsgStart = barEnd + 1; % Place end message right after bar;
        else
            endMsgStart = startMsgEnd + 1;
        end
        endMsgEnd = endMsgStart + endMsgLen - 1;
        
        ind = max([ind, endMsgEnd]);
        
        % Determine size of buffer:
        arrayLen = ind - 1;
        array = repmat(' ', 1, arrayLen);
        
        % Initial render:
        array(startMsgStart:startMsgEnd) = sprintf('%s', startMsg);
    
        delAll = repmat('\b', 1, arrayLen);
        
            % Function to update the status of the progress bar:
            function update(i)
                
                if i < nextRenderPoint
                    return;
                end
                if i > 0
                    fprintf(delAll);
                end

                nextRenderPoint = min([nextRenderPoint + updStep, n]);
                
                if showremTime
                    % Delete remaining time block:
                    array(remTimeStart:remTimeEnd) = ' ';
                end
    
                if showPercentage
                    % Delete percentage block:
                    array(percentageStart:percentageEnd) = ' ';
                end
                
                if showActualNum
                    % Delete actual num block:
                    array(actualNumStart:actualNumEnd) = ' ';
                end
        
                if showBar
                    % Update progress bar (only if needed):
                    barsToPrint = floor( i / n * barCharLen );
                    bar(2:1+barsToPrint) = barCharSymbol;
                    array(barStart:barEnd) = bar;
                end
                
                % Check if done:
                if i >= n
                    array(endMsgStart:endMsgEnd) = endMsg;
                    array(endMsgEnd+1:end) = ' ';
                    
                    if showFinalTime
                        finalTimeStr = time2str(toc(startTime));
                        finalTimeLen = length(finalTimeStr);
                        if endMsgEnd + finalTimeLen < arrayLen
                           array(endMsgEnd+1:endMsgEnd+finalTimeLen) = ... 
                               finalTimeStr;
                        else
                           array = [array(1:endMsgEnd), finalTimeStr];
                        end
                    end
                    
                    sStart = 1;
                    sEnd = startMsgEnd;
                    tcprintf('default','%s',array(sStart:sEnd));
                    sStart = sEnd + 1;
                    sEnd = sEnd + barsToPrint + 3;
                    tcprintf('green','%s',array(sStart:sEnd-3));
                    
                    if ~usejava('desktop')
                        tcprintf('green','%s',"  100%%");
                        str = strrep(array(sEnd+1:end),'%','%%');
                    else 
                        tcprintf('green','%s',"  100%");
                        str = strrep(array(sEnd+1:end),'%','%');
                    end

                    tcprintf('default','%s',str);
                    fprintf('\n');
                    return;
                end
                
                if showActualNum
                    % Delete actual num block:
                    actualNumStr = sprintf(actualNumFormat, i);
                    array(actualNumStart:actualNumEnd) = actualNumStr;
                end
                
                if showPercentage
                    % Render percentage block:
                    percentage = floor(i / n * 100);
                    percentageStr = sprintf(percentageFormat, percentage);
                    array(percentageStart:percentageEnd) = percentageStr;
                end
                    
                % Print remaining time block:
                if showremTime
                   t = toc(startTime);
                   remTime = t/ i * (n-i);
                   remTimeStr = time2str(remTime);
                   array(remTimeStart:remTimeEnd) = remTimeStr;
                end

                sStart = 1;
                sEnd = startMsgEnd;
                tcprintf('default','%s',array(sStart:sEnd));
                sStart = sEnd + 1;
                sEnd = sEnd + barsToPrint + 3;
                tcprintf('red','%s',array(sStart:sEnd-2));
                str = strrep(array(sEnd:end),'%','%%');
                tcprintf('default','%s',str);
            end
        
        % Do the first render:
        update(0);
        upd = @update;
        
    end
    
%% Time to string
function timestr = time2str(t)    
    if t == Inf
        timestr = sprintf(' --:--:--');
    else
        [hh, mm, tt] = sec2hhmmss(t);
        timestr = sprintf(' %02d:%02d:%02d', hh, mm, tt);
        if tt < 1 
            [~, ms, us] = sec2ssmsus(t);
            timestr = sprintf(' .%03d:%03d', ms, us);
        end
    end
end
    
%% hour-minutes-seconds
function [hh, mm, ss] = sec2hhmmss(t)
    hh = floor(t / 3600);
    t = t - hh * 3600;
    mm = floor(t / 60);
    ss = round(t - mm * 60);
end
    
%% seconds-milliseconds-microseconds
function [ss, ms, us] = sec2ssmsus(t)
    ss = fix(t); % Extract the full seconds
    remaining_time = t - ss; 
    ms = fix(remaining_time * 1000); %
    remaining_time = remaining_time - (ms / 1000); 
    us = fix(remaining_time * 1e6); 
end
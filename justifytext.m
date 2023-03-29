function justifiedString = justifytext(inputString, lineWidth, alignment)
    function words = splitBySpace(str)
        splitIdx = strfind(str, ' ');
        words = cell(1, numel(splitIdx) + 1);
        prevIdx = 1;
        for i = 1:numel(splitIdx)
            words{i} = str(prevIdx:splitIdx(i)-1);
            prevIdx = splitIdx(i) + 1;
        end
        words{end} = str(prevIdx:end);
    end
    
    words = splitBySpace(inputString);
    lines = {};
    currentLine = words{1};
    
    for i = 2:numel(words)
        word = words{i};
        tempLine = [currentLine, ' ', word];
        
        if length(tempLine) <= lineWidth
            currentLine = tempLine;
        else
            lines{end+1} = currentLine;
            currentLine = word;
        end
    end
    lines{end+1} = currentLine;
    
    justifiedStrings = cell(size(lines));
    
    for i = 1:numel(lines)
        str = lines{i};
        strLength = length(str);
        
        if lineWidth > strLength
            padding = lineWidth - strLength;

            switch lower(alignment)
                case 'left'
                    str = [str, repmat(' ', 1, padding)];
                case 'right'
                    str = [repmat(' ', 1, padding), str];
                case 'center'
                    leftPadding = floor(padding / 2);
                    rightPadding = padding - leftPadding;
                    str = [repmat(' ', 1, leftPadding), str, repmat(' ', 1, rightPadding)];
                otherwise
                    error('Invalid alignment option. Choose "left", "right", or "center".');
            end
        elseif lineWidth < strLength
            str = str(1:lineWidth);
        end

        justifiedStrings{i} = str;
    end
    
    justifiedString = strjoin(justifiedStrings, '\n');
end

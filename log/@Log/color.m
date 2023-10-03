function color(Log,color)
    printcolor(color);
    fprintf(' \033[0m \n');
end

function printcolor(color)

    if size(color,1) > 1
        for ii = 1:size(color,1)
            printcolor(color(ii,:));
        end

        return;
    end

    % color set to range [0, 255]
    if color(1) <= 1 && color(2) <= 1 && color(3) <= 1
        color = fix(color * 255);
    end

    % extract RGB
    r = color(1);
    g = color(2);
    b = color(3);

    % ANSI escape code for setting the text color
    colorCode = sprintf('\033[38;2;%d;%d;%dm█\033[0m', r, g, b);
    % Print the colored text
    fprintf('%s', colorCode);
end
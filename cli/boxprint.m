function boxprint(line, varargin)

    headers = {''};
    title   = '─';
    data    = {line};
    range   = [1, size(data, 1)];
    addRowOnly       = false;
    keepLastLineFree = false;
    cmdWidth = get(0,'CommandWindowSize');
    max_widths = cmdWidth(1) - 4;

    for ii = 1:numel(varargin)/2
        if strcmpi(varargin{2*ii-1},'range')
            range = varargin{2*ii};
            range = [size(data, 1) - range, size(data, 1)];
        elseif strcmpi(varargin{2*ii-1},'start')
            addRowOnly = ~varargin{2*ii};
        elseif strcmpi(varargin{2*ii-1},'end')
            keepLastLineFree = ~varargin{2*ii};
        elseif strcmpi(varargin{2*ii-1},'title')
            title = varargin{2*ii};            
        elseif strcmpi(varargin{2*ii-1},'width')
            max_widths = varargin{2*ii};
        end
    end

    % Combine headers and data into a cell array
    numeHeaders = 1;%length(headers);
    numeDataRows = range(2) - range(1) + 1;
    tableData = [headers; cell(numeDataRows, numeHeaders)];

    % Fill in the tableData with data values within the specified range
    for row = range(1):range(2)

        for col = 1:numeHeaders

            if isa(data, 'cell')

                if ~isa(data{row, col}, 'char')
                    tableData{row - range(1) + 2, col} = ...
                        num2str(data{row, col});
                else
                    tableData{row - range(1) + 2, col} = ...
                        (data{row, col});
                end

            else

                if isflint(data(row, col))
                    num = num2str(data(row, col),'%d');
                else
                    num = num2str(data(row, col),'%.2e');
                end
                tableData{row - range(1) + 2, col} = num;
            end

        end

    end

    % Get the dimensions of the tableData
    [num_rows, num_columns] = size(tableData);

    % Print the top border
    if ~addRowOnly

        fprintf('╭');
        if ~strcmp(title,'─');
            topCorrection = -1 - numel(title);
            fprintf(['─ ',title,' ─']);
        else
            %fprintf('╭');
            topCorrection = 3;
            %fprintf(['']);
        end
        fprintf('%s', repmat('─', 1, max_widths(col) + topCorrection));
        fprintf('\b╮\n');

    else
        for col = 1:num_columns
            fprintf(repmat('\b', 1, max_widths(col) + 3));
        end
        fprintf('\b');
    end

    % Print the table data
    for row = 2:num_rows

        % if row == 1 && ~addRowOnly

        %     for col = 1:num_columns
        %         fprintf('│ %-*s ', max_widths(col), tableData{row, col});
        %     end

        %     fprintf('│\n');
        % elseif row ~= 1

            for col = 1:num_columns
                fprintf('│ %-*s ', max_widths(col), tableData{row, col});
            end

            fprintf('│\n');
        % end

        % Print the row separator except for the last row
        if row == 1 && ~addRowOnly
            fprintf('├');

            for col = 1:num_columns
                fprintf('%s┼', repmat('─', 1, max_widths(col) + 2));
            end

            fprintf('\b┤\n');
        end

    end

    % Print the bottom border
    fprintf('╰');

    for col = 1:num_columns
        fprintf('%s┴', repmat('─', 1, max_widths(col) + 2));
    end

    fprintf('\b╯');

    if ~keepLastLineFree
        fprintf('\n');
    end
end

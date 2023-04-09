function fprinttable(headers, data, varargin)

    range = [1, size(data, 1)];
    addRowOnly = false;
    keepLastLineFree = false;

    for ii = 1:numel(varargin)/2
        if strcmpi(varargin{2*ii-1},'range')
            range = varargin{2*ii};
            range = [size(data, 1) - range, size(data, 1)];
        elseif strcmpi(varargin{2*ii-1},'addrow')
            addRowOnly = ~addRowOnly;
        elseif strcmpi(varargin{2*ii-1},'open');
            keepLastLineFree = ~keepLastLineFree;
        end
    end

    % if nargin < 4
    %     range = [1, size(data, 1)];
    % else
    %     range = varargin{1};

    %     if numel(varargin{1}) == 1
    %         range = [size(data, 1) - range, size(data, 1)];
    %     end

    % end

    % Combine headers and data into a cell array
    numeHeaders = length(headers);
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
                tableData{row - range(1) + 2, col} = ...
                    num2str(data(row, col));
            end

        end

    end

    % Get the dimensions of the tableData
    [num_rows, num_columns] = size(tableData);

    % Calculate the maximum width for each column
    max_widths = zeros(1, num_columns);

    for col = 1:num_columns

        for row = 1:num_rows
            max_widths(col) = max(max_widths(col), ...
                numel(tableData{row, col}));
        end

    end

    % Print the top border
    if ~addRowOnly

        fprintf('┏');

        for col = 1:num_columns
            fprintf('%s┳', repmat('━', 1, max_widths(col) + 2));
        end

        fprintf('\b┓\n');

    else
        for col = 1:num_columns
            fprintf(repmat('\b', 1, max_widths(col) + 4));
        end
        % fprintf('├');

        % for col = 1:num_columns
        %     fprintf('%s┼', repmat('─', 1, max_widths(col) + 2));
        % end

        % fprintf('\b┤\n');
    end

    % Print the table data
    for row = 1:num_rows

        if row == 1 && ~addRowOnly

            for col = 1:num_columns
                fprintf('┃ %-*s ', max_widths(col), tableData{row, col});
            end

            fprintf('┃\n');
        elseif row ~= 1

            for col = 1:num_columns
                fprintf('│ %-*s ', max_widths(col), tableData{row, col});
            end

            fprintf('│\n');
        end

        % Print the row separator except for the last row
        if row == 1 && ~addRowOnly
            fprintf('┡');

            for col = 1:num_columns
                fprintf('%s╇', repmat('━', 1, max_widths(col) + 2));
            end

            fprintf('\b┩\n');
        end

    end

    % Print the bottom border
    fprintf('└');

    for col = 1:num_columns
        fprintf('%s┴', repmat('─', 1, max_widths(col) + 2));
    end

    fprintf('\b┘');

    if ~keepLastLineFree
        fprintf('\n');
    end
end

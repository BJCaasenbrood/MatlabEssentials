function randomChars = randchar(n, excluded)
    % Check if n is positive
    if n <= 0
        error('n must be a positive integer');
    end

    excludedChars = [',','.',';','`',':',' ',"'",'_','-','\','+','-'];

    % Define the range of ASCII values for characters (you can modify this as needed)
    minAsciiValue = 32; % Minimum ASCII value for a printable character
    maxAsciiValue = 94; % Maximum ASCII value for a printable character

    % Initialize an empty array to store random characters
    randomChars = [];

    % Generate random characters until we have n characters
    while length(randomChars) < n
        % Generate a random ASCII value within the specified range
        randomAsciiValue = randi([minAsciiValue, maxAsciiValue]);

        % Convert the ASCII value to a character
        randomChar = char(randomAsciiValue);

        % Check if the generated character is not in the excludedChars list
        if ~ismember(randomChar, excludedChars)
            % Append the character to the randomChars array
            randomChars = [randomChars, randomChar];
        end
    end

    % Trim the result to exactly n characters
    randomChars = randomChars(1:n);
end

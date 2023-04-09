clr;

for ii = 1:6
    if ii == 1
        fprinttable([{'iteration', 'residual'}], [ii, ii * 3],'open',true);
    else
        fprinttable([{'iteration', 'residual'}], [ii, ii * 3], 'addrow',true,'open',true);
    end
end

% for ii = 1:3
%     T = evalc("fprinttable([{'iteration','residual'}], [ii, ii*3])");
%     teleprompt(T);
%     % fprintf('%s',T);
%     % pause(1);
%     % fprintf(repmat('\r',1,2*numel(T)));
% end
% N = 100;
% reverseStr = '';
% for i = 1:N
%     ...
%     ...
%     msg = sprintf('Processed %d/%d', i, N);
%     fprintf([reverseStr, msg]);
%     reverseStr = repmat(sprintf('\b'), 1, length(msg));
%     pause(0.1);
% end

% ctrl=0;
% while ctrl<5
%     fprintf('\rctrl: %i',ctrl);
%     ctrl=ctrl+1;
%     pause(2); % To highlight overwrite 
% end
% fprintf('\n'); % Don't forget the newline




% msg=fprintf("Anything I want to write\n");
% pause
% fprintf(repmat('\b', 1, (msg+39))); % covers the length of the message + length of the backspace command.
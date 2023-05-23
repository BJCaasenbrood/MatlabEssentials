function y = waveform(t, trajectory)

y = zeros(size(t));

for k = 1:numel(t)
    T = [trajectory(:,1); Inf];
    state = trajectory(:,2);
    condition = ~~zeros(1,numel(state));
    
    for ii = 1:numel(state)
        condition(ii) = (t(k) < T(ii+1)) && (t(k) >= T(ii));
    end
    
    if sum(condition) == 0
        condition(1) = 1;
    elseif sum(condition) > 1
        error('Identical time frames provided');
    end
    
    y(k) = state(condition);
end

end
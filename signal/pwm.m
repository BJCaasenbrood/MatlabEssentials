function y = pwm(t,varargin)
%PWM y = pwm(t,duty)
if isempty(varargin)
    duty = 0.5;
else
    duty = clamp(varargin{1},0,1);
end
z = -sawtooth(0.9999 * t) + (1-duty);
y = clamp(-sign(z),0,1);
end


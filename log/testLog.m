clr;
windowSize = get(0, 'CommandWindowSize');
W = round(windowSize(1) * 0.33);

log = Log();
log.options.isDebug = true;

log.info('I am an info message 😊');

% test error function
log.err('Oh no, an error!');

% test warn function
log.warn('Okay, it was just a warning');

% test warn function
log.debug('There is a bug somewhere...');
myfun;

log.list('Here is a list:',{'1','2','3'})

log.hline();

n = 150;
for k = 1:5
upd = log.progress(n,'startmsg',['Test ',num2str(k),':']);
for i = 1:n
    upd(i)
    pause(0.002 * k * rand);
end
end

log.hline();

for k = 1:5
    b = rand <= 0.5;
    log.bool(['Check ',num2str(k)], b, {'Passed','Failed'});
    pause(0.01 * k * rand);
end

log.hline();

% log.info('Colormaps:')
fprintf('cmap_turbo: \t'), log.color(cmap_turbo(W));
fprintf('cmap_viridis: \t'), log.color(cmap_viridis(W));
fprintf('cmap_inferno: \t'), log.color(cmap_inferno(W));
fprintf('cmap_barney: \t'), log.color(cmap_barney(W));
fprintf('cmap_noir: \t'), log.color(cmap_noir(W));
fprintf('cmap_rainbow: \t'), log.color(cmap_rainbow(W));

log.hline();
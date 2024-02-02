function opt = logoptions
    
    opt = NamedTuple([]);
    opt.Name = 'logoptions';

    opt.add('Tag',NamedTuple('Tag'));
    opt.Tag.add('Info',' \b');
    opt.Tag.add('Warn','Warning');
    opt.Tag.add('Debug','Debug');
    opt.Tag.add('Error','Error');

    % colors for plotting
    opt.add('Color',NamedTuple('Color'));

    opt.Color.add('Info','blue');
    opt.Color.add('Warn','yellow');
    opt.Color.add('Debug','cyan');
    opt.Color.add('Error','black onRed');
    opt.Color.add('True','green');
    opt.Color.add('False','red');

    % colors for plotting
    opt.Color.add('TextInfo','default');
    opt.Color.add('TextHide','default');

    % setting symbols
    opt.add('Symbol',NamedTuple('Symbol'));
    opt.Symbol.add('BulletStart','├╴');  % ├╴
    opt.Symbol.add('BulletMid','├╴');    % ├╴
    opt.Symbol.add('BulletEnd','╰╴');    % ╰╴

    opt.add('isHide',false);
    opt.add('isDebug',false);
end

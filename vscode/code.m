% CODE Opens VSCode editor to a specific file and line number.
%
%   CODE FILE opens Visual Studio Code to the specified FILE.
%
%   CODE FILE LINE opens Visual Studio Code to the specified FILE at LINE
%   number specified by the user (default = 0).
%
%   Example:
%       code myFile will open 'myFile.m' in Visual Studio Code and
%       place the cursor at line number 10.
%
%   Note:
%       This function requires that the 'code' command is available in the
%       system path. If you are using a different editor or IDE, you may need
%       to modify this function to use the appropriate command.
%
% See also WHEREIS.

function code(name, line)

    % specify your editors symbolic path here
    editorpath = 'code';
    assert(nargin>0, 'CODE requires atleast a file name');

    if nargin < 2
        addline = '';
    else
        addline = [':', num2str(line),':00'];
    end
    
    [fExists, filepath] = openPath(name);
    command = [editorpath,' --goto "', filepath, addline,'"'];

    if fExists
       [status, cmdout] = system(command);
    end
end

%--------------------------------------------------------------------------
function [fExists, pathName] = openPath(argName)

    executionContext = evalin('caller', 'matlab.internal.language.introspective.ExecutionContext.create');

    [fExists, pathName, selectionKey] = resolvePath(argName, executionContext);
    
    % if fExists
    %     openEditor(pathName, selectionKey);
    % end
end

%--------------------------------------------------------------------------
function [result, absPathname, selectionKey] = resolvePath(argName, executionContext)

    [~, relativePath] = matlab.internal.language.introspective.separateImplicitDirs(pwd);
    
    selectionKey = '';
    [argName, hasLocalFunction, result, ~, absPathname] = matlab.internal.language.introspective.fixLocalFunctionCase(argName, relativePath);    
    
    if hasLocalFunction
        if result && absPathname(end) == 'p'
            % see if a corresponding M file exists
            absPathname(end) = 'm';
            if ~exist(absPathname, 'file')
                % Do not error, instead behave as if no file was found
                result = 0;  
            end        
        end
        if result
            selectionKey = regexp(argName, ['(?<=' filemarker ')\w*$'], 'match', 'once');
        else
            absPathname = argName;
        end
    else
        classResolver = matlab.internal.language.introspective.NameResolver(argName, relativePath, false, executionContext);
        classResolver.findBuiltins = false;
        classResolver.executeResolve();
        resolvedSymbol = classResolver.resolvedSymbol;
    
        classInfo  = resolvedSymbol.classInfo;
        whichTopic = resolvedSymbol.nameLocation;
    
        if resolvedSymbol.foundVar && isempty(classInfo)
            absPathname = argName;
            return;
        end
        
        if isempty(whichTopic)
            [result, absPathname] = resolveWithFileSystemAndExts(argName);
        else
            % whichTopic is the full path to the resolved output either by class 
            % inference or by which
    
            result = 1;
    
            switch exist(whichTopic, 'file')
            case 0 % Name resolver found something which is not a file
                assert(~isempty(classInfo));
                whichTopic = classInfo.definition;
            case 3 % MEX File 
                % Do not error, instead behave as if no file was found
                absPathname = argName;
                result = 0;
                return;
            case {4,6} % P File or Simulink Model
                if ~extensionMatches(whichTopic, argName)
                    % see if a corresponding M file exists
                    mTopic = regexprep(whichTopic, '\.\w+$', '.m');
                    if exist(mTopic, 'file')
                        whichTopic = mTopic;
                    elseif ~isempty(regexp(whichTopic, '\.mdl$', 'once'))
                        error(message('MATLAB:Editor:MdlErr', argName));
                    elseif resolvedSymbol.isUnderqualified
                        % Do not error, instead behave as if no file was found
                        absPathname = argName;
                        result = 0;
                        return;
                    end
                end            
            case 7 % Directory
                if classInfo.isPackage
                    error(message('MATLAB:Editor:PkgErr', classInfo.fullTopic));
                end
                % Class Folder: switch prompt to create the classdef
                absPathname = fullfile(whichTopic, classInfo.className);
                result = 0;
                return;
            end
    
            if isAbsolutePath(whichTopic)
                absPathname = whichTopic;
            else
                absPathname = which(whichTopic);
            end
    
            if ~isempty(classInfo)
                isLocalMethod = classInfo.isMethod && any(classInfo.definition==filemarker);
                if isLocalMethod && ~classInfo.isAbstract
                    selectionKey = classInfo.element;
                elseif resolvedSymbol.isUnderqualified && classInfo.isSimpleElement 
                    % Do not open underqualified properties, instead behave as if no file was found
                    absPathname = argName;
                    result = 0;
                elseif classInfo.isSimpleElement || isLocalMethod
                    selectionKey = [classInfo.getElementOffset, strlength(classInfo.element)];
                end
            end
        end
    end
end

%--------------------------------------------------------------------------
function result = isAbsolutePath(filePath)
% Helper method to determine if the given path to an existing file is
% absolute.
% NOTE: the given filePath is assumed to exist.

result = false;
directoryPart = fileparts(filePath);

if isunix && strncmp(directoryPart, '/', 1)
    result = true;
elseif ispc && ... % Match C:\, C:/, \\, and // as absolute paths
        (~isempty(regexp(directoryPart, '^([\w]:[\\/]|\\\\|//)', 'once')))
    result = true;
end

end

%--------------------------------------------------------------------------
% Helper method that checks the filesystem for files by adding m or mlx
function [result, absPathname] = resolveWithFileSystemAndExts(argName)

    result = 0;
    
    if ~hasExtension(argName)
        argMlx = [argName '.mlx'];
        [result, absPathname] = resolveWithDir(argMlx, false);
    
        if ~result
            argM = [argName '.m'];
            [result, absPathname] = resolveWithDir(argM, false);
        end
    end
    
    if ~result
        absPathname = argName;
    end
end

%--------------------------------------------------------------------------
% Helper method that determines if filename specified has an extension.
% Returns true if filename does have an extension, false otherwise
function result = hasExtension(s)

    [~,~,ext] = fileparts(s);
    result = ~isempty(ext);
end    
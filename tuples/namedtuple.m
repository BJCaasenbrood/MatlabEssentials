% NAMEDTUPLE  A class that creates a named tuple object.
%
%   A named tuple is an object that stores a set of named properties that
%   can be accessed using dot notation, similar to a struct. It is useful
%   for storing a fixed set of properties that need to be accessed by name,
%   but where the number of properties may vary between different instances.
%
%   obj = namedtuple(name, propNames, propValues) creates a new named tuple
%   object with the specified name, property names, and values.
%   'name' is a string specifying the name of the object, 'propNames' is a
%   cell array of strings specifying the names of the properties, and
%   'propValues' is a cell array of values to initialize the properties.
%   If a property value is not specified, it defaults to [].
%
%   obj = namedtuple(otherObj) creates a new named tuple object that is a
%   copy of the specified 'otherObj'. The new object has the same property
%   names and values as the original object, but with a different name.
%
%   obj.propertyName provides access to the property with the specified
%   name. For example, if 'obj' is a named tuple object with a property
%   named 'foo', then 'obj.foo' returns the value of the 'foo' property.
%
%   Example usage:
%
%   % create a named tuple with two properties
%   obj = namedtuple('myTuple', {'foo', 'bar'}, 42, 'hello');
%   % access the properties
%   assert(obj.foo == 42);
%   assert(strcmp(obj.bar, 'hello'));
%
%   % create a new tuple that is a copy of the first one
%   obj2 = namedtuple(obj);
%   assert(obj2.foo == obj.foo);
%   assert(strcmp(obj2.bar, obj.bar));
%
%   % modify a property of the original tuple
%   obj.foo = 123;
%   assert(obj.foo == 123);
%
%   % add a new property to the original tuple
%   obj.bar = 'world';
%   assert(strcmp(obj.bar, 'world'));
%
%   % create a new tuple from itsself
%   Prop = namedtuple('Prop',{'a','b'});
%   obj = Prop.self(1,2);
%   assert(strcmp(obj.a, 1));
%   assert(strcmp(obj.b, 2));
%
%   See also STRUCT.


classdef namedtuple < dynamicprops
    properties
        Name
    end
    
    methods
        function obj = namedtuple(varargin)
            if nargin > 0 && isa(varargin{1}, 'namedtuple')
                obj = varargin{1};
                propNames = properties(obj);
                propValues = varargin(1:end);
                
                for i = 1:numel(propValues)
                    propName = propNames{i};
                    if ~strcmp(propName, 'Name')
                        obj.(propName) = propValues{i};
                    end
                end
            else
                if nargin > 1
                    obj.Name = varargin{1};
                    propNames = varargin{2};
                    
                    n = numel(propNames);
                    propValues = varargin(3:end);
                    
                    for i = 1:n
                        propName = propNames{i};
                        propValue = [];
                        if nargin > 2 && numel(propValues) >= i
                            propValue = propValues{i};
                        end
                        obj.addprop(propName);
                        obj.(propName) = propValue;
                    end
                end
            end
        end

        function obj = self(varargin)
            obj = varargin{1};
            propNames = properties(obj);
            propValues = varargin(1:end);

            for i = 1:numel(propValues)
                propName = propNames{i};
                if ~strcmp(propName, 'Name')
                    obj.(propName) = propValues{i};
                end
            end
        end
        
    end
end

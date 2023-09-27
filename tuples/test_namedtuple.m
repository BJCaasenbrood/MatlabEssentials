  % create a named tuple with two properties
  obj = NamedTuple('myTuple', {'foo', 'bar'}, 42, 'hello');

  % access the properties
  assert(obj.foo == 42);
  assert(strcmp(obj.bar, 'hello'));

  % create a new tuple that is a copy of the first one
  obj2 = NamedTuple(obj);
  assert(obj2.foo == obj.foo);
  assert(strcmp(obj2.bar, obj.bar));

  % modify a property of the original tuple
  obj.foo = 123;
  assert(obj.foo == 123);

  % add a new property to the original tuple
  obj.bar = 'world';
  assert(strcmp(obj.bar, 'world'));

  % create a new tuple from itsself
  Prop = NamedTuple('Prop',{'a','b'});
  obj = Prop.self(1,2);
  assert(obj.a == 1);
  assert(obj.b == 2);

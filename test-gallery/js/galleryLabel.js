(function(scope){
'use strict';

function F(arity, fun, wrapper) {
  wrapper.a = arity;
  wrapper.f = fun;
  return wrapper;
}

function F2(fun) {
  return F(2, fun, function(a) { return function(b) { return fun(a,b); }; })
}
function F3(fun) {
  return F(3, fun, function(a) {
    return function(b) { return function(c) { return fun(a, b, c); }; };
  });
}
function F4(fun) {
  return F(4, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return fun(a, b, c, d); }; }; };
  });
}
function F5(fun) {
  return F(5, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return fun(a, b, c, d, e); }; }; }; };
  });
}
function F6(fun) {
  return F(6, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return fun(a, b, c, d, e, f); }; }; }; }; };
  });
}
function F7(fun) {
  return F(7, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return fun(a, b, c, d, e, f, g); }; }; }; }; }; };
  });
}
function F8(fun) {
  return F(8, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return function(h) {
    return fun(a, b, c, d, e, f, g, h); }; }; }; }; }; }; };
  });
}
function F9(fun) {
  return F(9, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return function(h) { return function(i) {
    return fun(a, b, c, d, e, f, g, h, i); }; }; }; }; }; }; }; };
  });
}

function A2(fun, a, b) {
  return fun.a === 2 ? fun.f(a, b) : fun(a)(b);
}
function A3(fun, a, b, c) {
  return fun.a === 3 ? fun.f(a, b, c) : fun(a)(b)(c);
}
function A4(fun, a, b, c, d) {
  return fun.a === 4 ? fun.f(a, b, c, d) : fun(a)(b)(c)(d);
}
function A5(fun, a, b, c, d, e) {
  return fun.a === 5 ? fun.f(a, b, c, d, e) : fun(a)(b)(c)(d)(e);
}
function A6(fun, a, b, c, d, e, f) {
  return fun.a === 6 ? fun.f(a, b, c, d, e, f) : fun(a)(b)(c)(d)(e)(f);
}
function A7(fun, a, b, c, d, e, f, g) {
  return fun.a === 7 ? fun.f(a, b, c, d, e, f, g) : fun(a)(b)(c)(d)(e)(f)(g);
}
function A8(fun, a, b, c, d, e, f, g, h) {
  return fun.a === 8 ? fun.f(a, b, c, d, e, f, g, h) : fun(a)(b)(c)(d)(e)(f)(g)(h);
}
function A9(fun, a, b, c, d, e, f, g, h, i) {
  return fun.a === 9 ? fun.f(a, b, c, d, e, f, g, h, i) : fun(a)(b)(c)(d)(e)(f)(g)(h)(i);
}

console.warn('Compiled in DEV mode. Follow the advice at https://elm-lang.org/0.19.1/optimize for better performance and smaller assets.');


var _List_Nil_UNUSED = { $: 0 };
var _List_Nil = { $: '[]' };

function _List_Cons_UNUSED(hd, tl) { return { $: 1, a: hd, b: tl }; }
function _List_Cons(hd, tl) { return { $: '::', a: hd, b: tl }; }


var _List_cons = F2(_List_Cons);

function _List_fromArray(arr)
{
	var out = _List_Nil;
	for (var i = arr.length; i--; )
	{
		out = _List_Cons(arr[i], out);
	}
	return out;
}

function _List_toArray(xs)
{
	for (var out = []; xs.b; xs = xs.b) // WHILE_CONS
	{
		out.push(xs.a);
	}
	return out;
}

var _List_map2 = F3(function(f, xs, ys)
{
	for (var arr = []; xs.b && ys.b; xs = xs.b, ys = ys.b) // WHILE_CONSES
	{
		arr.push(A2(f, xs.a, ys.a));
	}
	return _List_fromArray(arr);
});

var _List_map3 = F4(function(f, xs, ys, zs)
{
	for (var arr = []; xs.b && ys.b && zs.b; xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A3(f, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_map4 = F5(function(f, ws, xs, ys, zs)
{
	for (var arr = []; ws.b && xs.b && ys.b && zs.b; ws = ws.b, xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A4(f, ws.a, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_map5 = F6(function(f, vs, ws, xs, ys, zs)
{
	for (var arr = []; vs.b && ws.b && xs.b && ys.b && zs.b; vs = vs.b, ws = ws.b, xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A5(f, vs.a, ws.a, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_sortBy = F2(function(f, xs)
{
	return _List_fromArray(_List_toArray(xs).sort(function(a, b) {
		return _Utils_cmp(f(a), f(b));
	}));
});

var _List_sortWith = F2(function(f, xs)
{
	return _List_fromArray(_List_toArray(xs).sort(function(a, b) {
		var ord = A2(f, a, b);
		return ord === $elm$core$Basics$EQ ? 0 : ord === $elm$core$Basics$LT ? -1 : 1;
	}));
});



var _JsArray_empty = [];

function _JsArray_singleton(value)
{
    return [value];
}

function _JsArray_length(array)
{
    return array.length;
}

var _JsArray_initialize = F3(function(size, offset, func)
{
    var result = new Array(size);

    for (var i = 0; i < size; i++)
    {
        result[i] = func(offset + i);
    }

    return result;
});

var _JsArray_initializeFromList = F2(function (max, ls)
{
    var result = new Array(max);

    for (var i = 0; i < max && ls.b; i++)
    {
        result[i] = ls.a;
        ls = ls.b;
    }

    result.length = i;
    return _Utils_Tuple2(result, ls);
});

var _JsArray_unsafeGet = F2(function(index, array)
{
    return array[index];
});

var _JsArray_unsafeSet = F3(function(index, value, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = array[i];
    }

    result[index] = value;
    return result;
});

var _JsArray_push = F2(function(value, array)
{
    var length = array.length;
    var result = new Array(length + 1);

    for (var i = 0; i < length; i++)
    {
        result[i] = array[i];
    }

    result[length] = value;
    return result;
});

var _JsArray_foldl = F3(function(func, acc, array)
{
    var length = array.length;

    for (var i = 0; i < length; i++)
    {
        acc = A2(func, array[i], acc);
    }

    return acc;
});

var _JsArray_foldr = F3(function(func, acc, array)
{
    for (var i = array.length - 1; i >= 0; i--)
    {
        acc = A2(func, array[i], acc);
    }

    return acc;
});

var _JsArray_map = F2(function(func, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = func(array[i]);
    }

    return result;
});

var _JsArray_indexedMap = F3(function(func, offset, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = A2(func, offset + i, array[i]);
    }

    return result;
});

var _JsArray_slice = F3(function(from, to, array)
{
    return array.slice(from, to);
});

var _JsArray_appendN = F3(function(n, dest, source)
{
    var destLen = dest.length;
    var itemsToCopy = n - destLen;

    if (itemsToCopy > source.length)
    {
        itemsToCopy = source.length;
    }

    var size = destLen + itemsToCopy;
    var result = new Array(size);

    for (var i = 0; i < destLen; i++)
    {
        result[i] = dest[i];
    }

    for (var i = 0; i < itemsToCopy; i++)
    {
        result[i + destLen] = source[i];
    }

    return result;
});



// LOG

var _Debug_log_UNUSED = F2(function(tag, value)
{
	return value;
});

var _Debug_log = F2(function(tag, value)
{
	console.log(tag + ': ' + _Debug_toString(value));
	return value;
});


// TODOS

function _Debug_todo(moduleName, region)
{
	return function(message) {
		_Debug_crash(8, moduleName, region, message);
	};
}

function _Debug_todoCase(moduleName, region, value)
{
	return function(message) {
		_Debug_crash(9, moduleName, region, value, message);
	};
}


// TO STRING

function _Debug_toString_UNUSED(value)
{
	return '<internals>';
}

function _Debug_toString(value)
{
	return _Debug_toAnsiString(false, value);
}

function _Debug_toAnsiString(ansi, value)
{
	if (typeof value === 'function')
	{
		return _Debug_internalColor(ansi, '<function>');
	}

	if (typeof value === 'boolean')
	{
		return _Debug_ctorColor(ansi, value ? 'True' : 'False');
	}

	if (typeof value === 'number')
	{
		return _Debug_numberColor(ansi, value + '');
	}

	if (value instanceof String)
	{
		return _Debug_charColor(ansi, "'" + _Debug_addSlashes(value, true) + "'");
	}

	if (typeof value === 'string')
	{
		return _Debug_stringColor(ansi, '"' + _Debug_addSlashes(value, false) + '"');
	}

	if (typeof value === 'object' && '$' in value)
	{
		var tag = value.$;

		if (typeof tag === 'number')
		{
			return _Debug_internalColor(ansi, '<internals>');
		}

		if (tag[0] === '#')
		{
			var output = [];
			for (var k in value)
			{
				if (k === '$') continue;
				output.push(_Debug_toAnsiString(ansi, value[k]));
			}
			return '(' + output.join(',') + ')';
		}

		if (tag === 'Set_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Set')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, $elm$core$Set$toList(value));
		}

		if (tag === 'RBNode_elm_builtin' || tag === 'RBEmpty_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Dict')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, $elm$core$Dict$toList(value));
		}

		if (tag === 'Array_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Array')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, $elm$core$Array$toList(value));
		}

		if (tag === '::' || tag === '[]')
		{
			var output = '[';

			value.b && (output += _Debug_toAnsiString(ansi, value.a), value = value.b)

			for (; value.b; value = value.b) // WHILE_CONS
			{
				output += ',' + _Debug_toAnsiString(ansi, value.a);
			}
			return output + ']';
		}

		var output = '';
		for (var i in value)
		{
			if (i === '$') continue;
			var str = _Debug_toAnsiString(ansi, value[i]);
			var c0 = str[0];
			var parenless = c0 === '{' || c0 === '(' || c0 === '[' || c0 === '<' || c0 === '"' || str.indexOf(' ') < 0;
			output += ' ' + (parenless ? str : '(' + str + ')');
		}
		return _Debug_ctorColor(ansi, tag) + output;
	}

	if (typeof value === 'object')
	{
		var output = [];
		for (var key in value)
		{
			var field = key[0] === '_' ? key.slice(1) : key;
			output.push(_Debug_fadeColor(ansi, field) + ' = ' + _Debug_toAnsiString(ansi, value[key]));
		}
		if (output.length === 0)
		{
			return '{}';
		}
		return '{ ' + output.join(', ') + ' }';
	}

	return _Debug_internalColor(ansi, '<internals>');
}

function _Debug_addSlashes(str, isChar)
{
	var s = str
		.replace(/\\/g, '\\\\')
		.replace(/\n/g, '\\n')
		.replace(/\t/g, '\\t')
		.replace(/\r/g, '\\r')
		.replace(/\v/g, '\\v')
		.replace(/\0/g, '\\0');

	if (isChar)
	{
		return s.replace(/\'/g, '\\\'');
	}
	else
	{
		return s.replace(/\"/g, '\\"');
	}
}

function _Debug_ctorColor(ansi, string)
{
	return ansi ? '\x1b[96m' + string + '\x1b[0m' : string;
}

function _Debug_numberColor(ansi, string)
{
	return ansi ? '\x1b[95m' + string + '\x1b[0m' : string;
}

function _Debug_stringColor(ansi, string)
{
	return ansi ? '\x1b[93m' + string + '\x1b[0m' : string;
}

function _Debug_charColor(ansi, string)
{
	return ansi ? '\x1b[92m' + string + '\x1b[0m' : string;
}

function _Debug_fadeColor(ansi, string)
{
	return ansi ? '\x1b[37m' + string + '\x1b[0m' : string;
}

function _Debug_internalColor(ansi, string)
{
	return ansi ? '\x1b[94m' + string + '\x1b[0m' : string;
}



// CRASH


function _Debug_crash_UNUSED(identifier)
{
	throw new Error('https://github.com/elm/core/blob/1.0.0/hints/' + identifier + '.md');
}


function _Debug_crash(identifier, fact1, fact2, fact3, fact4)
{
	switch(identifier)
	{
		case 0:
			throw new Error('What node should I take over? In JavaScript I need something like:\n\n    Elm.Main.init({\n        node: document.getElementById("elm-node")\n    })\n\nYou need to do this with any Browser.sandbox or Browser.element program.');

		case 1:
			throw new Error('Browser.application programs cannot handle URLs like this:\n\n    ' + document.location.href + '\n\nWhat is the root? The root of your file system? Try looking at this program with `elm reactor` or some other server.');

		case 2:
			var jsonErrorString = fact1;
			throw new Error('Problem with the flags given to your Elm program on initialization.\n\n' + jsonErrorString);

		case 3:
			var portName = fact1;
			throw new Error('There can only be one port named `' + portName + '`, but your program has multiple.');

		case 4:
			var portName = fact1;
			var problem = fact2;
			throw new Error('Trying to send an unexpected type of value through port `' + portName + '`:\n' + problem);

		case 5:
			throw new Error('Trying to use `(==)` on functions.\nThere is no way to know if functions are "the same" in the Elm sense.\nRead more about this at https://package.elm-lang.org/packages/elm/core/latest/Basics#== which describes why it is this way and what the better version will look like.');

		case 6:
			var moduleName = fact1;
			throw new Error('Your page is loading multiple Elm scripts with a module named ' + moduleName + '. Maybe a duplicate script is getting loaded accidentally? If not, rename one of them so I know which is which!');

		case 8:
			var moduleName = fact1;
			var region = fact2;
			var message = fact3;
			throw new Error('TODO in module `' + moduleName + '` ' + _Debug_regionToString(region) + '\n\n' + message);

		case 9:
			var moduleName = fact1;
			var region = fact2;
			var value = fact3;
			var message = fact4;
			throw new Error(
				'TODO in module `' + moduleName + '` from the `case` expression '
				+ _Debug_regionToString(region) + '\n\nIt received the following value:\n\n    '
				+ _Debug_toString(value).replace('\n', '\n    ')
				+ '\n\nBut the branch that handles it says:\n\n    ' + message.replace('\n', '\n    ')
			);

		case 10:
			throw new Error('Bug in https://github.com/elm/virtual-dom/issues');

		case 11:
			throw new Error('Cannot perform mod 0. Division by zero error.');
	}
}

function _Debug_regionToString(region)
{
	if (region.start.line === region.end.line)
	{
		return 'on line ' + region.start.line;
	}
	return 'on lines ' + region.start.line + ' through ' + region.end.line;
}



// EQUALITY

function _Utils_eq(x, y)
{
	for (
		var pair, stack = [], isEqual = _Utils_eqHelp(x, y, 0, stack);
		isEqual && (pair = stack.pop());
		isEqual = _Utils_eqHelp(pair.a, pair.b, 0, stack)
		)
	{}

	return isEqual;
}

function _Utils_eqHelp(x, y, depth, stack)
{
	if (depth > 100)
	{
		stack.push(_Utils_Tuple2(x,y));
		return true;
	}

	if (x === y)
	{
		return true;
	}

	if (typeof x !== 'object' || x === null || y === null)
	{
		typeof x === 'function' && _Debug_crash(5);
		return false;
	}

	/**/
	if (x.$ === 'Set_elm_builtin')
	{
		x = $elm$core$Set$toList(x);
		y = $elm$core$Set$toList(y);
	}
	if (x.$ === 'RBNode_elm_builtin' || x.$ === 'RBEmpty_elm_builtin')
	{
		x = $elm$core$Dict$toList(x);
		y = $elm$core$Dict$toList(y);
	}
	//*/

	/**_UNUSED/
	if (x.$ < 0)
	{
		x = $elm$core$Dict$toList(x);
		y = $elm$core$Dict$toList(y);
	}
	//*/

	for (var key in x)
	{
		if (!_Utils_eqHelp(x[key], y[key], depth + 1, stack))
		{
			return false;
		}
	}
	return true;
}

var _Utils_equal = F2(_Utils_eq);
var _Utils_notEqual = F2(function(a, b) { return !_Utils_eq(a,b); });



// COMPARISONS

// Code in Generate/JavaScript.hs, Basics.js, and List.js depends on
// the particular integer values assigned to LT, EQ, and GT.

function _Utils_cmp(x, y, ord)
{
	if (typeof x !== 'object')
	{
		return x === y ? /*EQ*/ 0 : x < y ? /*LT*/ -1 : /*GT*/ 1;
	}

	/**/
	if (x instanceof String)
	{
		var a = x.valueOf();
		var b = y.valueOf();
		return a === b ? 0 : a < b ? -1 : 1;
	}
	//*/

	/**_UNUSED/
	if (!x.$)
	//*/
	/**/
	if (x.$[0] === '#')
	//*/
	{
		return (ord = _Utils_cmp(x.a, y.a))
			? ord
			: (ord = _Utils_cmp(x.b, y.b))
				? ord
				: _Utils_cmp(x.c, y.c);
	}

	// traverse conses until end of a list or a mismatch
	for (; x.b && y.b && !(ord = _Utils_cmp(x.a, y.a)); x = x.b, y = y.b) {} // WHILE_CONSES
	return ord || (x.b ? /*GT*/ 1 : y.b ? /*LT*/ -1 : /*EQ*/ 0);
}

var _Utils_lt = F2(function(a, b) { return _Utils_cmp(a, b) < 0; });
var _Utils_le = F2(function(a, b) { return _Utils_cmp(a, b) < 1; });
var _Utils_gt = F2(function(a, b) { return _Utils_cmp(a, b) > 0; });
var _Utils_ge = F2(function(a, b) { return _Utils_cmp(a, b) >= 0; });

var _Utils_compare = F2(function(x, y)
{
	var n = _Utils_cmp(x, y);
	return n < 0 ? $elm$core$Basics$LT : n ? $elm$core$Basics$GT : $elm$core$Basics$EQ;
});


// COMMON VALUES

var _Utils_Tuple0_UNUSED = 0;
var _Utils_Tuple0 = { $: '#0' };

function _Utils_Tuple2_UNUSED(a, b) { return { a: a, b: b }; }
function _Utils_Tuple2(a, b) { return { $: '#2', a: a, b: b }; }

function _Utils_Tuple3_UNUSED(a, b, c) { return { a: a, b: b, c: c }; }
function _Utils_Tuple3(a, b, c) { return { $: '#3', a: a, b: b, c: c }; }

function _Utils_chr_UNUSED(c) { return c; }
function _Utils_chr(c) { return new String(c); }


// RECORDS

function _Utils_update(oldRecord, updatedFields)
{
	var newRecord = {};

	for (var key in oldRecord)
	{
		newRecord[key] = oldRecord[key];
	}

	for (var key in updatedFields)
	{
		newRecord[key] = updatedFields[key];
	}

	return newRecord;
}


// APPEND

var _Utils_append = F2(_Utils_ap);

function _Utils_ap(xs, ys)
{
	// append Strings
	if (typeof xs === 'string')
	{
		return xs + ys;
	}

	// append Lists
	if (!xs.b)
	{
		return ys;
	}
	var root = _List_Cons(xs.a, ys);
	xs = xs.b
	for (var curr = root; xs.b; xs = xs.b) // WHILE_CONS
	{
		curr = curr.b = _List_Cons(xs.a, ys);
	}
	return root;
}



// MATH

var _Basics_add = F2(function(a, b) { return a + b; });
var _Basics_sub = F2(function(a, b) { return a - b; });
var _Basics_mul = F2(function(a, b) { return a * b; });
var _Basics_fdiv = F2(function(a, b) { return a / b; });
var _Basics_idiv = F2(function(a, b) { return (a / b) | 0; });
var _Basics_pow = F2(Math.pow);

var _Basics_remainderBy = F2(function(b, a) { return a % b; });

// https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/divmodnote-letter.pdf
var _Basics_modBy = F2(function(modulus, x)
{
	var answer = x % modulus;
	return modulus === 0
		? _Debug_crash(11)
		:
	((answer > 0 && modulus < 0) || (answer < 0 && modulus > 0))
		? answer + modulus
		: answer;
});


// TRIGONOMETRY

var _Basics_pi = Math.PI;
var _Basics_e = Math.E;
var _Basics_cos = Math.cos;
var _Basics_sin = Math.sin;
var _Basics_tan = Math.tan;
var _Basics_acos = Math.acos;
var _Basics_asin = Math.asin;
var _Basics_atan = Math.atan;
var _Basics_atan2 = F2(Math.atan2);


// MORE MATH

function _Basics_toFloat(x) { return x; }
function _Basics_truncate(n) { return n | 0; }
function _Basics_isInfinite(n) { return n === Infinity || n === -Infinity; }

var _Basics_ceiling = Math.ceil;
var _Basics_floor = Math.floor;
var _Basics_round = Math.round;
var _Basics_sqrt = Math.sqrt;
var _Basics_log = Math.log;
var _Basics_isNaN = isNaN;


// BOOLEANS

function _Basics_not(bool) { return !bool; }
var _Basics_and = F2(function(a, b) { return a && b; });
var _Basics_or  = F2(function(a, b) { return a || b; });
var _Basics_xor = F2(function(a, b) { return a !== b; });



var _String_cons = F2(function(chr, str)
{
	return chr + str;
});

function _String_uncons(string)
{
	var word = string.charCodeAt(0);
	return word
		? $elm$core$Maybe$Just(
			0xD800 <= word && word <= 0xDBFF
				? _Utils_Tuple2(_Utils_chr(string[0] + string[1]), string.slice(2))
				: _Utils_Tuple2(_Utils_chr(string[0]), string.slice(1))
		)
		: $elm$core$Maybe$Nothing;
}

var _String_append = F2(function(a, b)
{
	return a + b;
});

function _String_length(str)
{
	return str.length;
}

var _String_map = F2(function(func, string)
{
	var len = string.length;
	var array = new Array(len);
	var i = 0;
	while (i < len)
	{
		var word = string.charCodeAt(i);
		if (0xD800 <= word && word <= 0xDBFF)
		{
			array[i] = func(_Utils_chr(string[i] + string[i+1]));
			i += 2;
			continue;
		}
		array[i] = func(_Utils_chr(string[i]));
		i++;
	}
	return array.join('');
});

var _String_filter = F2(function(isGood, str)
{
	var arr = [];
	var len = str.length;
	var i = 0;
	while (i < len)
	{
		var char = str[i];
		var word = str.charCodeAt(i);
		i++;
		if (0xD800 <= word && word <= 0xDBFF)
		{
			char += str[i];
			i++;
		}

		if (isGood(_Utils_chr(char)))
		{
			arr.push(char);
		}
	}
	return arr.join('');
});

function _String_reverse(str)
{
	var len = str.length;
	var arr = new Array(len);
	var i = 0;
	while (i < len)
	{
		var word = str.charCodeAt(i);
		if (0xD800 <= word && word <= 0xDBFF)
		{
			arr[len - i] = str[i + 1];
			i++;
			arr[len - i] = str[i - 1];
			i++;
		}
		else
		{
			arr[len - i] = str[i];
			i++;
		}
	}
	return arr.join('');
}

var _String_foldl = F3(function(func, state, string)
{
	var len = string.length;
	var i = 0;
	while (i < len)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		i++;
		if (0xD800 <= word && word <= 0xDBFF)
		{
			char += string[i];
			i++;
		}
		state = A2(func, _Utils_chr(char), state);
	}
	return state;
});

var _String_foldr = F3(function(func, state, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		state = A2(func, _Utils_chr(char), state);
	}
	return state;
});

var _String_split = F2(function(sep, str)
{
	return str.split(sep);
});

var _String_join = F2(function(sep, strs)
{
	return strs.join(sep);
});

var _String_slice = F3(function(start, end, str) {
	return str.slice(start, end);
});

function _String_trim(str)
{
	return str.trim();
}

function _String_trimLeft(str)
{
	return str.replace(/^\s+/, '');
}

function _String_trimRight(str)
{
	return str.replace(/\s+$/, '');
}

function _String_words(str)
{
	return _List_fromArray(str.trim().split(/\s+/g));
}

function _String_lines(str)
{
	return _List_fromArray(str.split(/\r\n|\r|\n/g));
}

function _String_toUpper(str)
{
	return str.toUpperCase();
}

function _String_toLower(str)
{
	return str.toLowerCase();
}

var _String_any = F2(function(isGood, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		if (isGood(_Utils_chr(char)))
		{
			return true;
		}
	}
	return false;
});

var _String_all = F2(function(isGood, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		if (!isGood(_Utils_chr(char)))
		{
			return false;
		}
	}
	return true;
});

var _String_contains = F2(function(sub, str)
{
	return str.indexOf(sub) > -1;
});

var _String_startsWith = F2(function(sub, str)
{
	return str.indexOf(sub) === 0;
});

var _String_endsWith = F2(function(sub, str)
{
	return str.length >= sub.length &&
		str.lastIndexOf(sub) === str.length - sub.length;
});

var _String_indexes = F2(function(sub, str)
{
	var subLen = sub.length;

	if (subLen < 1)
	{
		return _List_Nil;
	}

	var i = 0;
	var is = [];

	while ((i = str.indexOf(sub, i)) > -1)
	{
		is.push(i);
		i = i + subLen;
	}

	return _List_fromArray(is);
});


// TO STRING

function _String_fromNumber(number)
{
	return number + '';
}


// INT CONVERSIONS

function _String_toInt(str)
{
	var total = 0;
	var code0 = str.charCodeAt(0);
	var start = code0 == 0x2B /* + */ || code0 == 0x2D /* - */ ? 1 : 0;

	for (var i = start; i < str.length; ++i)
	{
		var code = str.charCodeAt(i);
		if (code < 0x30 || 0x39 < code)
		{
			return $elm$core$Maybe$Nothing;
		}
		total = 10 * total + code - 0x30;
	}

	return i == start
		? $elm$core$Maybe$Nothing
		: $elm$core$Maybe$Just(code0 == 0x2D ? -total : total);
}


// FLOAT CONVERSIONS

function _String_toFloat(s)
{
	// check if it is a hex, octal, or binary number
	if (s.length === 0 || /[\sxbo]/.test(s))
	{
		return $elm$core$Maybe$Nothing;
	}
	var n = +s;
	// faster isNaN check
	return n === n ? $elm$core$Maybe$Just(n) : $elm$core$Maybe$Nothing;
}

function _String_fromList(chars)
{
	return _List_toArray(chars).join('');
}




function _Char_toCode(char)
{
	var code = char.charCodeAt(0);
	if (0xD800 <= code && code <= 0xDBFF)
	{
		return (code - 0xD800) * 0x400 + char.charCodeAt(1) - 0xDC00 + 0x10000
	}
	return code;
}

function _Char_fromCode(code)
{
	return _Utils_chr(
		(code < 0 || 0x10FFFF < code)
			? '\uFFFD'
			:
		(code <= 0xFFFF)
			? String.fromCharCode(code)
			:
		(code -= 0x10000,
			String.fromCharCode(Math.floor(code / 0x400) + 0xD800)
			+
			String.fromCharCode(code % 0x400 + 0xDC00)
		)
	);
}

function _Char_toUpper(char)
{
	return _Utils_chr(char.toUpperCase());
}

function _Char_toLower(char)
{
	return _Utils_chr(char.toLowerCase());
}

function _Char_toLocaleUpper(char)
{
	return _Utils_chr(char.toLocaleUpperCase());
}

function _Char_toLocaleLower(char)
{
	return _Utils_chr(char.toLocaleLowerCase());
}



/**/
function _Json_errorToString(error)
{
	return $elm$json$Json$Decode$errorToString(error);
}
//*/


// CORE DECODERS

function _Json_succeed(msg)
{
	return {
		$: 0,
		a: msg
	};
}

function _Json_fail(msg)
{
	return {
		$: 1,
		a: msg
	};
}

var _Json_decodeInt = { $: 2 };
var _Json_decodeBool = { $: 3 };
var _Json_decodeFloat = { $: 4 };
var _Json_decodeValue = { $: 5 };
var _Json_decodeString = { $: 6 };

function _Json_decodeList(decoder) { return { $: 7, b: decoder }; }
function _Json_decodeArray(decoder) { return { $: 8, b: decoder }; }

function _Json_decodeNull(value) { return { $: 9, c: value }; }

var _Json_decodeField = F2(function(field, decoder)
{
	return {
		$: 10,
		d: field,
		b: decoder
	};
});

var _Json_decodeIndex = F2(function(index, decoder)
{
	return {
		$: 11,
		e: index,
		b: decoder
	};
});

function _Json_decodeKeyValuePairs(decoder)
{
	return {
		$: 12,
		b: decoder
	};
}

function _Json_mapMany(f, decoders)
{
	return {
		$: 13,
		f: f,
		g: decoders
	};
}

var _Json_andThen = F2(function(callback, decoder)
{
	return {
		$: 14,
		b: decoder,
		h: callback
	};
});

function _Json_oneOf(decoders)
{
	return {
		$: 15,
		g: decoders
	};
}


// DECODING OBJECTS

var _Json_map1 = F2(function(f, d1)
{
	return _Json_mapMany(f, [d1]);
});

var _Json_map2 = F3(function(f, d1, d2)
{
	return _Json_mapMany(f, [d1, d2]);
});

var _Json_map3 = F4(function(f, d1, d2, d3)
{
	return _Json_mapMany(f, [d1, d2, d3]);
});

var _Json_map4 = F5(function(f, d1, d2, d3, d4)
{
	return _Json_mapMany(f, [d1, d2, d3, d4]);
});

var _Json_map5 = F6(function(f, d1, d2, d3, d4, d5)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5]);
});

var _Json_map6 = F7(function(f, d1, d2, d3, d4, d5, d6)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6]);
});

var _Json_map7 = F8(function(f, d1, d2, d3, d4, d5, d6, d7)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6, d7]);
});

var _Json_map8 = F9(function(f, d1, d2, d3, d4, d5, d6, d7, d8)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6, d7, d8]);
});


// DECODE

var _Json_runOnString = F2(function(decoder, string)
{
	try
	{
		var value = JSON.parse(string);
		return _Json_runHelp(decoder, value);
	}
	catch (e)
	{
		return $elm$core$Result$Err(A2($elm$json$Json$Decode$Failure, 'This is not valid JSON! ' + e.message, _Json_wrap(string)));
	}
});

var _Json_run = F2(function(decoder, value)
{
	return _Json_runHelp(decoder, _Json_unwrap(value));
});

function _Json_runHelp(decoder, value)
{
	switch (decoder.$)
	{
		case 3:
			return (typeof value === 'boolean')
				? $elm$core$Result$Ok(value)
				: _Json_expecting('a BOOL', value);

		case 2:
			if (typeof value !== 'number') {
				return _Json_expecting('an INT', value);
			}

			if (-2147483647 < value && value < 2147483647 && (value | 0) === value) {
				return $elm$core$Result$Ok(value);
			}

			if (isFinite(value) && !(value % 1)) {
				return $elm$core$Result$Ok(value);
			}

			return _Json_expecting('an INT', value);

		case 4:
			return (typeof value === 'number')
				? $elm$core$Result$Ok(value)
				: _Json_expecting('a FLOAT', value);

		case 6:
			return (typeof value === 'string')
				? $elm$core$Result$Ok(value)
				: (value instanceof String)
					? $elm$core$Result$Ok(value + '')
					: _Json_expecting('a STRING', value);

		case 9:
			return (value === null)
				? $elm$core$Result$Ok(decoder.c)
				: _Json_expecting('null', value);

		case 5:
			return $elm$core$Result$Ok(_Json_wrap(value));

		case 7:
			if (!Array.isArray(value))
			{
				return _Json_expecting('a LIST', value);
			}
			return _Json_runArrayDecoder(decoder.b, value, _List_fromArray);

		case 8:
			if (!Array.isArray(value))
			{
				return _Json_expecting('an ARRAY', value);
			}
			return _Json_runArrayDecoder(decoder.b, value, _Json_toElmArray);

		case 10:
			var field = decoder.d;
			if (typeof value !== 'object' || value === null || !(field in value))
			{
				return _Json_expecting('an OBJECT with a field named `' + field + '`', value);
			}
			var result = _Json_runHelp(decoder.b, value[field]);
			return ($elm$core$Result$isOk(result)) ? result : $elm$core$Result$Err(A2($elm$json$Json$Decode$Field, field, result.a));

		case 11:
			var index = decoder.e;
			if (!Array.isArray(value))
			{
				return _Json_expecting('an ARRAY', value);
			}
			if (index >= value.length)
			{
				return _Json_expecting('a LONGER array. Need index ' + index + ' but only see ' + value.length + ' entries', value);
			}
			var result = _Json_runHelp(decoder.b, value[index]);
			return ($elm$core$Result$isOk(result)) ? result : $elm$core$Result$Err(A2($elm$json$Json$Decode$Index, index, result.a));

		case 12:
			if (typeof value !== 'object' || value === null || Array.isArray(value))
			{
				return _Json_expecting('an OBJECT', value);
			}

			var keyValuePairs = _List_Nil;
			// TODO test perf of Object.keys and switch when support is good enough
			for (var key in value)
			{
				if (value.hasOwnProperty(key))
				{
					var result = _Json_runHelp(decoder.b, value[key]);
					if (!$elm$core$Result$isOk(result))
					{
						return $elm$core$Result$Err(A2($elm$json$Json$Decode$Field, key, result.a));
					}
					keyValuePairs = _List_Cons(_Utils_Tuple2(key, result.a), keyValuePairs);
				}
			}
			return $elm$core$Result$Ok($elm$core$List$reverse(keyValuePairs));

		case 13:
			var answer = decoder.f;
			var decoders = decoder.g;
			for (var i = 0; i < decoders.length; i++)
			{
				var result = _Json_runHelp(decoders[i], value);
				if (!$elm$core$Result$isOk(result))
				{
					return result;
				}
				answer = answer(result.a);
			}
			return $elm$core$Result$Ok(answer);

		case 14:
			var result = _Json_runHelp(decoder.b, value);
			return (!$elm$core$Result$isOk(result))
				? result
				: _Json_runHelp(decoder.h(result.a), value);

		case 15:
			var errors = _List_Nil;
			for (var temp = decoder.g; temp.b; temp = temp.b) // WHILE_CONS
			{
				var result = _Json_runHelp(temp.a, value);
				if ($elm$core$Result$isOk(result))
				{
					return result;
				}
				errors = _List_Cons(result.a, errors);
			}
			return $elm$core$Result$Err($elm$json$Json$Decode$OneOf($elm$core$List$reverse(errors)));

		case 1:
			return $elm$core$Result$Err(A2($elm$json$Json$Decode$Failure, decoder.a, _Json_wrap(value)));

		case 0:
			return $elm$core$Result$Ok(decoder.a);
	}
}

function _Json_runArrayDecoder(decoder, value, toElmValue)
{
	var len = value.length;
	var array = new Array(len);
	for (var i = 0; i < len; i++)
	{
		var result = _Json_runHelp(decoder, value[i]);
		if (!$elm$core$Result$isOk(result))
		{
			return $elm$core$Result$Err(A2($elm$json$Json$Decode$Index, i, result.a));
		}
		array[i] = result.a;
	}
	return $elm$core$Result$Ok(toElmValue(array));
}

function _Json_toElmArray(array)
{
	return A2($elm$core$Array$initialize, array.length, function(i) { return array[i]; });
}

function _Json_expecting(type, value)
{
	return $elm$core$Result$Err(A2($elm$json$Json$Decode$Failure, 'Expecting ' + type, _Json_wrap(value)));
}


// EQUALITY

function _Json_equality(x, y)
{
	if (x === y)
	{
		return true;
	}

	if (x.$ !== y.$)
	{
		return false;
	}

	switch (x.$)
	{
		case 0:
		case 1:
			return x.a === y.a;

		case 3:
		case 2:
		case 4:
		case 6:
		case 5:
			return true;

		case 9:
			return x.c === y.c;

		case 7:
		case 8:
		case 12:
			return _Json_equality(x.b, y.b);

		case 10:
			return x.d === y.d && _Json_equality(x.b, y.b);

		case 11:
			return x.e === y.e && _Json_equality(x.b, y.b);

		case 13:
			return x.f === y.f && _Json_listEquality(x.g, y.g);

		case 14:
			return x.h === y.h && _Json_equality(x.b, y.b);

		case 15:
			return _Json_listEquality(x.g, y.g);
	}
}

function _Json_listEquality(aDecoders, bDecoders)
{
	var len = aDecoders.length;
	if (len !== bDecoders.length)
	{
		return false;
	}
	for (var i = 0; i < len; i++)
	{
		if (!_Json_equality(aDecoders[i], bDecoders[i]))
		{
			return false;
		}
	}
	return true;
}


// ENCODE

var _Json_encode = F2(function(indentLevel, value)
{
	return JSON.stringify(_Json_unwrap(value), null, indentLevel) + '';
});

function _Json_wrap(value) { return { $: 0, a: value }; }
function _Json_unwrap(value) { return value.a; }

function _Json_wrap_UNUSED(value) { return value; }
function _Json_unwrap_UNUSED(value) { return value; }

function _Json_emptyArray() { return []; }
function _Json_emptyObject() { return {}; }

var _Json_addField = F3(function(key, value, object)
{
	object[key] = _Json_unwrap(value);
	return object;
});

function _Json_addEntry(func)
{
	return F2(function(entry, array)
	{
		array.push(_Json_unwrap(func(entry)));
		return array;
	});
}

var _Json_encodeNull = _Json_wrap(null);



// TASKS

function _Scheduler_succeed(value)
{
	return {
		$: 0,
		a: value
	};
}

function _Scheduler_fail(error)
{
	return {
		$: 1,
		a: error
	};
}

function _Scheduler_binding(callback)
{
	return {
		$: 2,
		b: callback,
		c: null
	};
}

var _Scheduler_andThen = F2(function(callback, task)
{
	return {
		$: 3,
		b: callback,
		d: task
	};
});

var _Scheduler_onError = F2(function(callback, task)
{
	return {
		$: 4,
		b: callback,
		d: task
	};
});

function _Scheduler_receive(callback)
{
	return {
		$: 5,
		b: callback
	};
}


// PROCESSES

var _Scheduler_guid = 0;

function _Scheduler_rawSpawn(task)
{
	var proc = {
		$: 0,
		e: _Scheduler_guid++,
		f: task,
		g: null,
		h: []
	};

	_Scheduler_enqueue(proc);

	return proc;
}

function _Scheduler_spawn(task)
{
	return _Scheduler_binding(function(callback) {
		callback(_Scheduler_succeed(_Scheduler_rawSpawn(task)));
	});
}

function _Scheduler_rawSend(proc, msg)
{
	proc.h.push(msg);
	_Scheduler_enqueue(proc);
}

var _Scheduler_send = F2(function(proc, msg)
{
	return _Scheduler_binding(function(callback) {
		_Scheduler_rawSend(proc, msg);
		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
});

function _Scheduler_kill(proc)
{
	return _Scheduler_binding(function(callback) {
		var task = proc.f;
		if (task.$ === 2 && task.c)
		{
			task.c();
		}

		proc.f = null;

		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
}


/* STEP PROCESSES

type alias Process =
  { $ : tag
  , id : unique_id
  , root : Task
  , stack : null | { $: SUCCEED | FAIL, a: callback, b: stack }
  , mailbox : [msg]
  }

*/


var _Scheduler_working = false;
var _Scheduler_queue = [];


function _Scheduler_enqueue(proc)
{
	_Scheduler_queue.push(proc);
	if (_Scheduler_working)
	{
		return;
	}
	_Scheduler_working = true;
	while (proc = _Scheduler_queue.shift())
	{
		_Scheduler_step(proc);
	}
	_Scheduler_working = false;
}


function _Scheduler_step(proc)
{
	while (proc.f)
	{
		var rootTag = proc.f.$;
		if (rootTag === 0 || rootTag === 1)
		{
			while (proc.g && proc.g.$ !== rootTag)
			{
				proc.g = proc.g.i;
			}
			if (!proc.g)
			{
				return;
			}
			proc.f = proc.g.b(proc.f.a);
			proc.g = proc.g.i;
		}
		else if (rootTag === 2)
		{
			proc.f.c = proc.f.b(function(newRoot) {
				proc.f = newRoot;
				_Scheduler_enqueue(proc);
			});
			return;
		}
		else if (rootTag === 5)
		{
			if (proc.h.length === 0)
			{
				return;
			}
			proc.f = proc.f.b(proc.h.shift());
		}
		else // if (rootTag === 3 || rootTag === 4)
		{
			proc.g = {
				$: rootTag === 3 ? 0 : 1,
				b: proc.f.b,
				i: proc.g
			};
			proc.f = proc.f.d;
		}
	}
}



function _Process_sleep(time)
{
	return _Scheduler_binding(function(callback) {
		var id = setTimeout(function() {
			callback(_Scheduler_succeed(_Utils_Tuple0));
		}, time);

		return function() { clearTimeout(id); };
	});
}




// PROGRAMS


var _Platform_worker = F4(function(impl, flagDecoder, debugMetadata, args)
{
	return _Platform_initialize(
		flagDecoder,
		args,
		impl.init,
		impl.update,
		impl.subscriptions,
		function() { return function() {} }
	);
});



// INITIALIZE A PROGRAM


function _Platform_initialize(flagDecoder, args, init, update, subscriptions, stepperBuilder)
{
	var result = A2(_Json_run, flagDecoder, _Json_wrap(args ? args['flags'] : undefined));
	$elm$core$Result$isOk(result) || _Debug_crash(2 /**/, _Json_errorToString(result.a) /**/);
	var managers = {};
	result = init(result.a);
	var model = result.a;
	var stepper = stepperBuilder(sendToApp, model);
	var ports = _Platform_setupEffects(managers, sendToApp);

	function sendToApp(msg, viewMetadata)
	{
		result = A2(update, msg, model);
		stepper(model = result.a, viewMetadata);
		_Platform_dispatchEffects(managers, result.b, subscriptions(model));
	}

	_Platform_dispatchEffects(managers, result.b, subscriptions(model));

	return ports ? { ports: ports } : {};
}



// TRACK PRELOADS
//
// This is used by code in elm/browser and elm/http
// to register any HTTP requests that are triggered by init.
//


var _Platform_preload;


function _Platform_registerPreload(url)
{
	_Platform_preload.add(url);
}



// EFFECT MANAGERS


var _Platform_effectManagers = {};


function _Platform_setupEffects(managers, sendToApp)
{
	var ports;

	// setup all necessary effect managers
	for (var key in _Platform_effectManagers)
	{
		var manager = _Platform_effectManagers[key];

		if (manager.a)
		{
			ports = ports || {};
			ports[key] = manager.a(key, sendToApp);
		}

		managers[key] = _Platform_instantiateManager(manager, sendToApp);
	}

	return ports;
}


function _Platform_createManager(init, onEffects, onSelfMsg, cmdMap, subMap)
{
	return {
		b: init,
		c: onEffects,
		d: onSelfMsg,
		e: cmdMap,
		f: subMap
	};
}


function _Platform_instantiateManager(info, sendToApp)
{
	var router = {
		g: sendToApp,
		h: undefined
	};

	var onEffects = info.c;
	var onSelfMsg = info.d;
	var cmdMap = info.e;
	var subMap = info.f;

	function loop(state)
	{
		return A2(_Scheduler_andThen, loop, _Scheduler_receive(function(msg)
		{
			var value = msg.a;

			if (msg.$ === 0)
			{
				return A3(onSelfMsg, router, value, state);
			}

			return cmdMap && subMap
				? A4(onEffects, router, value.i, value.j, state)
				: A3(onEffects, router, cmdMap ? value.i : value.j, state);
		}));
	}

	return router.h = _Scheduler_rawSpawn(A2(_Scheduler_andThen, loop, info.b));
}



// ROUTING


var _Platform_sendToApp = F2(function(router, msg)
{
	return _Scheduler_binding(function(callback)
	{
		router.g(msg);
		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
});


var _Platform_sendToSelf = F2(function(router, msg)
{
	return A2(_Scheduler_send, router.h, {
		$: 0,
		a: msg
	});
});



// BAGS


function _Platform_leaf(home)
{
	return function(value)
	{
		return {
			$: 1,
			k: home,
			l: value
		};
	};
}


function _Platform_batch(list)
{
	return {
		$: 2,
		m: list
	};
}


var _Platform_map = F2(function(tagger, bag)
{
	return {
		$: 3,
		n: tagger,
		o: bag
	}
});



// PIPE BAGS INTO EFFECT MANAGERS


function _Platform_dispatchEffects(managers, cmdBag, subBag)
{
	var effectsDict = {};
	_Platform_gatherEffects(true, cmdBag, effectsDict, null);
	_Platform_gatherEffects(false, subBag, effectsDict, null);

	for (var home in managers)
	{
		_Scheduler_rawSend(managers[home], {
			$: 'fx',
			a: effectsDict[home] || { i: _List_Nil, j: _List_Nil }
		});
	}
}


function _Platform_gatherEffects(isCmd, bag, effectsDict, taggers)
{
	switch (bag.$)
	{
		case 1:
			var home = bag.k;
			var effect = _Platform_toEffect(isCmd, home, taggers, bag.l);
			effectsDict[home] = _Platform_insert(isCmd, effect, effectsDict[home]);
			return;

		case 2:
			for (var list = bag.m; list.b; list = list.b) // WHILE_CONS
			{
				_Platform_gatherEffects(isCmd, list.a, effectsDict, taggers);
			}
			return;

		case 3:
			_Platform_gatherEffects(isCmd, bag.o, effectsDict, {
				p: bag.n,
				q: taggers
			});
			return;
	}
}


function _Platform_toEffect(isCmd, home, taggers, value)
{
	function applyTaggers(x)
	{
		for (var temp = taggers; temp; temp = temp.q)
		{
			x = temp.p(x);
		}
		return x;
	}

	var map = isCmd
		? _Platform_effectManagers[home].e
		: _Platform_effectManagers[home].f;

	return A2(map, applyTaggers, value)
}


function _Platform_insert(isCmd, newEffect, effects)
{
	effects = effects || { i: _List_Nil, j: _List_Nil };

	isCmd
		? (effects.i = _List_Cons(newEffect, effects.i))
		: (effects.j = _List_Cons(newEffect, effects.j));

	return effects;
}



// PORTS


function _Platform_checkPortName(name)
{
	if (_Platform_effectManagers[name])
	{
		_Debug_crash(3, name)
	}
}



// OUTGOING PORTS


function _Platform_outgoingPort(name, converter)
{
	_Platform_checkPortName(name);
	_Platform_effectManagers[name] = {
		e: _Platform_outgoingPortMap,
		r: converter,
		a: _Platform_setupOutgoingPort
	};
	return _Platform_leaf(name);
}


var _Platform_outgoingPortMap = F2(function(tagger, value) { return value; });


function _Platform_setupOutgoingPort(name)
{
	var subs = [];
	var converter = _Platform_effectManagers[name].r;

	// CREATE MANAGER

	var init = _Process_sleep(0);

	_Platform_effectManagers[name].b = init;
	_Platform_effectManagers[name].c = F3(function(router, cmdList, state)
	{
		for ( ; cmdList.b; cmdList = cmdList.b) // WHILE_CONS
		{
			// grab a separate reference to subs in case unsubscribe is called
			var currentSubs = subs;
			var value = _Json_unwrap(converter(cmdList.a));
			for (var i = 0; i < currentSubs.length; i++)
			{
				currentSubs[i](value);
			}
		}
		return init;
	});

	// PUBLIC API

	function subscribe(callback)
	{
		subs.push(callback);
	}

	function unsubscribe(callback)
	{
		// copy subs into a new array in case unsubscribe is called within a
		// subscribed callback
		subs = subs.slice();
		var index = subs.indexOf(callback);
		if (index >= 0)
		{
			subs.splice(index, 1);
		}
	}

	return {
		subscribe: subscribe,
		unsubscribe: unsubscribe
	};
}



// INCOMING PORTS


function _Platform_incomingPort(name, converter)
{
	_Platform_checkPortName(name);
	_Platform_effectManagers[name] = {
		f: _Platform_incomingPortMap,
		r: converter,
		a: _Platform_setupIncomingPort
	};
	return _Platform_leaf(name);
}


var _Platform_incomingPortMap = F2(function(tagger, finalTagger)
{
	return function(value)
	{
		return tagger(finalTagger(value));
	};
});


function _Platform_setupIncomingPort(name, sendToApp)
{
	var subs = _List_Nil;
	var converter = _Platform_effectManagers[name].r;

	// CREATE MANAGER

	var init = _Scheduler_succeed(null);

	_Platform_effectManagers[name].b = init;
	_Platform_effectManagers[name].c = F3(function(router, subList, state)
	{
		subs = subList;
		return init;
	});

	// PUBLIC API

	function send(incomingValue)
	{
		var result = A2(_Json_run, converter, _Json_wrap(incomingValue));

		$elm$core$Result$isOk(result) || _Debug_crash(4, name, result.a);

		var value = result.a;
		for (var temp = subs; temp.b; temp = temp.b) // WHILE_CONS
		{
			sendToApp(temp.a(value));
		}
	}

	return { send: send };
}



// EXPORT ELM MODULES
//
// Have DEBUG and PROD versions so that we can (1) give nicer errors in
// debug mode and (2) not pay for the bits needed for that in prod mode.
//


function _Platform_export_UNUSED(exports)
{
	scope['Elm']
		? _Platform_mergeExportsProd(scope['Elm'], exports)
		: scope['Elm'] = exports;
}


function _Platform_mergeExportsProd(obj, exports)
{
	for (var name in exports)
	{
		(name in obj)
			? (name == 'init')
				? _Debug_crash(6)
				: _Platform_mergeExportsProd(obj[name], exports[name])
			: (obj[name] = exports[name]);
	}
}


function _Platform_export(exports)
{
	scope['Elm']
		? _Platform_mergeExportsDebug('Elm', scope['Elm'], exports)
		: scope['Elm'] = exports;
}


function _Platform_mergeExportsDebug(moduleName, obj, exports)
{
	for (var name in exports)
	{
		(name in obj)
			? (name == 'init')
				? _Debug_crash(6, moduleName)
				: _Platform_mergeExportsDebug(moduleName + '.' + name, obj[name], exports[name])
			: (obj[name] = exports[name]);
	}
}
var $elm$core$Basics$EQ = {$: 'EQ'};
var $elm$core$Basics$LT = {$: 'LT'};
var $elm$core$List$cons = _List_cons;
var $elm$core$Elm$JsArray$foldr = _JsArray_foldr;
var $elm$core$Array$foldr = F3(
	function (func, baseCase, _v0) {
		var tree = _v0.c;
		var tail = _v0.d;
		var helper = F2(
			function (node, acc) {
				if (node.$ === 'SubTree') {
					var subTree = node.a;
					return A3($elm$core$Elm$JsArray$foldr, helper, acc, subTree);
				} else {
					var values = node.a;
					return A3($elm$core$Elm$JsArray$foldr, func, acc, values);
				}
			});
		return A3(
			$elm$core$Elm$JsArray$foldr,
			helper,
			A3($elm$core$Elm$JsArray$foldr, func, baseCase, tail),
			tree);
	});
var $elm$core$Array$toList = function (array) {
	return A3($elm$core$Array$foldr, $elm$core$List$cons, _List_Nil, array);
};
var $elm$core$Dict$foldr = F3(
	function (func, acc, t) {
		foldr:
		while (true) {
			if (t.$ === 'RBEmpty_elm_builtin') {
				return acc;
			} else {
				var key = t.b;
				var value = t.c;
				var left = t.d;
				var right = t.e;
				var $temp$func = func,
					$temp$acc = A3(
					func,
					key,
					value,
					A3($elm$core$Dict$foldr, func, acc, right)),
					$temp$t = left;
				func = $temp$func;
				acc = $temp$acc;
				t = $temp$t;
				continue foldr;
			}
		}
	});
var $elm$core$Dict$toList = function (dict) {
	return A3(
		$elm$core$Dict$foldr,
		F3(
			function (key, value, list) {
				return A2(
					$elm$core$List$cons,
					_Utils_Tuple2(key, value),
					list);
			}),
		_List_Nil,
		dict);
};
var $elm$core$Dict$keys = function (dict) {
	return A3(
		$elm$core$Dict$foldr,
		F3(
			function (key, value, keyList) {
				return A2($elm$core$List$cons, key, keyList);
			}),
		_List_Nil,
		dict);
};
var $elm$core$Set$toList = function (_v0) {
	var dict = _v0.a;
	return $elm$core$Dict$keys(dict);
};
var $elm$core$Basics$GT = {$: 'GT'};
var $elm$core$Basics$always = F2(
	function (a, _v0) {
		return a;
	});
var $elm$core$Basics$identity = function (x) {
	return x;
};
var $author$project$GalleryLabel$elmToJS = _Platform_outgoingPort('elmToJS', $elm$core$Basics$identity);
var $elm$core$Result$Err = function (a) {
	return {$: 'Err', a: a};
};
var $elm$json$Json$Decode$Failure = F2(
	function (a, b) {
		return {$: 'Failure', a: a, b: b};
	});
var $elm$json$Json$Decode$Field = F2(
	function (a, b) {
		return {$: 'Field', a: a, b: b};
	});
var $elm$json$Json$Decode$Index = F2(
	function (a, b) {
		return {$: 'Index', a: a, b: b};
	});
var $elm$core$Result$Ok = function (a) {
	return {$: 'Ok', a: a};
};
var $elm$json$Json$Decode$OneOf = function (a) {
	return {$: 'OneOf', a: a};
};
var $elm$core$Basics$False = {$: 'False'};
var $elm$core$Basics$add = _Basics_add;
var $elm$core$Maybe$Just = function (a) {
	return {$: 'Just', a: a};
};
var $elm$core$Maybe$Nothing = {$: 'Nothing'};
var $elm$core$String$all = _String_all;
var $elm$core$Basics$and = _Basics_and;
var $elm$core$Basics$append = _Utils_append;
var $elm$json$Json$Encode$encode = _Json_encode;
var $elm$core$String$fromInt = _String_fromNumber;
var $elm$core$String$join = F2(
	function (sep, chunks) {
		return A2(
			_String_join,
			sep,
			_List_toArray(chunks));
	});
var $elm$core$String$split = F2(
	function (sep, string) {
		return _List_fromArray(
			A2(_String_split, sep, string));
	});
var $elm$json$Json$Decode$indent = function (str) {
	return A2(
		$elm$core$String$join,
		'\n    ',
		A2($elm$core$String$split, '\n', str));
};
var $elm$core$List$foldl = F3(
	function (func, acc, list) {
		foldl:
		while (true) {
			if (!list.b) {
				return acc;
			} else {
				var x = list.a;
				var xs = list.b;
				var $temp$func = func,
					$temp$acc = A2(func, x, acc),
					$temp$list = xs;
				func = $temp$func;
				acc = $temp$acc;
				list = $temp$list;
				continue foldl;
			}
		}
	});
var $elm$core$List$length = function (xs) {
	return A3(
		$elm$core$List$foldl,
		F2(
			function (_v0, i) {
				return i + 1;
			}),
		0,
		xs);
};
var $elm$core$List$map2 = _List_map2;
var $elm$core$Basics$le = _Utils_le;
var $elm$core$Basics$sub = _Basics_sub;
var $elm$core$List$rangeHelp = F3(
	function (lo, hi, list) {
		rangeHelp:
		while (true) {
			if (_Utils_cmp(lo, hi) < 1) {
				var $temp$lo = lo,
					$temp$hi = hi - 1,
					$temp$list = A2($elm$core$List$cons, hi, list);
				lo = $temp$lo;
				hi = $temp$hi;
				list = $temp$list;
				continue rangeHelp;
			} else {
				return list;
			}
		}
	});
var $elm$core$List$range = F2(
	function (lo, hi) {
		return A3($elm$core$List$rangeHelp, lo, hi, _List_Nil);
	});
var $elm$core$List$indexedMap = F2(
	function (f, xs) {
		return A3(
			$elm$core$List$map2,
			f,
			A2(
				$elm$core$List$range,
				0,
				$elm$core$List$length(xs) - 1),
			xs);
	});
var $elm$core$Char$toCode = _Char_toCode;
var $elm$core$Char$isLower = function (_char) {
	var code = $elm$core$Char$toCode(_char);
	return (97 <= code) && (code <= 122);
};
var $elm$core$Char$isUpper = function (_char) {
	var code = $elm$core$Char$toCode(_char);
	return (code <= 90) && (65 <= code);
};
var $elm$core$Basics$or = _Basics_or;
var $elm$core$Char$isAlpha = function (_char) {
	return $elm$core$Char$isLower(_char) || $elm$core$Char$isUpper(_char);
};
var $elm$core$Char$isDigit = function (_char) {
	var code = $elm$core$Char$toCode(_char);
	return (code <= 57) && (48 <= code);
};
var $elm$core$Char$isAlphaNum = function (_char) {
	return $elm$core$Char$isLower(_char) || ($elm$core$Char$isUpper(_char) || $elm$core$Char$isDigit(_char));
};
var $elm$core$List$reverse = function (list) {
	return A3($elm$core$List$foldl, $elm$core$List$cons, _List_Nil, list);
};
var $elm$core$String$uncons = _String_uncons;
var $elm$json$Json$Decode$errorOneOf = F2(
	function (i, error) {
		return '\n\n(' + ($elm$core$String$fromInt(i + 1) + (') ' + $elm$json$Json$Decode$indent(
			$elm$json$Json$Decode$errorToString(error))));
	});
var $elm$json$Json$Decode$errorToString = function (error) {
	return A2($elm$json$Json$Decode$errorToStringHelp, error, _List_Nil);
};
var $elm$json$Json$Decode$errorToStringHelp = F2(
	function (error, context) {
		errorToStringHelp:
		while (true) {
			switch (error.$) {
				case 'Field':
					var f = error.a;
					var err = error.b;
					var isSimple = function () {
						var _v1 = $elm$core$String$uncons(f);
						if (_v1.$ === 'Nothing') {
							return false;
						} else {
							var _v2 = _v1.a;
							var _char = _v2.a;
							var rest = _v2.b;
							return $elm$core$Char$isAlpha(_char) && A2($elm$core$String$all, $elm$core$Char$isAlphaNum, rest);
						}
					}();
					var fieldName = isSimple ? ('.' + f) : ('[\'' + (f + '\']'));
					var $temp$error = err,
						$temp$context = A2($elm$core$List$cons, fieldName, context);
					error = $temp$error;
					context = $temp$context;
					continue errorToStringHelp;
				case 'Index':
					var i = error.a;
					var err = error.b;
					var indexName = '[' + ($elm$core$String$fromInt(i) + ']');
					var $temp$error = err,
						$temp$context = A2($elm$core$List$cons, indexName, context);
					error = $temp$error;
					context = $temp$context;
					continue errorToStringHelp;
				case 'OneOf':
					var errors = error.a;
					if (!errors.b) {
						return 'Ran into a Json.Decode.oneOf with no possibilities' + function () {
							if (!context.b) {
								return '!';
							} else {
								return ' at json' + A2(
									$elm$core$String$join,
									'',
									$elm$core$List$reverse(context));
							}
						}();
					} else {
						if (!errors.b.b) {
							var err = errors.a;
							var $temp$error = err,
								$temp$context = context;
							error = $temp$error;
							context = $temp$context;
							continue errorToStringHelp;
						} else {
							var starter = function () {
								if (!context.b) {
									return 'Json.Decode.oneOf';
								} else {
									return 'The Json.Decode.oneOf at json' + A2(
										$elm$core$String$join,
										'',
										$elm$core$List$reverse(context));
								}
							}();
							var introduction = starter + (' failed in the following ' + ($elm$core$String$fromInt(
								$elm$core$List$length(errors)) + ' ways:'));
							return A2(
								$elm$core$String$join,
								'\n\n',
								A2(
									$elm$core$List$cons,
									introduction,
									A2($elm$core$List$indexedMap, $elm$json$Json$Decode$errorOneOf, errors)));
						}
					}
				default:
					var msg = error.a;
					var json = error.b;
					var introduction = function () {
						if (!context.b) {
							return 'Problem with the given value:\n\n';
						} else {
							return 'Problem with the value at json' + (A2(
								$elm$core$String$join,
								'',
								$elm$core$List$reverse(context)) + ':\n\n    ');
						}
					}();
					return introduction + ($elm$json$Json$Decode$indent(
						A2($elm$json$Json$Encode$encode, 4, json)) + ('\n\n' + msg));
			}
		}
	});
var $elm$core$Array$branchFactor = 32;
var $elm$core$Array$Array_elm_builtin = F4(
	function (a, b, c, d) {
		return {$: 'Array_elm_builtin', a: a, b: b, c: c, d: d};
	});
var $elm$core$Elm$JsArray$empty = _JsArray_empty;
var $elm$core$Basics$ceiling = _Basics_ceiling;
var $elm$core$Basics$fdiv = _Basics_fdiv;
var $elm$core$Basics$logBase = F2(
	function (base, number) {
		return _Basics_log(number) / _Basics_log(base);
	});
var $elm$core$Basics$toFloat = _Basics_toFloat;
var $elm$core$Array$shiftStep = $elm$core$Basics$ceiling(
	A2($elm$core$Basics$logBase, 2, $elm$core$Array$branchFactor));
var $elm$core$Array$empty = A4($elm$core$Array$Array_elm_builtin, 0, $elm$core$Array$shiftStep, $elm$core$Elm$JsArray$empty, $elm$core$Elm$JsArray$empty);
var $elm$core$Elm$JsArray$initialize = _JsArray_initialize;
var $elm$core$Array$Leaf = function (a) {
	return {$: 'Leaf', a: a};
};
var $elm$core$Basics$apL = F2(
	function (f, x) {
		return f(x);
	});
var $elm$core$Basics$apR = F2(
	function (x, f) {
		return f(x);
	});
var $elm$core$Basics$eq = _Utils_equal;
var $elm$core$Basics$floor = _Basics_floor;
var $elm$core$Elm$JsArray$length = _JsArray_length;
var $elm$core$Basics$gt = _Utils_gt;
var $elm$core$Basics$max = F2(
	function (x, y) {
		return (_Utils_cmp(x, y) > 0) ? x : y;
	});
var $elm$core$Basics$mul = _Basics_mul;
var $elm$core$Array$SubTree = function (a) {
	return {$: 'SubTree', a: a};
};
var $elm$core$Elm$JsArray$initializeFromList = _JsArray_initializeFromList;
var $elm$core$Array$compressNodes = F2(
	function (nodes, acc) {
		compressNodes:
		while (true) {
			var _v0 = A2($elm$core$Elm$JsArray$initializeFromList, $elm$core$Array$branchFactor, nodes);
			var node = _v0.a;
			var remainingNodes = _v0.b;
			var newAcc = A2(
				$elm$core$List$cons,
				$elm$core$Array$SubTree(node),
				acc);
			if (!remainingNodes.b) {
				return $elm$core$List$reverse(newAcc);
			} else {
				var $temp$nodes = remainingNodes,
					$temp$acc = newAcc;
				nodes = $temp$nodes;
				acc = $temp$acc;
				continue compressNodes;
			}
		}
	});
var $elm$core$Tuple$first = function (_v0) {
	var x = _v0.a;
	return x;
};
var $elm$core$Array$treeFromBuilder = F2(
	function (nodeList, nodeListSize) {
		treeFromBuilder:
		while (true) {
			var newNodeSize = $elm$core$Basics$ceiling(nodeListSize / $elm$core$Array$branchFactor);
			if (newNodeSize === 1) {
				return A2($elm$core$Elm$JsArray$initializeFromList, $elm$core$Array$branchFactor, nodeList).a;
			} else {
				var $temp$nodeList = A2($elm$core$Array$compressNodes, nodeList, _List_Nil),
					$temp$nodeListSize = newNodeSize;
				nodeList = $temp$nodeList;
				nodeListSize = $temp$nodeListSize;
				continue treeFromBuilder;
			}
		}
	});
var $elm$core$Array$builderToArray = F2(
	function (reverseNodeList, builder) {
		if (!builder.nodeListSize) {
			return A4(
				$elm$core$Array$Array_elm_builtin,
				$elm$core$Elm$JsArray$length(builder.tail),
				$elm$core$Array$shiftStep,
				$elm$core$Elm$JsArray$empty,
				builder.tail);
		} else {
			var treeLen = builder.nodeListSize * $elm$core$Array$branchFactor;
			var depth = $elm$core$Basics$floor(
				A2($elm$core$Basics$logBase, $elm$core$Array$branchFactor, treeLen - 1));
			var correctNodeList = reverseNodeList ? $elm$core$List$reverse(builder.nodeList) : builder.nodeList;
			var tree = A2($elm$core$Array$treeFromBuilder, correctNodeList, builder.nodeListSize);
			return A4(
				$elm$core$Array$Array_elm_builtin,
				$elm$core$Elm$JsArray$length(builder.tail) + treeLen,
				A2($elm$core$Basics$max, 5, depth * $elm$core$Array$shiftStep),
				tree,
				builder.tail);
		}
	});
var $elm$core$Basics$idiv = _Basics_idiv;
var $elm$core$Basics$lt = _Utils_lt;
var $elm$core$Array$initializeHelp = F5(
	function (fn, fromIndex, len, nodeList, tail) {
		initializeHelp:
		while (true) {
			if (fromIndex < 0) {
				return A2(
					$elm$core$Array$builderToArray,
					false,
					{nodeList: nodeList, nodeListSize: (len / $elm$core$Array$branchFactor) | 0, tail: tail});
			} else {
				var leaf = $elm$core$Array$Leaf(
					A3($elm$core$Elm$JsArray$initialize, $elm$core$Array$branchFactor, fromIndex, fn));
				var $temp$fn = fn,
					$temp$fromIndex = fromIndex - $elm$core$Array$branchFactor,
					$temp$len = len,
					$temp$nodeList = A2($elm$core$List$cons, leaf, nodeList),
					$temp$tail = tail;
				fn = $temp$fn;
				fromIndex = $temp$fromIndex;
				len = $temp$len;
				nodeList = $temp$nodeList;
				tail = $temp$tail;
				continue initializeHelp;
			}
		}
	});
var $elm$core$Basics$remainderBy = _Basics_remainderBy;
var $elm$core$Array$initialize = F2(
	function (len, fn) {
		if (len <= 0) {
			return $elm$core$Array$empty;
		} else {
			var tailLen = len % $elm$core$Array$branchFactor;
			var tail = A3($elm$core$Elm$JsArray$initialize, tailLen, len - tailLen, fn);
			var initialFromIndex = (len - tailLen) - $elm$core$Array$branchFactor;
			return A5($elm$core$Array$initializeHelp, fn, initialFromIndex, len, _List_Nil, tail);
		}
	});
var $elm$core$Basics$True = {$: 'True'};
var $elm$core$Result$isOk = function (result) {
	if (result.$ === 'Ok') {
		return true;
	} else {
		return false;
	}
};
var $elm$json$Json$Encode$object = function (pairs) {
	return _Json_wrap(
		A3(
			$elm$core$List$foldl,
			F2(
				function (_v0, obj) {
					var k = _v0.a;
					var v = _v0.b;
					return A3(_Json_addField, k, v, obj);
				}),
			_Json_emptyObject(_Utils_Tuple0),
			pairs));
};
var $author$project$VegaLite$combineSpecs = function (specs) {
	return $elm$json$Json$Encode$object(specs);
};
var $author$project$VegaLite$X = {$: 'X'};
var $author$project$VegaLite$Y = {$: 'Y'};
var $elm$core$List$foldrHelper = F4(
	function (fn, acc, ctr, ls) {
		if (!ls.b) {
			return acc;
		} else {
			var a = ls.a;
			var r1 = ls.b;
			if (!r1.b) {
				return A2(fn, a, acc);
			} else {
				var b = r1.a;
				var r2 = r1.b;
				if (!r2.b) {
					return A2(
						fn,
						a,
						A2(fn, b, acc));
				} else {
					var c = r2.a;
					var r3 = r2.b;
					if (!r3.b) {
						return A2(
							fn,
							a,
							A2(
								fn,
								b,
								A2(fn, c, acc)));
					} else {
						var d = r3.a;
						var r4 = r3.b;
						var res = (ctr > 500) ? A3(
							$elm$core$List$foldl,
							fn,
							acc,
							$elm$core$List$reverse(r4)) : A4($elm$core$List$foldrHelper, fn, acc, ctr + 1, r4);
						return A2(
							fn,
							a,
							A2(
								fn,
								b,
								A2(
									fn,
									c,
									A2(fn, d, res))));
					}
				}
			}
		}
	});
var $elm$core$List$foldr = F3(
	function (fn, acc, ls) {
		return A4($elm$core$List$foldrHelper, fn, acc, 0, ls);
	});
var $elm$core$List$map = F2(
	function (f, xs) {
		return A3(
			$elm$core$List$foldr,
			F2(
				function (x, acc) {
					return A2(
						$elm$core$List$cons,
						f(x),
						acc);
				}),
			_List_Nil,
			xs);
	});
var $author$project$VegaLite$vlPropertyLabel = function (spec) {
	switch (spec.$) {
		case 'VLName':
			return 'name';
		case 'VLParams':
			return 'params';
		case 'VLDescription':
			return 'description';
		case 'VLTitle':
			return 'title';
		case 'VLWidth':
			return 'width';
		case 'VLWidthStep':
			return 'width';
		case 'VLHeight':
			return 'height';
		case 'VLHeightStep':
			return 'height';
		case 'VLPadding':
			return 'padding';
		case 'VLAutosize':
			return 'autosize';
		case 'VLBackground':
			return 'background';
		case 'VLBackgroundExpr':
			return 'background';
		case 'VLData':
			return 'data';
		case 'VLDatasets':
			return 'datasets';
		case 'VLProjection':
			return 'projection';
		case 'VLMark':
			return 'mark';
		case 'VLTransform':
			return 'transform';
		case 'VLEncoding':
			return 'encoding';
		case 'VLConfig':
			return 'config';
		case 'VLSelection':
			return 'selection';
		case 'VLConcat':
			return 'concat';
		case 'VLColumns':
			return 'columns';
		case 'VLHConcat':
			return 'hconcat';
		case 'VLVConcat':
			return 'vconcat';
		case 'VLLayer':
			return 'layer';
		case 'VLRepeat':
			return 'repeat';
		case 'VLFacet':
			return 'facet';
		case 'VLSpacing':
			return 'spacing';
		case 'VLAlign':
			return 'align';
		case 'VLBounds':
			return 'bounds';
		case 'VLCenter':
			return 'center';
		case 'VLSpec':
			return 'spec';
		case 'VLResolve':
			return 'resolve';
		default:
			return 'view';
	}
};
var $author$project$VegaLite$asSpec = function (specs) {
	return $elm$json$Json$Encode$object(
		A2(
			$elm$core$List$map,
			function (_v0) {
				var s = _v0.a;
				var v = _v0.b;
				return _Utils_Tuple2(
					$author$project$VegaLite$vlPropertyLabel(s),
					v);
			},
			specs));
};
var $author$project$VegaLite$Bar = {$: 'Bar'};
var $author$project$VegaLite$VLMark = {$: 'VLMark'};
var $elm$core$List$append = F2(
	function (xs, ys) {
		if (!ys.b) {
			return xs;
		} else {
			return A3($elm$core$List$foldr, $elm$core$List$cons, ys, xs);
		}
	});
var $elm$core$List$concat = function (lists) {
	return A3($elm$core$List$foldr, $elm$core$List$append, _List_Nil, lists);
};
var $elm$core$List$concatMap = F2(
	function (f, list) {
		return $elm$core$List$concat(
			A2($elm$core$List$map, f, list));
	});
var $author$project$VegaLite$markLabel = function (m) {
	switch (m.$) {
		case 'Arc':
			return 'arc';
		case 'Area':
			return 'area';
		case 'Bar':
			return 'bar';
		case 'Boxplot':
			return 'boxplot';
		case 'Circle':
			return 'circle';
		case 'Errorband':
			return 'errorband';
		case 'Errorbar':
			return 'errorbar';
		case 'Image':
			return 'image';
		case 'Line':
			return 'line';
		case 'Geoshape':
			return 'geoshape';
		case 'Point':
			return 'point';
		case 'Rect':
			return 'rect';
		case 'Rule':
			return 'rule';
		case 'Square':
			return 'square';
		case 'Text':
			return 'text';
		case 'Tick':
			return 'tick';
		default:
			return 'trail';
	}
};
var $author$project$VegaLite$ArAria = function (a) {
	return {$: 'ArAria', a: a};
};
var $author$project$VegaLite$TTNone = {$: 'TTNone'};
var $elm$json$Json$Encode$bool = _Json_wrap;
var $elm$json$Json$Encode$string = _Json_wrap;
var $author$project$VegaLite$ariaProperty = function (arProp) {
	if (arProp.$ === 'ArAria') {
		var b = arProp.a;
		return _Utils_Tuple2(
			'aria',
			$elm$json$Json$Encode$bool(b));
	} else {
		var d = arProp.a;
		return _Utils_Tuple2(
			'description',
			$elm$json$Json$Encode$string(d));
	}
};
var $elm$json$Json$Encode$null = _Json_encodeNull;
var $author$project$VegaLite$blendModeSpec = function (bm) {
	switch (bm.$) {
		case 'BMNormal':
			return $elm$json$Json$Encode$null;
		case 'BMMultiply':
			return $elm$json$Json$Encode$string('multiply');
		case 'BMScreen':
			return $elm$json$Json$Encode$string('screen');
		case 'BMOverlay':
			return $elm$json$Json$Encode$string('overlay');
		case 'BMDarken':
			return $elm$json$Json$Encode$string('darken');
		case 'BMLighten':
			return $elm$json$Json$Encode$string('lighten');
		case 'BMColorDodge':
			return $elm$json$Json$Encode$string('color-dodge');
		case 'BMColorBurn':
			return $elm$json$Json$Encode$string('color-burn');
		case 'BMHardLight':
			return $elm$json$Json$Encode$string('hard-light');
		case 'BMSoftLight':
			return $elm$json$Json$Encode$string('soft-light');
		case 'BMDifference':
			return $elm$json$Json$Encode$string('difference');
		case 'BMExclusion':
			return $elm$json$Json$Encode$string('exclusion');
		case 'BMHue':
			return $elm$json$Json$Encode$string('hue');
		case 'BMSaturation':
			return $elm$json$Json$Encode$string('saturation');
		case 'BMColor':
			return $elm$json$Json$Encode$string('color');
		case 'BMLuminosity':
			return $elm$json$Json$Encode$string('luminosity');
		default:
			var s = bm.a;
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'expr',
						$elm$json$Json$Encode$string(s))
					]));
	}
};
var $author$project$VegaLite$booExpr = F2(
	function (objName, n) {
		if (n.$ === 'Boo') {
			var b = n.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					objName,
					$elm$json$Json$Encode$bool(b))
				]);
		} else {
			var s = n.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					objName,
					$elm$json$Json$Encode$object(
						_List_fromArray(
							[
								_Utils_Tuple2(
								'expr',
								$elm$json$Json$Encode$string(s))
							])))
				]);
		}
	});
var $author$project$VegaLite$colorGradientLabel = function (gr) {
	if (gr.$ === 'GrLinear') {
		return 'linear';
	} else {
		return 'radial';
	}
};
var $author$project$VegaLite$cursorSpec = function (cur) {
	switch (cur.$) {
		case 'CAuto':
			return $elm$json$Json$Encode$string('auto');
		case 'CDefault':
			return $elm$json$Json$Encode$string('default');
		case 'CNone':
			return $elm$json$Json$Encode$string('none');
		case 'CContextMenu':
			return $elm$json$Json$Encode$string('context-menu');
		case 'CHelp':
			return $elm$json$Json$Encode$string('help');
		case 'CPointer':
			return $elm$json$Json$Encode$string('pointer');
		case 'CProgress':
			return $elm$json$Json$Encode$string('progress');
		case 'CWait':
			return $elm$json$Json$Encode$string('wait');
		case 'CCell':
			return $elm$json$Json$Encode$string('cell');
		case 'CCrosshair':
			return $elm$json$Json$Encode$string('crosshair');
		case 'CText':
			return $elm$json$Json$Encode$string('text');
		case 'CVerticalText':
			return $elm$json$Json$Encode$string('vertical-text');
		case 'CAlias':
			return $elm$json$Json$Encode$string('alias');
		case 'CCopy':
			return $elm$json$Json$Encode$string('copy');
		case 'CMove':
			return $elm$json$Json$Encode$string('move');
		case 'CNoDrop':
			return $elm$json$Json$Encode$string('no-drop');
		case 'CNotAllowed':
			return $elm$json$Json$Encode$string('not-allowed');
		case 'CAllScroll':
			return $elm$json$Json$Encode$string('all-scroll');
		case 'CColResize':
			return $elm$json$Json$Encode$string('col-resize');
		case 'CRowResize':
			return $elm$json$Json$Encode$string('row-resize');
		case 'CNResize':
			return $elm$json$Json$Encode$string('n-resize');
		case 'CEResize':
			return $elm$json$Json$Encode$string('e-resize');
		case 'CSResize':
			return $elm$json$Json$Encode$string('s-resize');
		case 'CWResize':
			return $elm$json$Json$Encode$string('w-resize');
		case 'CNEResize':
			return $elm$json$Json$Encode$string('ne-resize');
		case 'CNWResize':
			return $elm$json$Json$Encode$string('nw-resize');
		case 'CSEResize':
			return $elm$json$Json$Encode$string('se-resize');
		case 'CSWResize':
			return $elm$json$Json$Encode$string('sw-resize');
		case 'CEWResize':
			return $elm$json$Json$Encode$string('ew-resize');
		case 'CNSResize':
			return $elm$json$Json$Encode$string('ns-resize');
		case 'CNESWResize':
			return $elm$json$Json$Encode$string('nesw-resize');
		case 'CNWSEResize':
			return $elm$json$Json$Encode$string('nwse-resize');
		case 'CZoomIn':
			return $elm$json$Json$Encode$string('zoom-in');
		case 'CZoomOut':
			return $elm$json$Json$Encode$string('zoom-out');
		case 'CGrab':
			return $elm$json$Json$Encode$string('grab');
		case 'CGrabbing':
			return $elm$json$Json$Encode$string('grabbing');
		default:
			var s = cur.a;
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'expr',
						$elm$json$Json$Encode$string(s))
					]));
	}
};
var $elm$json$Json$Encode$float = _Json_wrap;
var $author$project$VegaLite$extentSpec = function (ext) {
	switch (ext.$) {
		case 'ExCI':
			return $elm$json$Json$Encode$string('ci');
		case 'ExStderr':
			return $elm$json$Json$Encode$string('stderr');
		case 'ExStdev':
			return $elm$json$Json$Encode$string('stdev');
		case 'ExIqr':
			return $elm$json$Json$Encode$string('iqr');
		case 'ExRange':
			return $elm$json$Json$Encode$string('min-max');
		default:
			var sc = ext.a;
			return $elm$json$Json$Encode$float(sc);
	}
};
var $author$project$VegaLite$fontWeightSpec = function (w) {
	switch (w.$) {
		case 'Normal':
			return $elm$json$Json$Encode$string('normal');
		case 'Bold':
			return $elm$json$Json$Encode$string('bold');
		case 'Bolder':
			return $elm$json$Json$Encode$string('bolder');
		case 'Lighter':
			return $elm$json$Json$Encode$string('lighter');
		case 'FWExpr':
			var s = w.a;
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'expr',
						$elm$json$Json$Encode$string(s))
					]));
		case 'W100':
			return $elm$json$Json$Encode$float(100);
		case 'W200':
			return $elm$json$Json$Encode$float(200);
		case 'W300':
			return $elm$json$Json$Encode$float(300);
		case 'W400':
			return $elm$json$Json$Encode$float(400);
		case 'W500':
			return $elm$json$Json$Encode$float(500);
		case 'W600':
			return $elm$json$Json$Encode$float(600);
		case 'W700':
			return $elm$json$Json$Encode$float(700);
		case 'W800':
			return $elm$json$Json$Encode$float(800);
		default:
			return $elm$json$Json$Encode$float(900);
	}
};
var $elm$json$Json$Encode$list = F2(
	function (func, entries) {
		return _Json_wrap(
			A3(
				$elm$core$List$foldl,
				_Json_addEntry(func),
				_Json_emptyArray(_Utils_Tuple0),
				entries));
	});
var $author$project$VegaLite$stopSpec = function (_v0) {
	var x = _v0.a;
	var c = _v0.b;
	return $elm$json$Json$Encode$object(
		_List_fromArray(
			[
				_Utils_Tuple2(
				'offset',
				$elm$json$Json$Encode$float(x)),
				_Utils_Tuple2(
				'color',
				$elm$json$Json$Encode$string(c))
			]));
};
var $author$project$VegaLite$gradientProperty = function (gp) {
	switch (gp.$) {
		case 'GrX1':
			var x = gp.a;
			return _Utils_Tuple2(
				'x1',
				$elm$json$Json$Encode$float(x));
		case 'GrY1':
			var x = gp.a;
			return _Utils_Tuple2(
				'y1',
				$elm$json$Json$Encode$float(x));
		case 'GrX2':
			var x = gp.a;
			return _Utils_Tuple2(
				'x2',
				$elm$json$Json$Encode$float(x));
		case 'GrY2':
			var x = gp.a;
			return _Utils_Tuple2(
				'y2',
				$elm$json$Json$Encode$float(x));
		case 'GrR1':
			var x = gp.a;
			return _Utils_Tuple2(
				'r1',
				$elm$json$Json$Encode$float(x));
		case 'GrR2':
			var x = gp.a;
			return _Utils_Tuple2(
				'r2',
				$elm$json$Json$Encode$float(x));
		default:
			var grs = gp.a;
			return _Utils_Tuple2(
				'stops',
				A2($elm$json$Json$Encode$list, $author$project$VegaLite$stopSpec, grs));
	}
};
var $author$project$VegaLite$hAlignSpec = function (al) {
	switch (al.$) {
		case 'HAlignLeft':
			return $elm$json$Json$Encode$string('left');
		case 'HAlignCenter':
			return $elm$json$Json$Encode$string('center');
		case 'HAlignRight':
			return $elm$json$Json$Encode$string('right');
		default:
			var s = al.a;
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'expr',
						$elm$json$Json$Encode$string(s))
					]));
	}
};
var $author$project$VegaLite$markInterpolationSpec = function (interp) {
	switch (interp.$) {
		case 'Linear':
			return $elm$json$Json$Encode$string('linear');
		case 'LinearClosed':
			return $elm$json$Json$Encode$string('linear-closed');
		case 'Stepwise':
			return $elm$json$Json$Encode$string('step');
		case 'StepBefore':
			return $elm$json$Json$Encode$string('step-before');
		case 'StepAfter':
			return $elm$json$Json$Encode$string('step-after');
		case 'Basis':
			return $elm$json$Json$Encode$string('basis');
		case 'BasisOpen':
			return $elm$json$Json$Encode$string('basis-open');
		case 'BasisClosed':
			return $elm$json$Json$Encode$string('basis-closed');
		case 'Cardinal':
			return $elm$json$Json$Encode$string('cardinal');
		case 'CardinalOpen':
			return $elm$json$Json$Encode$string('cardinal-open');
		case 'CardinalClosed':
			return $elm$json$Json$Encode$string('cardinal-closed');
		case 'Bundle':
			return $elm$json$Json$Encode$string('bundle');
		case 'Monotone':
			return $elm$json$Json$Encode$string('monotone');
		default:
			var s = interp.a;
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'expr',
						$elm$json$Json$Encode$string(s))
					]));
	}
};
var $author$project$VegaLite$markOrientationLabel = function (orient) {
	if (orient.$ === 'MOHorizontal') {
		return 'horizontal';
	} else {
		return 'vertical';
	}
};
var $author$project$VegaLite$numExpr = F2(
	function (objName, n) {
		if (n.$ === 'Num') {
			var x = n.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					objName,
					$elm$json$Json$Encode$float(x))
				]);
		} else {
			var s = n.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					objName,
					$elm$json$Json$Encode$object(
						_List_fromArray(
							[
								_Utils_Tuple2(
								'expr',
								$elm$json$Json$Encode$string(s))
							])))
				]);
		}
	});
var $author$project$VegaLite$strExpr = F2(
	function (objName, s) {
		if (s.$ === 'Str') {
			var x = s.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					objName,
					$elm$json$Json$Encode$string(x))
				]);
		} else {
			var x = s.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					objName,
					$elm$json$Json$Encode$object(
						_List_fromArray(
							[
								_Utils_Tuple2(
								'expr',
								$elm$json$Json$Encode$string(x))
							])))
				]);
		}
	});
var $author$project$VegaLite$multilineTextSpec = function (tText) {
	var _v0 = A2($elm$core$String$split, '\n', tText);
	if (!_v0.b) {
		return $elm$json$Json$Encode$string('');
	} else {
		if (!_v0.b.b) {
			var s = _v0.a;
			return $elm$json$Json$Encode$string(s);
		} else {
			var ss = _v0;
			return A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$string, ss);
		}
	}
};
var $author$project$VegaLite$strExprMultiline = F2(
	function (objName, s) {
		if (s.$ === 'Str') {
			var x = s.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					objName,
					$author$project$VegaLite$multilineTextSpec(x))
				]);
		} else {
			var x = s.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					objName,
					$elm$json$Json$Encode$object(
						_List_fromArray(
							[
								_Utils_Tuple2(
								'expr',
								$elm$json$Json$Encode$string(x))
							])))
				]);
		}
	});
var $author$project$VegaLite$strokeCapSpec = function (cap) {
	switch (cap.$) {
		case 'CButt':
			return $elm$json$Json$Encode$string('butt');
		case 'CRound':
			return $elm$json$Json$Encode$string('round');
		case 'CSquare':
			return $elm$json$Json$Encode$string('square');
		default:
			var s = cap.a;
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'expr',
						$elm$json$Json$Encode$string(s))
					]));
	}
};
var $author$project$VegaLite$strokeJoinSpec = function (jn) {
	switch (jn.$) {
		case 'JMiter':
			return $elm$json$Json$Encode$string('miter');
		case 'JRound':
			return $elm$json$Json$Encode$string('round');
		case 'JBevel':
			return $elm$json$Json$Encode$string('bevel');
		default:
			var s = jn.a;
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'expr',
						$elm$json$Json$Encode$string(s))
					]));
	}
};
var $author$project$VegaLite$symbolLabel = function (sym) {
	switch (sym.$) {
		case 'SymCircle':
			return 'circle';
		case 'SymSquare':
			return 'square';
		case 'SymCross':
			return 'cross';
		case 'SymDiamond':
			return 'diamond';
		case 'SymTriangleUp':
			return 'triangle-up';
		case 'SymTriangleDown':
			return 'triangle-down';
		case 'SymTriangleLeft':
			return 'triangle-left';
		case 'SymTriangleRight':
			return 'triangle-right';
		case 'SymTriangle':
			return 'triangle';
		case 'SymStroke':
			return 'stroke';
		case 'SymArrow':
			return 'arrow';
		case 'SymWedge':
			return 'wedge';
		case 'SymPath':
			var svgPath = sym.a;
			return svgPath;
		default:
			var s = sym.a;
			return s;
	}
};
var $author$project$VegaLite$symbolSpec = function (sym) {
	if (sym.$ === 'SymExpr') {
		var s = sym.a;
		return $elm$json$Json$Encode$object(
			_List_fromArray(
				[
					_Utils_Tuple2(
					'expr',
					$elm$json$Json$Encode$string(s))
				]));
	} else {
		return $elm$json$Json$Encode$string(
			$author$project$VegaLite$symbolLabel(sym));
	}
};
var $author$project$VegaLite$textDirectionSpec = function (td) {
	switch (td.$) {
		case 'LeftToRight':
			return $elm$json$Json$Encode$string('ltr');
		case 'RightToLeft':
			return $elm$json$Json$Encode$string('rtl');
		default:
			var s = td.a;
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'expr',
						$elm$json$Json$Encode$string(s))
					]));
	}
};
var $elm$core$String$trim = _String_trim;
var $author$project$VegaLite$ttContentSpec = function (ttContent) {
	switch (ttContent.$) {
		case 'TTEncoding':
			return $elm$json$Json$Encode$string('encoding');
		case 'TTData':
			return $elm$json$Json$Encode$string('data');
		default:
			return $elm$json$Json$Encode$string('null');
	}
};
var $author$project$VegaLite$vAlignSpec = function (al) {
	switch (al.$) {
		case 'VAlignTop':
			return $elm$json$Json$Encode$string('top');
		case 'VAlignLineTop':
			return $elm$json$Json$Encode$string('line-top');
		case 'VAlignMiddle':
			return $elm$json$Json$Encode$string('middle');
		case 'VAlignBottom':
			return $elm$json$Json$Encode$string('bottom');
		case 'VAlignLineBottom':
			return $elm$json$Json$Encode$string('line-bottom');
		case 'VAlignAlphabetic':
			return $elm$json$Json$Encode$string('alphabetic');
		default:
			var s = al.a;
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'expr',
						$elm$json$Json$Encode$string(s))
					]));
	}
};
var $author$project$VegaLite$lineMarkerSpec = function (pm) {
	if (pm.$ === 'LMNone') {
		return $elm$json$Json$Encode$bool(false);
	} else {
		var mps = pm.a;
		return $elm$json$Json$Encode$object(
			A2($elm$core$List$concatMap, $author$project$VegaLite$markProperty, mps));
	}
};
var $author$project$VegaLite$markProperty = function (mProp) {
	switch (mProp.$) {
		case 'MAria':
			var aps = mProp.a;
			if (!aps.b) {
				return _List_fromArray(
					[
						$author$project$VegaLite$ariaProperty(
						$author$project$VegaLite$ArAria(false))
					]);
			} else {
				return A2($elm$core$List$map, $author$project$VegaLite$ariaProperty, aps);
			}
		case 'MFilled':
			var b = mProp.a;
			return A2($author$project$VegaLite$booExpr, 'filled', b);
		case 'MBlend':
			var bm = mProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'blend',
					$author$project$VegaLite$blendModeSpec(bm))
				]);
		case 'MClip':
			var b = mProp.a;
			return A2($author$project$VegaLite$booExpr, 'clip', b);
		case 'MColor':
			var s = mProp.a;
			if (s.$ === 'Str') {
				var clr = s.a;
				return ($elm$core$String$trim(clr) === '') ? _List_fromArray(
					[
						_Utils_Tuple2('color', $elm$json$Json$Encode$null)
					]) : A2($author$project$VegaLite$strExpr, 'color', s);
			} else {
				return A2($author$project$VegaLite$strExpr, 'color', s);
			}
		case 'MCornerRadius':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'cornerRadius', n);
		case 'MCornerRadiusEnd':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'cornerRadiusEnd', n);
		case 'MCornerRadiusBL':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'cornerRadiusBottomLeft', n);
		case 'MCornerRadiusBR':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'cornerRadiusBottomRight', n);
		case 'MCornerRadiusTL':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'cornerRadiusTopLeft', n);
		case 'MCornerRadiusTR':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'cornerRadiusTopRight', n);
		case 'MCursor':
			var cur = mProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'cursor',
					$author$project$VegaLite$cursorSpec(cur))
				]);
		case 'MExtent':
			var ext = mProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'extent',
					$author$project$VegaLite$extentSpec(ext))
				]);
		case 'MHRef':
			var s = mProp.a;
			return A2($author$project$VegaLite$strExpr, 'href', s);
		case 'MRemoveInvalid':
			var bl = mProp.a;
			if (bl.$ === 'Boo') {
				var b = bl.a;
				return b ? _List_fromArray(
					[
						_Utils_Tuple2(
						'invalid',
						$elm$json$Json$Encode$string('filter'))
					]) : _List_fromArray(
					[
						_Utils_Tuple2('invalid', $elm$json$Json$Encode$null)
					]);
			} else {
				return A2($author$project$VegaLite$booExpr, 'invalid', bl);
			}
		case 'MFill':
			var s = mProp.a;
			if (s.$ === 'Str') {
				var clr = s.a;
				return ($elm$core$String$trim(clr) === '') ? _List_fromArray(
					[
						_Utils_Tuple2('fill', $elm$json$Json$Encode$null)
					]) : A2($author$project$VegaLite$strExpr, 'fill', s);
			} else {
				return A2($author$project$VegaLite$strExpr, 'fill', s);
			}
		case 'MFillGradient':
			var cGrad = mProp.a;
			var props = mProp.b;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'fill',
					$elm$json$Json$Encode$object(
						A2(
							$elm$core$List$cons,
							_Utils_Tuple2(
								'gradient',
								$elm$json$Json$Encode$string(
									$author$project$VegaLite$colorGradientLabel(cGrad))),
							A2($elm$core$List$map, $author$project$VegaLite$gradientProperty, props))))
				]);
		case 'MColorGradient':
			var cGrad = mProp.a;
			var props = mProp.b;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'color',
					$elm$json$Json$Encode$object(
						A2(
							$elm$core$List$cons,
							_Utils_Tuple2(
								'gradient',
								$elm$json$Json$Encode$string(
									$author$project$VegaLite$colorGradientLabel(cGrad))),
							A2($elm$core$List$map, $author$project$VegaLite$gradientProperty, props))))
				]);
		case 'MStrokeGradient':
			var cGrad = mProp.a;
			var props = mProp.b;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'stroke',
					$elm$json$Json$Encode$object(
						A2(
							$elm$core$List$cons,
							_Utils_Tuple2(
								'gradient',
								$elm$json$Json$Encode$string(
									$author$project$VegaLite$colorGradientLabel(cGrad))),
							A2($elm$core$List$map, $author$project$VegaLite$gradientProperty, props))))
				]);
		case 'MStroke':
			var s = mProp.a;
			if (s.$ === 'Str') {
				var clr = s.a;
				return ($elm$core$String$trim(clr) === '') ? _List_fromArray(
					[
						_Utils_Tuple2('stroke', $elm$json$Json$Encode$null)
					]) : A2($author$project$VegaLite$strExpr, 'stroke', s);
			} else {
				return A2($author$project$VegaLite$strExpr, 'stroke', s);
			}
		case 'MStrokeCap':
			var sc = mProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'strokeCap',
					$author$project$VegaLite$strokeCapSpec(sc))
				]);
		case 'MStrokeJoin':
			var sj = mProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'strokeJoin',
					$author$project$VegaLite$strokeJoinSpec(sj))
				]);
		case 'MStrokeMiterLimit':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'strokeMiterLimit', n);
		case 'MOpacity':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'opacity', n);
		case 'MFillOpacity':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'fillOpacity', n);
		case 'MStrokeOpacity':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'strokeOpacity', n);
		case 'MStrokeWidth':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'strokeWidth', n);
		case 'MStrokeDash':
			var xs = mProp.a;
			return _Utils_eq(xs, _List_Nil) ? _List_fromArray(
				[
					_Utils_Tuple2('strokeDash', $elm$json$Json$Encode$null)
				]) : _List_fromArray(
				[
					_Utils_Tuple2(
					'strokeDash',
					A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$float, xs))
				]);
		case 'MStrokeDashOffset':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'strokeDashOffset', n);
		case 'MStyle':
			var styles = mProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'style',
					A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$string, styles))
				]);
		case 'MInterpolate':
			var interp = mProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'interpolate',
					$author$project$VegaLite$markInterpolationSpec(interp))
				]);
		case 'MTension':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'tension', n);
		case 'MOrient':
			var orient = mProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'orient',
					$elm$json$Json$Encode$string(
						$author$project$VegaLite$markOrientationLabel(orient)))
				]);
		case 'MShape':
			var sym = mProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'shape',
					$author$project$VegaLite$symbolSpec(sym))
				]);
		case 'MSize':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'size', n);
		case 'MAngle':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'angle', n);
		case 'MAlign':
			var al = mProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'align',
					$author$project$VegaLite$hAlignSpec(al))
				]);
		case 'MBaseline':
			var va = mProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'baseline',
					$author$project$VegaLite$vAlignSpec(va))
				]);
		case 'MdX':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'dx', n);
		case 'MdY':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'dy', n);
		case 'MFont':
			var s = mProp.a;
			return A2($author$project$VegaLite$strExpr, 'font', s);
		case 'MFontSize':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'fontSize', n);
		case 'MFontStyle':
			var s = mProp.a;
			return A2($author$project$VegaLite$strExpr, 'fontStyle', s);
		case 'MFontWeight':
			var w = mProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'fontWeight',
					$author$project$VegaLite$fontWeightSpec(w))
				]);
		case 'MRadius':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'radius', n);
		case 'MInnerRadius':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'innerRadius', n);
		case 'MOuterRadius':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'outerRadius', n);
		case 'MPadAngle':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'padAngle', n);
		case 'MText':
			var s = mProp.a;
			return A2($author$project$VegaLite$strExprMultiline, 'text', s);
		case 'MLineHeight':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'lineHeight', n);
		case 'MLimit':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'limit', n);
		case 'MEllipsis':
			var s = mProp.a;
			return A2($author$project$VegaLite$strExpr, 'ellipsis', s);
		case 'MDir':
			var td = mProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'dir',
					$author$project$VegaLite$textDirectionSpec(td))
				]);
		case 'MTheta':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'theta', n);
		case 'MTheta2':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'theta2', n);
		case 'MThetaOffset':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'thetaOffset', n);
		case 'MTheta2Offset':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'theta2Offset', n);
		case 'MBinSpacing':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'binSpacing', n);
		case 'MContinuousBandSize':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'continuousBandSize', n);
		case 'MDiscreteBandSize':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'discreteBandSize', n);
		case 'MShortTimeLabels':
			var b = mProp.a;
			return A2($author$project$VegaLite$booExpr, 'shortTimeLabels', b);
		case 'MBandSize':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'bandSize', n);
		case 'MThickness':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'thickness', n);
		case 'MRule':
			var props = mProp.a;
			if (!props.b) {
				return _List_fromArray(
					[
						_Utils_Tuple2(
						'rule',
						$elm$json$Json$Encode$bool(false))
					]);
			} else {
				return _List_fromArray(
					[
						_Utils_Tuple2(
						'rule',
						$elm$json$Json$Encode$object(
							A2($elm$core$List$concatMap, $author$project$VegaLite$markProperty, props)))
					]);
			}
		case 'MBorders':
			var props = mProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'borders',
					$elm$json$Json$Encode$object(
						A2($elm$core$List$concatMap, $author$project$VegaLite$markProperty, props)))
				]);
		case 'MMedian':
			var props = mProp.a;
			if (!props.b) {
				return _List_fromArray(
					[
						_Utils_Tuple2(
						'median',
						$elm$json$Json$Encode$bool(false))
					]);
			} else {
				return _List_fromArray(
					[
						_Utils_Tuple2(
						'median',
						$elm$json$Json$Encode$object(
							A2($elm$core$List$concatMap, $author$project$VegaLite$markProperty, props)))
					]);
			}
		case 'MBox':
			var props = mProp.a;
			if (!props.b) {
				return _List_fromArray(
					[
						_Utils_Tuple2(
						'box',
						$elm$json$Json$Encode$bool(false))
					]);
			} else {
				return _List_fromArray(
					[
						_Utils_Tuple2(
						'box',
						$elm$json$Json$Encode$object(
							A2($elm$core$List$concatMap, $author$project$VegaLite$markProperty, props)))
					]);
			}
		case 'MOutliers':
			var props = mProp.a;
			if (!props.b) {
				return _List_fromArray(
					[
						_Utils_Tuple2(
						'outliers',
						$elm$json$Json$Encode$bool(false))
					]);
			} else {
				return _List_fromArray(
					[
						_Utils_Tuple2(
						'outliers',
						$elm$json$Json$Encode$object(
							A2($elm$core$List$concatMap, $author$project$VegaLite$markProperty, props)))
					]);
			}
		case 'MTicks':
			var props = mProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'ticks',
					$elm$json$Json$Encode$object(
						A2($elm$core$List$concatMap, $author$project$VegaLite$markProperty, props)))
				]);
		case 'MTooltip':
			var ttContent = mProp.a;
			return _Utils_eq(ttContent, $author$project$VegaLite$TTNone) ? _List_fromArray(
				[
					_Utils_Tuple2('tooltip', $elm$json$Json$Encode$null)
				]) : _List_fromArray(
				[
					_Utils_Tuple2(
					'tooltip',
					$elm$json$Json$Encode$object(
						_List_fromArray(
							[
								_Utils_Tuple2(
								'content',
								$author$project$VegaLite$ttContentSpec(ttContent))
							])))
				]);
		case 'MPoint':
			var pm = mProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'point',
					$author$project$VegaLite$pointMarkerSpec(pm))
				]);
		case 'MLine':
			var lm = mProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'line',
					$author$project$VegaLite$lineMarkerSpec(lm))
				]);
		case 'MWidth':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'width', n);
		case 'MHeight':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'height', n);
		case 'MX':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'x', n);
		case 'MY':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'y', n);
		case 'MX2':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'x2', n);
		case 'MY2':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'y2', n);
		case 'MOrder':
			var b = mProp.a;
			return A2($author$project$VegaLite$booExpr, 'order', b);
		case 'MXOffset':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'xOffset', n);
		case 'MX2Offset':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'x2Offset', n);
		case 'MYOffset':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'yOffset', n);
		case 'MY2Offset':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'y2Offset', n);
		case 'MRadiusOffset':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'radiusOffset', n);
		case 'MRadius2Offset':
			var n = mProp.a;
			return A2($author$project$VegaLite$numExpr, 'radius2Offset', n);
		default:
			var b = mProp.a;
			return A2($author$project$VegaLite$booExpr, 'aspect', b);
	}
};
var $author$project$VegaLite$pointMarkerSpec = function (pm) {
	switch (pm.$) {
		case 'PMTransparent':
			return $elm$json$Json$Encode$string('transparent');
		case 'PMNone':
			return $elm$json$Json$Encode$bool(false);
		default:
			var mps = pm.a;
			return _Utils_eq(mps, _List_Nil) ? $elm$json$Json$Encode$bool(true) : $elm$json$Json$Encode$object(
				A2($elm$core$List$concatMap, $author$project$VegaLite$markProperty, mps));
	}
};
var $author$project$VegaLite$mark = F2(
	function (m, mProps) {
		if (!mProps.b) {
			return _Utils_Tuple2(
				$author$project$VegaLite$VLMark,
				$elm$json$Json$Encode$string(
					$author$project$VegaLite$markLabel(m)));
		} else {
			return _Utils_Tuple2(
				$author$project$VegaLite$VLMark,
				$elm$json$Json$Encode$object(
					A2(
						$elm$core$List$cons,
						_Utils_Tuple2(
							'type',
							$elm$json$Json$Encode$string(
								$author$project$VegaLite$markLabel(m))),
						A2($elm$core$List$concatMap, $author$project$VegaLite$markProperty, mProps))));
		}
	});
var $author$project$VegaLite$bar = $author$project$VegaLite$mark($author$project$VegaLite$Bar);
var $author$project$VegaLite$MarkStyles = function (a) {
	return {$: 'MarkStyles', a: a};
};
var $author$project$VegaLite$coMarkStyles = $author$project$VegaLite$MarkStyles;
var $elm$core$Basics$composeL = F3(
	function (g, f, x) {
		return g(
			f(x));
	});
var $author$project$VegaLite$autosizeProperty = function (asCfg) {
	switch (asCfg.$) {
		case 'APad':
			return _Utils_Tuple2(
				'type',
				$elm$json$Json$Encode$string('pad'));
		case 'AFit':
			return _Utils_Tuple2(
				'type',
				$elm$json$Json$Encode$string('fit'));
		case 'AFitX':
			return _Utils_Tuple2(
				'type',
				$elm$json$Json$Encode$string('fit-x'));
		case 'AFitY':
			return _Utils_Tuple2(
				'type',
				$elm$json$Json$Encode$string('fit-y'));
		case 'ANone':
			return _Utils_Tuple2(
				'type',
				$elm$json$Json$Encode$string('none'));
		case 'AResize':
			return _Utils_Tuple2(
				'resize',
				$elm$json$Json$Encode$bool(true));
		case 'AContent':
			return _Utils_Tuple2(
				'contains',
				$elm$json$Json$Encode$string('content'));
		default:
			return _Utils_Tuple2(
				'contains',
				$elm$json$Json$Encode$string('padding'));
	}
};
var $author$project$VegaLite$anchorSpec = function (an) {
	switch (an.$) {
		case 'AnStart':
			return $elm$json$Json$Encode$string('start');
		case 'AnMiddle':
			return $elm$json$Json$Encode$string('middle');
		case 'AnEnd':
			return $elm$json$Json$Encode$string('end');
		default:
			var s = an.a;
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'expr',
						$elm$json$Json$Encode$string(s))
					]));
	}
};
var $author$project$VegaLite$overlapStrategySpec = function (strat) {
	switch (strat.$) {
		case 'ONone':
			return $elm$json$Json$Encode$bool(false);
		case 'OParity':
			return $elm$json$Json$Encode$string('parity');
		default:
			return $elm$json$Json$Encode$string('greedy');
	}
};
var $elm$json$Json$Encode$int = _Json_wrap;
var $author$project$VegaLite$timeUnitLabel = function (tu) {
	switch (tu.$) {
		case 'Year':
			return 'year';
		case 'YearDayOfYear':
			return 'yeardayofyear';
		case 'YearQuarter':
			return 'yearquarter';
		case 'YearQuarterMonth':
			return 'yearquartermonth';
		case 'YearMonth':
			return 'yearmonth';
		case 'YearMonthDate':
			return 'yearmonthdate';
		case 'YearMonthDateHours':
			return 'yearmonthdatehours';
		case 'YearMonthDateHoursMinutes':
			return 'yearmonthdatehoursminutes';
		case 'YearMonthDateHoursMinutesSeconds':
			return 'yearmonthdatehoursminutesseconds';
		case 'YearWeek':
			return 'yearweek';
		case 'YearWeekDay':
			return 'yearweekday';
		case 'YearWeekDayHours':
			return 'yearweekdayhours';
		case 'YearWeekDayHoursMinutes':
			return 'yearweekdayhoursminutes';
		case 'YearWeekDayHoursMinutesSeconds':
			return 'yearweekdayhoursminutesseconds';
		case 'Quarter':
			return 'quarter';
		case 'QuarterMonth':
			return 'quartermonth';
		case 'Month':
			return 'month';
		case 'MonthDate':
			return 'monthdate';
		case 'MonthDateHours':
			return 'monthdatehours';
		case 'MonthDateHoursMinutes':
			return 'monthdatehoursminutes';
		case 'MonthDateHoursMinutesSeconds':
			return 'monthdatehoursminutesseconds';
		case 'Week':
			return 'week';
		case 'WeekDay':
			return 'weekday';
		case 'WeekDayHours':
			return 'weekdayhours';
		case 'WeekDayHoursMinutes':
			return 'weekdayhoursminutes';
		case 'WeekDayHoursMinutesSeconds':
			return 'weekdayhoursminutesseconds';
		case 'Date':
			return 'date';
		case 'Day':
			return 'day';
		case 'DayOfYear':
			return 'dayofyear';
		case 'DayHours':
			return 'dayhours';
		case 'DayHoursMinutes':
			return 'dayhoursminutes';
		case 'DayHoursMinutesSeconds':
			return 'dayhoursminutesseconds';
		case 'Hours':
			return 'hours';
		case 'HoursMinutes':
			return 'hoursminutes';
		case 'HoursMinutesSeconds':
			return 'hoursminutesseconds';
		case 'Minutes':
			return 'minutes';
		case 'MinutesSeconds':
			return 'minutesseconds';
		case 'Seconds':
			return 'seconds';
		case 'SecondsMilliseconds':
			return 'secondsmilliseconds';
		case 'Milliseconds':
			return 'milliseconds';
		case 'Utc':
			return '';
		case 'TUMaxBins':
			return '';
		default:
			return '';
	}
};
var $author$project$VegaLite$scaleNiceSpec = function (ni) {
	switch (ni.$) {
		case 'NMillisecond':
			return $elm$json$Json$Encode$string('millisecond');
		case 'NSecond':
			return $elm$json$Json$Encode$string('second');
		case 'NMinute':
			return $elm$json$Json$Encode$string('minute');
		case 'NHour':
			return $elm$json$Json$Encode$string('hour');
		case 'NDay':
			return $elm$json$Json$Encode$string('day');
		case 'NWeek':
			return $elm$json$Json$Encode$string('week');
		case 'NMonth':
			return $elm$json$Json$Encode$string('month');
		case 'NYear':
			return $elm$json$Json$Encode$string('year');
		case 'NInterval':
			var tu = ni.a;
			var step = ni.b;
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'interval',
						$elm$json$Json$Encode$string(
							$author$project$VegaLite$timeUnitLabel(tu))),
						_Utils_Tuple2(
						'step',
						$elm$json$Json$Encode$int(step))
					]));
		case 'NTrue':
			return $elm$json$Json$Encode$bool(true);
		case 'NFalse':
			return $elm$json$Json$Encode$bool(false);
		default:
			var n = ni.a;
			return $elm$json$Json$Encode$int(n);
	}
};
var $author$project$VegaLite$axisConfigProperty = function (axisCfg) {
	switch (axisCfg.$) {
		case 'AxisAria':
			var aps = axisCfg.a;
			if (!aps.b) {
				return _List_fromArray(
					[
						$author$project$VegaLite$ariaProperty(
						$author$project$VegaLite$ArAria(false))
					]);
			} else {
				return A2($elm$core$List$map, $author$project$VegaLite$ariaProperty, aps);
			}
		case 'AxDisable':
			var b = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'disable',
					$elm$json$Json$Encode$bool(b))
				]);
		case 'BandPosition':
			var x = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'bandPosition',
					$elm$json$Json$Encode$float(x))
				]);
		case 'Domain':
			var b = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'domain',
					$elm$json$Json$Encode$bool(b))
				]);
		case 'DomainCap':
			var c = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'domainCap',
					$author$project$VegaLite$strokeCapSpec(c))
				]);
		case 'DomainColor':
			var c = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'domainColor',
					$elm$json$Json$Encode$string(c))
				]);
		case 'DomainDash':
			var ds = axisCfg.a;
			return _Utils_eq(ds, _List_Nil) ? _List_fromArray(
				[
					_Utils_Tuple2('domainDash', $elm$json$Json$Encode$null)
				]) : _List_fromArray(
				[
					_Utils_Tuple2(
					'domainDash',
					A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$float, ds))
				]);
		case 'DomainDashOffset':
			var x = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'domainDashOffset',
					$elm$json$Json$Encode$float(x))
				]);
		case 'DomainOpacity':
			var n = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'domainOpacity',
					$elm$json$Json$Encode$float(n))
				]);
		case 'DomainWidth':
			var w = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'domainWidth',
					$elm$json$Json$Encode$float(w))
				]);
		case 'MaxExtent':
			var n = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'maxExtent',
					$elm$json$Json$Encode$float(n))
				]);
		case 'MinExtent':
			var n = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'minExtent',
					$elm$json$Json$Encode$float(n))
				]);
		case 'Grid':
			var b = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'grid',
					$elm$json$Json$Encode$bool(b))
				]);
		case 'GridCap':
			var c = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'gridCap',
					$author$project$VegaLite$strokeCapSpec(c))
				]);
		case 'GridColor':
			var c = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'gridColor',
					$elm$json$Json$Encode$string(c))
				]);
		case 'GridDash':
			var ds = axisCfg.a;
			return _Utils_eq(ds, _List_Nil) ? _List_fromArray(
				[
					_Utils_Tuple2('gridDash', $elm$json$Json$Encode$null)
				]) : _List_fromArray(
				[
					_Utils_Tuple2(
					'gridDash',
					A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$float, ds))
				]);
		case 'GridDashOffset':
			var x = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'gridDashOffset',
					$elm$json$Json$Encode$float(x))
				]);
		case 'GridOpacity':
			var o = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'gridOpacity',
					$elm$json$Json$Encode$float(o))
				]);
		case 'GridWidth':
			var x = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'gridWidth',
					$elm$json$Json$Encode$float(x))
				]);
		case 'Labels':
			var b = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labels',
					$elm$json$Json$Encode$bool(b))
				]);
		case 'LabelAlign':
			var ha = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labelAlign',
					$author$project$VegaLite$hAlignSpec(ha))
				]);
		case 'LabelAngle':
			var a = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labelAngle',
					$elm$json$Json$Encode$float(a))
				]);
		case 'LabelBaseline':
			var va = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labelBaseline',
					$author$project$VegaLite$vAlignSpec(va))
				]);
		case 'LabelBound':
			var mn = axisCfg.a;
			if (mn.$ === 'Just') {
				var n = mn.a;
				return (n === 1) ? _List_fromArray(
					[
						_Utils_Tuple2(
						'labelBound',
						$elm$json$Json$Encode$bool(true))
					]) : _List_fromArray(
					[
						_Utils_Tuple2(
						'labelBound',
						$elm$json$Json$Encode$float(n))
					]);
			} else {
				return _List_fromArray(
					[
						_Utils_Tuple2(
						'labelBound',
						$elm$json$Json$Encode$bool(false))
					]);
			}
		case 'LabelColor':
			var c = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labelColor',
					$elm$json$Json$Encode$string(c))
				]);
		case 'LabelExpr':
			var ex = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labelExpr',
					$elm$json$Json$Encode$string(ex))
				]);
		case 'LabelFlush':
			var mn = axisCfg.a;
			if (mn.$ === 'Just') {
				var n = mn.a;
				return (!n) ? _List_fromArray(
					[
						_Utils_Tuple2(
						'labelFlush',
						$elm$json$Json$Encode$bool(true))
					]) : _List_fromArray(
					[
						_Utils_Tuple2(
						'labelFlush',
						$elm$json$Json$Encode$float(n))
					]);
			} else {
				return _List_fromArray(
					[
						_Utils_Tuple2(
						'labelFlush',
						$elm$json$Json$Encode$bool(false))
					]);
			}
		case 'LabelFlushOffset':
			var n = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labelFlushOffset',
					$elm$json$Json$Encode$float(n))
				]);
		case 'LabelFont':
			var f = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labelFont',
					$elm$json$Json$Encode$string(f))
				]);
		case 'LabelFontStyle':
			var s = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labelFontStyle',
					$elm$json$Json$Encode$string(s))
				]);
		case 'LabelFontSize':
			var x = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labelFontSize',
					$elm$json$Json$Encode$float(x))
				]);
		case 'LabelFontWeight':
			var fw = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labelFontWeight',
					$author$project$VegaLite$fontWeightSpec(fw))
				]);
		case 'LabelLimit':
			var x = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labelLimit',
					$elm$json$Json$Encode$float(x))
				]);
		case 'LabelLineHeight':
			var x = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labelLineHeight',
					$elm$json$Json$Encode$float(x))
				]);
		case 'LabelOpacity':
			var n = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labelOpacity',
					$elm$json$Json$Encode$float(n))
				]);
		case 'LabelOverlap':
			var strat = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labelOverlap',
					$author$project$VegaLite$overlapStrategySpec(strat))
				]);
		case 'LabelPadding':
			var pad = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labelPadding',
					$elm$json$Json$Encode$float(pad))
				]);
		case 'LabelSeparation':
			var x = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labelSeparation',
					$elm$json$Json$Encode$float(x))
				]);
		case 'Ticks':
			var b = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'ticks',
					$elm$json$Json$Encode$bool(b))
				]);
		case 'TickCap':
			var c = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'tickCap',
					$author$project$VegaLite$strokeCapSpec(c))
				]);
		case 'TickColor':
			var c = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'tickColor',
					$elm$json$Json$Encode$string(c))
				]);
		case 'TickCount':
			var tc = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'tickCount',
					$author$project$VegaLite$scaleNiceSpec(tc))
				]);
		case 'TickDash':
			var ds = axisCfg.a;
			return _Utils_eq(ds, _List_Nil) ? _List_fromArray(
				[
					_Utils_Tuple2('tickDash', $elm$json$Json$Encode$null)
				]) : _List_fromArray(
				[
					_Utils_Tuple2(
					'tickDash',
					A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$float, ds))
				]);
		case 'TickDashOffset':
			var x = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'tickDashOffset',
					$elm$json$Json$Encode$float(x))
				]);
		case 'TickExtra':
			var b = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'tickExtra',
					$elm$json$Json$Encode$bool(b))
				]);
		case 'TickOffset':
			var n = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'tickOffset',
					$elm$json$Json$Encode$float(n))
				]);
		case 'TickOpacity':
			var n = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'tickOpacity',
					$elm$json$Json$Encode$float(n))
				]);
		case 'TickMinStep':
			var n = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'tickMinStep',
					$elm$json$Json$Encode$float(n))
				]);
		case 'TickRound':
			var b = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'tickRound',
					$elm$json$Json$Encode$bool(b))
				]);
		case 'TickSize':
			var x = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'tickSize',
					$elm$json$Json$Encode$float(x))
				]);
		case 'TickWidth':
			var x = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'tickWidth',
					$elm$json$Json$Encode$float(x))
				]);
		case 'TitleAlign':
			var al = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titleAlign',
					$author$project$VegaLite$hAlignSpec(al))
				]);
		case 'TitleAngle':
			var a = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titleAngle',
					$elm$json$Json$Encode$float(a))
				]);
		case 'TitleAnchor':
			var an = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titleAnchor',
					$author$project$VegaLite$anchorSpec(an))
				]);
		case 'TitleBaseline':
			var va = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titleBaseline',
					$author$project$VegaLite$vAlignSpec(va))
				]);
		case 'TitleColor':
			var c = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titleColor',
					$elm$json$Json$Encode$string(c))
				]);
		case 'TitleFont':
			var f = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titleFont',
					$elm$json$Json$Encode$string(f))
				]);
		case 'TitleFontStyle':
			var s = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titleFontStyle',
					$elm$json$Json$Encode$string(s))
				]);
		case 'TitleFontWeight':
			var w = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titleFontWeight',
					$author$project$VegaLite$fontWeightSpec(w))
				]);
		case 'TitleFontSize':
			var x = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titleFontSize',
					$elm$json$Json$Encode$float(x))
				]);
		case 'TitleLimit':
			var x = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titleLimit',
					$elm$json$Json$Encode$float(x))
				]);
		case 'TitleLineHeight':
			var x = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titleLineHeight',
					$elm$json$Json$Encode$float(x))
				]);
		case 'TitleOpacity':
			var n = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titleOpacity',
					$elm$json$Json$Encode$float(n))
				]);
		case 'TitlePadding':
			var x = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titlePadding',
					$elm$json$Json$Encode$float(x))
				]);
		case 'TitleX':
			var x = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titleX',
					$elm$json$Json$Encode$float(x))
				]);
		case 'TitleY':
			var y = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titleY',
					$elm$json$Json$Encode$float(y))
				]);
		default:
			var x = axisCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'translate',
					$elm$json$Json$Encode$float(x))
				]);
	}
};
var $author$project$VegaLite$axisLabel = function (axChoice) {
	switch (axChoice.$) {
		case 'AxX':
			return 'axisX';
		case 'AxY':
			return 'axisY';
		default:
			return 'axis';
	}
};
var $author$project$VegaLite$AxLabelAlign = function (a) {
	return {$: 'AxLabelAlign', a: a};
};
var $author$project$VegaLite$AxGridColor = function (a) {
	return {$: 'AxGridColor', a: a};
};
var $author$project$VegaLite$Str = function (a) {
	return {$: 'Str', a: a};
};
var $author$project$VegaLite$axGridColor = function (s) {
	return $author$project$VegaLite$AxGridColor(
		$author$project$VegaLite$Str(s));
};
var $author$project$VegaLite$AxGridDash = function (a) {
	return {$: 'AxGridDash', a: a};
};
var $author$project$VegaLite$axGridDash = $author$project$VegaLite$AxGridDash;
var $author$project$VegaLite$AxGridDashOffset = function (a) {
	return {$: 'AxGridDashOffset', a: a};
};
var $author$project$VegaLite$Num = function (a) {
	return {$: 'Num', a: a};
};
var $author$project$VegaLite$axGridDashOffset = function (n) {
	return $author$project$VegaLite$AxGridDashOffset(
		$author$project$VegaLite$Num(n));
};
var $author$project$VegaLite$AxGridOpacity = function (a) {
	return {$: 'AxGridOpacity', a: a};
};
var $author$project$VegaLite$axGridOpacity = function (n) {
	return $author$project$VegaLite$AxGridOpacity(
		$author$project$VegaLite$Num(n));
};
var $author$project$VegaLite$AxGridWidth = function (a) {
	return {$: 'AxGridWidth', a: a};
};
var $author$project$VegaLite$axGridWidth = function (n) {
	return $author$project$VegaLite$AxGridWidth(
		$author$project$VegaLite$Num(n));
};
var $author$project$VegaLite$axLabelAlign = $author$project$VegaLite$AxLabelAlign;
var $author$project$VegaLite$AxLabelBaseline = function (a) {
	return {$: 'AxLabelBaseline', a: a};
};
var $author$project$VegaLite$axLabelBaseline = $author$project$VegaLite$AxLabelBaseline;
var $author$project$VegaLite$AxLabelColor = function (a) {
	return {$: 'AxLabelColor', a: a};
};
var $author$project$VegaLite$axLabelColor = function (s) {
	return $author$project$VegaLite$AxLabelColor(
		$author$project$VegaLite$Str(s));
};
var $author$project$VegaLite$AxLabelFont = function (a) {
	return {$: 'AxLabelFont', a: a};
};
var $author$project$VegaLite$axLabelFont = function (s) {
	return $author$project$VegaLite$AxLabelFont(
		$author$project$VegaLite$Str(s));
};
var $author$project$VegaLite$AxLabelFontSize = function (a) {
	return {$: 'AxLabelFontSize', a: a};
};
var $author$project$VegaLite$axLabelFontSize = function (n) {
	return $author$project$VegaLite$AxLabelFontSize(
		$author$project$VegaLite$Num(n));
};
var $author$project$VegaLite$AxLabelFontStyle = function (a) {
	return {$: 'AxLabelFontStyle', a: a};
};
var $author$project$VegaLite$axLabelFontStyle = function (s) {
	return $author$project$VegaLite$AxLabelFontStyle(
		$author$project$VegaLite$Str(s));
};
var $author$project$VegaLite$AxLabelFontWeight = function (a) {
	return {$: 'AxLabelFontWeight', a: a};
};
var $author$project$VegaLite$axLabelFontWeight = $author$project$VegaLite$AxLabelFontWeight;
var $author$project$VegaLite$AxLabelOffset = function (a) {
	return {$: 'AxLabelOffset', a: a};
};
var $author$project$VegaLite$axLabelOffset = function (n) {
	return $author$project$VegaLite$AxLabelOffset(
		$author$project$VegaLite$Num(n));
};
var $author$project$VegaLite$AxLabelOpacity = function (a) {
	return {$: 'AxLabelOpacity', a: a};
};
var $author$project$VegaLite$axLabelOpacity = function (n) {
	return $author$project$VegaLite$AxLabelOpacity(
		$author$project$VegaLite$Num(n));
};
var $author$project$VegaLite$AxLabelPadding = function (a) {
	return {$: 'AxLabelPadding', a: a};
};
var $author$project$VegaLite$axLabelPadding = function (n) {
	return $author$project$VegaLite$AxLabelPadding(
		$author$project$VegaLite$Num(n));
};
var $author$project$VegaLite$AxTickColor = function (a) {
	return {$: 'AxTickColor', a: a};
};
var $author$project$VegaLite$axTickColor = function (s) {
	return $author$project$VegaLite$AxTickColor(
		$author$project$VegaLite$Str(s));
};
var $author$project$VegaLite$AxTickDash = function (a) {
	return {$: 'AxTickDash', a: a};
};
var $author$project$VegaLite$axTickDash = $author$project$VegaLite$AxTickDash;
var $author$project$VegaLite$AxTickDashOffset = function (a) {
	return {$: 'AxTickDashOffset', a: a};
};
var $author$project$VegaLite$axTickDashOffset = function (n) {
	return $author$project$VegaLite$AxTickDashOffset(
		$author$project$VegaLite$Num(n));
};
var $author$project$VegaLite$AxTickOpacity = function (a) {
	return {$: 'AxTickOpacity', a: a};
};
var $author$project$VegaLite$axTickOpacity = function (n) {
	return $author$project$VegaLite$AxTickOpacity(
		$author$project$VegaLite$Num(n));
};
var $author$project$VegaLite$AxTickSize = function (a) {
	return {$: 'AxTickSize', a: a};
};
var $author$project$VegaLite$axTickSize = function (n) {
	return $author$project$VegaLite$AxTickSize(
		$author$project$VegaLite$Num(n));
};
var $author$project$VegaLite$AxTickWidth = function (a) {
	return {$: 'AxTickWidth', a: a};
};
var $author$project$VegaLite$axTickWidth = function (n) {
	return $author$project$VegaLite$AxTickWidth(
		$author$project$VegaLite$Num(n));
};
var $author$project$VegaLite$arrangementLabel = function (arrng) {
	switch (arrng.$) {
		case 'Row':
			return 'row';
		case 'Column':
			return 'column';
		case 'Flow':
			return 'repeat';
		default:
			return 'layer';
	}
};
var $author$project$VegaLite$binProperty = function (binProp) {
	switch (binProp.$) {
		case 'MaxBins':
			var n = binProp.a;
			return _Utils_Tuple2(
				'maxbins',
				$elm$json$Json$Encode$int(n));
		case 'BiAnchor':
			var x = binProp.a;
			return _Utils_Tuple2(
				'anchor',
				$elm$json$Json$Encode$float(x));
		case 'Base':
			var x = binProp.a;
			return _Utils_Tuple2(
				'base',
				$elm$json$Json$Encode$float(x));
		case 'Step':
			var x = binProp.a;
			return _Utils_Tuple2(
				'step',
				$elm$json$Json$Encode$float(x));
		case 'Steps':
			var xs = binProp.a;
			return _Utils_Tuple2(
				'steps',
				A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$float, xs));
		case 'MinStep':
			var x = binProp.a;
			return _Utils_Tuple2(
				'minstep',
				$elm$json$Json$Encode$float(x));
		case 'Divides':
			var xs = binProp.a;
			return _Utils_Tuple2(
				'divide',
				A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$float, xs));
		case 'Extent':
			var mn = binProp.a;
			var mx = binProp.b;
			return _Utils_Tuple2(
				'extent',
				A2(
					$elm$json$Json$Encode$list,
					$elm$json$Json$Encode$float,
					_List_fromArray(
						[mn, mx])));
		case 'SelectionExtent':
			var s = binProp.a;
			return _Utils_Tuple2(
				'extent',
				$elm$json$Json$Encode$object(
					_List_fromArray(
						[
							_Utils_Tuple2(
							'param',
							$elm$json$Json$Encode$string(s))
						])));
		default:
			var b = binProp.a;
			return _Utils_Tuple2(
				'nice',
				$elm$json$Json$Encode$bool(b));
	}
};
var $author$project$VegaLite$bin = function (bProps) {
	return _Utils_eq(bProps, _List_Nil) ? _Utils_Tuple2(
		'bin',
		$elm$json$Json$Encode$bool(true)) : _Utils_Tuple2(
		'bin',
		$elm$json$Json$Encode$object(
			A2($elm$core$List$map, $author$project$VegaLite$binProperty, bProps)));
};
var $elm$core$Basics$composeR = F3(
	function (f, g, x) {
		return g(
			f(x));
	});
var $author$project$VegaLite$dayLabel = function (dayName) {
	switch (dayName.$) {
		case 'Mon':
			return 'Mon';
		case 'Tue':
			return 'Tue';
		case 'Wed':
			return 'Wed';
		case 'Thu':
			return 'Thu';
		case 'Fri':
			return 'Fri';
		case 'Sat':
			return 'Sat';
		default:
			return 'Sun';
	}
};
var $author$project$VegaLite$monthNameLabel = function (mon) {
	switch (mon.$) {
		case 'Jan':
			return 'Jan';
		case 'Feb':
			return 'Feb';
		case 'Mar':
			return 'Mar';
		case 'Apr':
			return 'Apr';
		case 'May':
			return 'May';
		case 'Jun':
			return 'Jun';
		case 'Jul':
			return 'Jul';
		case 'Aug':
			return 'Aug';
		case 'Sep':
			return 'Sep';
		case 'Oct':
			return 'Oct';
		case 'Nov':
			return 'Nov';
		default:
			return 'Dec';
	}
};
var $author$project$VegaLite$dateTimeProperty = function (dtp) {
	switch (dtp.$) {
		case 'DTYear':
			var y = dtp.a;
			return _Utils_Tuple2(
				'year',
				$elm$json$Json$Encode$int(y));
		case 'DTQuarter':
			var q = dtp.a;
			return _Utils_Tuple2(
				'quarter',
				$elm$json$Json$Encode$int(q));
		case 'DTMonth':
			var mon = dtp.a;
			return _Utils_Tuple2(
				'month',
				$elm$json$Json$Encode$string(
					$author$project$VegaLite$monthNameLabel(mon)));
		case 'DTMonthNum':
			var n = dtp.a;
			return _Utils_Tuple2(
				'month',
				$elm$json$Json$Encode$int(n));
		case 'DTDate':
			var d = dtp.a;
			return _Utils_Tuple2(
				'date',
				$elm$json$Json$Encode$int(d));
		case 'DTDay':
			var d = dtp.a;
			return _Utils_Tuple2(
				'day',
				$elm$json$Json$Encode$string(
					$author$project$VegaLite$dayLabel(d)));
		case 'DTHours':
			var h = dtp.a;
			return _Utils_Tuple2(
				'hours',
				$elm$json$Json$Encode$int(h));
		case 'DTMinutes':
			var m = dtp.a;
			return _Utils_Tuple2(
				'minutes',
				$elm$json$Json$Encode$int(m));
		case 'DTSeconds':
			var s = dtp.a;
			return _Utils_Tuple2(
				'seconds',
				$elm$json$Json$Encode$int(s));
		default:
			var ms = dtp.a;
			return _Utils_Tuple2(
				'milliseconds',
				$elm$json$Json$Encode$int(ms));
	}
};
var $author$project$VegaLite$dataValuesSpecs = function (dvs) {
	switch (dvs.$) {
		case 'Numbers':
			var xs = dvs.a;
			return A2($elm$core$List$map, $elm$json$Json$Encode$float, xs);
		case 'Strings':
			var ss = dvs.a;
			return A2($elm$core$List$map, $elm$json$Json$Encode$string, ss);
		case 'DateTimes':
			var dtss = dvs.a;
			return A2(
				$elm$core$List$map,
				A2(
					$elm$core$Basics$composeR,
					$elm$core$List$map($author$project$VegaLite$dateTimeProperty),
					$elm$json$Json$Encode$object),
				dtss);
		default:
			var bs = dvs.a;
			return A2($elm$core$List$map, $elm$json$Json$Encode$bool, bs);
	}
};
var $author$project$VegaLite$toList = $elm$json$Json$Encode$list($elm$core$Basics$identity);
var $author$project$VegaLite$dataValueSpec = function (val) {
	switch (val.$) {
		case 'Number':
			var x = val.a;
			return $elm$json$Json$Encode$float(x);
		case 'DStr':
			var s = val.a;
			return $elm$json$Json$Encode$string(s);
		case 'Boolean':
			var b = val.a;
			return $elm$json$Json$Encode$bool(b);
		case 'DateTime':
			var d = val.a;
			return $elm$json$Json$Encode$object(
				A2($elm$core$List$map, $author$project$VegaLite$dateTimeProperty, d));
		case 'DExpr':
			var s = val.a;
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'expr',
						$elm$json$Json$Encode$string(s))
					]));
		case 'NullValue':
			return $elm$json$Json$Encode$null;
		case 'DConcat':
			var vals = val.a;
			return $author$project$VegaLite$toList(
				$author$project$VegaLite$dataValuesSpecs(vals));
		default:
			var kvs = val.a;
			return $elm$json$Json$Encode$object(
				A2(
					$elm$core$List$map,
					function (_v1) {
						var k = _v1.a;
						var v = _v1.b;
						return _Utils_Tuple2(
							k,
							$author$project$VegaLite$dataValueSpec(v));
					},
					kvs));
	}
};
var $author$project$VegaLite$filterProperties = function (f) {
	switch (f.$) {
		case 'FEqual':
			var field = f.a;
			var val = f.b;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'field',
					$elm$json$Json$Encode$string(field)),
					_Utils_Tuple2(
					'equal',
					$author$project$VegaLite$dataValueSpec(val))
				]);
		case 'FLessThan':
			var field = f.a;
			var val = f.b;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'field',
					$elm$json$Json$Encode$string(field)),
					_Utils_Tuple2(
					'lt',
					$author$project$VegaLite$dataValueSpec(val))
				]);
		case 'FLessThanEq':
			var field = f.a;
			var val = f.b;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'field',
					$elm$json$Json$Encode$string(field)),
					_Utils_Tuple2(
					'lte',
					$author$project$VegaLite$dataValueSpec(val))
				]);
		case 'FGreaterThan':
			var field = f.a;
			var val = f.b;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'field',
					$elm$json$Json$Encode$string(field)),
					_Utils_Tuple2(
					'gt',
					$author$project$VegaLite$dataValueSpec(val))
				]);
		case 'FGreaterThanEq':
			var field = f.a;
			var val = f.b;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'field',
					$elm$json$Json$Encode$string(field)),
					_Utils_Tuple2(
					'gte',
					$author$project$VegaLite$dataValueSpec(val))
				]);
		case 'FSelection':
			var selName = f.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'param',
					$elm$json$Json$Encode$string(selName))
				]);
		case 'FSelectionEmpty':
			var selName = f.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'param',
					$elm$json$Json$Encode$string(selName)),
					_Utils_Tuple2(
					'empty',
					$elm$json$Json$Encode$bool(false))
				]);
		case 'FRange':
			var field = f.a;
			var vals = f.b;
			var values = function () {
				if (vals.$ === 'NumberRange') {
					var mn = vals.a;
					var mx = vals.b;
					return A2(
						$elm$json$Json$Encode$list,
						$elm$json$Json$Encode$float,
						_List_fromArray(
							[mn, mx]));
				} else {
					if (!vals.a.b) {
						if (!vals.b.b) {
							return $author$project$VegaLite$toList(
								_List_fromArray(
									[$elm$json$Json$Encode$null, $elm$json$Json$Encode$null]));
						} else {
							var dMax = vals.b;
							return $author$project$VegaLite$toList(
								_List_fromArray(
									[
										$elm$json$Json$Encode$null,
										$elm$json$Json$Encode$object(
										A2($elm$core$List$map, $author$project$VegaLite$dateTimeProperty, dMax))
									]));
						}
					} else {
						if (!vals.b.b) {
							var dMin = vals.a;
							return $author$project$VegaLite$toList(
								_List_fromArray(
									[
										$elm$json$Json$Encode$object(
										A2($elm$core$List$map, $author$project$VegaLite$dateTimeProperty, dMin)),
										$elm$json$Json$Encode$null
									]));
						} else {
							var dMin = vals.a;
							var dMax = vals.b;
							return A2(
								$elm$json$Json$Encode$list,
								$elm$json$Json$Encode$object,
								_List_fromArray(
									[
										A2($elm$core$List$map, $author$project$VegaLite$dateTimeProperty, dMin),
										A2($elm$core$List$map, $author$project$VegaLite$dateTimeProperty, dMax)
									]));
						}
					}
				}
			}();
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'field',
					$elm$json$Json$Encode$string(field)),
					_Utils_Tuple2('range', values)
				]);
		case 'FOneOf':
			var field = f.a;
			var vals = f.b;
			var values = function () {
				switch (vals.$) {
					case 'Numbers':
						var xs = vals.a;
						return A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$float, xs);
					case 'DateTimes':
						var ds = vals.a;
						return A2(
							$elm$json$Json$Encode$list,
							function (d) {
								return $elm$json$Json$Encode$object(
									A2($elm$core$List$map, $author$project$VegaLite$dateTimeProperty, d));
							},
							ds);
					case 'Strings':
						var ss = vals.a;
						return A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$string, ss);
					default:
						var bs = vals.a;
						return A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$bool, bs);
				}
			}();
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'field',
					$elm$json$Json$Encode$string(field)),
					_Utils_Tuple2('oneOf', values)
				]);
		case 'FValid':
			var field = f.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'field',
					$elm$json$Json$Encode$string(field)),
					_Utils_Tuple2(
					'valid',
					$elm$json$Json$Encode$bool(true))
				]);
		default:
			return _List_Nil;
	}
};
var $author$project$VegaLite$compositionAlignmentLabel = function (ca) {
	switch (ca.$) {
		case 'CANone':
			return 'none';
		case 'CAEach':
			return 'each';
		default:
			return 'all';
	}
};
var $author$project$VegaLite$legendOrientLabel = function (orient) {
	switch (orient.$) {
		case 'Left':
			return 'left';
		case 'TopLeft':
			return 'top-left';
		case 'Top':
			return 'top';
		case 'TopRight':
			return 'top-right';
		case 'Right':
			return 'right';
		case 'BottomRight':
			return 'bottom-right';
		case 'Bottom':
			return 'bottom';
		case 'BottomLeft':
			return 'bottom-left';
		default:
			return 'none';
	}
};
var $author$project$VegaLite$legendProperty = function (legendProp) {
	switch (legendProp.$) {
		case 'LAria':
			var aps = legendProp.a;
			if (!aps.b) {
				return _List_fromArray(
					[
						$author$project$VegaLite$ariaProperty(
						$author$project$VegaLite$ArAria(false))
					]);
			} else {
				return A2($elm$core$List$map, $author$project$VegaLite$ariaProperty, aps);
			}
		case 'LClipHeight':
			var n = legendProp.a;
			return A2($author$project$VegaLite$numExpr, 'clipHeight', n);
		case 'LColumnPadding':
			var n = legendProp.a;
			return A2($author$project$VegaLite$numExpr, 'columnPadding', n);
		case 'LRowPadding':
			var n = legendProp.a;
			return A2($author$project$VegaLite$numExpr, 'rowPadding', n);
		case 'LColumns':
			var n = legendProp.a;
			return A2($author$project$VegaLite$numExpr, 'columns', n);
		case 'LCornerRadius':
			var n = legendProp.a;
			return A2($author$project$VegaLite$numExpr, 'cornerRadius', n);
		case 'LFillColor':
			var s = legendProp.a;
			return A2($author$project$VegaLite$strExpr, 'fillColor', s);
		case 'LDirection':
			var d = legendProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'direction',
					$elm$json$Json$Encode$string(
						$author$project$VegaLite$markOrientationLabel(d)))
				]);
		case 'LType':
			var lType = legendProp.a;
			if (lType.$ === 'Gradient') {
				return _List_fromArray(
					[
						_Utils_Tuple2(
						'type',
						$elm$json$Json$Encode$string('gradient'))
					]);
			} else {
				return _List_fromArray(
					[
						_Utils_Tuple2(
						'type',
						$elm$json$Json$Encode$string('symbol'))
					]);
			}
		case 'LFormat':
			var s = legendProp.a;
			return A2($author$project$VegaLite$strExpr, 'format', s);
		case 'LFormatAsNum':
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'formatType',
					$elm$json$Json$Encode$string('number'))
				]);
		case 'LFormatAsTemporal':
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'formatType',
					$elm$json$Json$Encode$string('time'))
				]);
		case 'LFormatAsCustom':
			var s = legendProp.a;
			return A2($author$project$VegaLite$strExpr, 'formatType', s);
		case 'LGradientLength':
			var n = legendProp.a;
			return A2($author$project$VegaLite$numExpr, 'gradientLength', n);
		case 'LGradientThickness':
			var n = legendProp.a;
			return A2($author$project$VegaLite$numExpr, 'gradientThickness', n);
		case 'LGradientStrokeColor':
			var s = legendProp.a;
			return A2($author$project$VegaLite$strExpr, 'gradientStrokeColor', s);
		case 'LGradientStrokeWidth':
			var n = legendProp.a;
			return A2($author$project$VegaLite$numExpr, 'gradientStrokeWidth', n);
		case 'LGridAlign':
			var ga = legendProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'gridAlign',
					$elm$json$Json$Encode$string(
						$author$project$VegaLite$compositionAlignmentLabel(ga)))
				]);
		case 'LLabelAlign':
			var ha = legendProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labelAlign',
					$author$project$VegaLite$hAlignSpec(ha))
				]);
		case 'LLabelBaseline':
			var va = legendProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labelBaseline',
					$author$project$VegaLite$vAlignSpec(va))
				]);
		case 'LLabelColor':
			var s = legendProp.a;
			return A2($author$project$VegaLite$strExpr, 'labelColor', s);
		case 'LLabelFont':
			var s = legendProp.a;
			return A2($author$project$VegaLite$strExpr, 'labelFont', s);
		case 'LLabelFontSize':
			var n = legendProp.a;
			return A2($author$project$VegaLite$numExpr, 'labelFontSize', n);
		case 'LLabelLimit':
			var n = legendProp.a;
			return A2($author$project$VegaLite$numExpr, 'labelLimit', n);
		case 'LLabelOffset':
			var n = legendProp.a;
			return A2($author$project$VegaLite$numExpr, 'labelOffset', n);
		case 'LLabelOverlap':
			var lo = legendProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labelOverlap',
					$author$project$VegaLite$overlapStrategySpec(lo))
				]);
		case 'LOffset':
			var n = legendProp.a;
			return A2($author$project$VegaLite$numExpr, 'offset', n);
		case 'LOrient':
			var orient = legendProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'orient',
					$elm$json$Json$Encode$string(
						$author$project$VegaLite$legendOrientLabel(orient)))
				]);
		case 'LPadding':
			var n = legendProp.a;
			return A2($author$project$VegaLite$numExpr, 'padding', n);
		case 'LStrokeColor':
			var s = legendProp.a;
			return A2($author$project$VegaLite$strExpr, 'strokeColor', s);
		case 'LStrokeWidth':
			var n = legendProp.a;
			return A2($author$project$VegaLite$numExpr, 'strokeWidth', n);
		case 'LSymbolFillColor':
			var s = legendProp.a;
			return A2($author$project$VegaLite$strExpr, 'symbolFillColor', s);
		case 'LSymbolLimit':
			var n = legendProp.a;
			return A2($author$project$VegaLite$numExpr, 'symbolLimit', n);
		case 'LSymbolStrokeColor':
			var s = legendProp.a;
			return A2($author$project$VegaLite$strExpr, 'symbolStrokeColor', s);
		case 'LSymbolType':
			var s = legendProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'symbolType',
					$author$project$VegaLite$symbolSpec(s))
				]);
		case 'LSymbolSize':
			var n = legendProp.a;
			return A2($author$project$VegaLite$numExpr, 'symbolSize', n);
		case 'LSymbolStrokeWidth':
			var n = legendProp.a;
			return A2($author$project$VegaLite$numExpr, 'symbolStrokeWidth', n);
		case 'LTickCount':
			var n = legendProp.a;
			return A2($author$project$VegaLite$numExpr, 'tickCount', n);
		case 'LTitle':
			var txt = legendProp.a;
			if (txt.$ === 'Str') {
				var s = txt.a;
				return (s === '') ? _List_fromArray(
					[
						_Utils_Tuple2('title', $elm$json$Json$Encode$null)
					]) : _List_fromArray(
					[
						_Utils_Tuple2(
						'title',
						$author$project$VegaLite$multilineTextSpec(s))
					]);
			} else {
				return A2($author$project$VegaLite$strExpr, 'title', txt);
			}
		case 'LTitleAlign':
			var ha = legendProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titleAlign',
					$author$project$VegaLite$hAlignSpec(ha))
				]);
		case 'LTitleBaseline':
			var va = legendProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titleBaseline',
					$author$project$VegaLite$vAlignSpec(va))
				]);
		case 'LTitleColor':
			var s = legendProp.a;
			return A2($author$project$VegaLite$strExpr, 'titleColor', s);
		case 'LTitleFont':
			var s = legendProp.a;
			return A2($author$project$VegaLite$strExpr, 'titleFont', s);
		case 'LTitleFontSize':
			var n = legendProp.a;
			return A2($author$project$VegaLite$numExpr, 'titleFontSize', n);
		case 'LTitleFontWeight':
			var fw = legendProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titleFontWeight',
					$author$project$VegaLite$fontWeightSpec(fw))
				]);
		case 'LTitleLimit':
			var n = legendProp.a;
			return A2($author$project$VegaLite$numExpr, 'titleLimit', n);
		case 'LTitleOrient':
			var orient = legendProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titleOrient',
					$elm$json$Json$Encode$string(
						$author$project$VegaLite$legendOrientLabel(orient)))
				]);
		case 'LTitlePadding':
			var n = legendProp.a;
			return A2($author$project$VegaLite$numExpr, 'titlePadding', n);
		case 'LValues':
			var vals = legendProp.a;
			var list = function () {
				switch (vals.$) {
					case 'LNumbers':
						var xs = vals.a;
						return A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$float, xs);
					case 'LDateTimes':
						var ds = vals.a;
						return A2(
							$elm$json$Json$Encode$list,
							function (d) {
								return $elm$json$Json$Encode$object(
									A2($elm$core$List$map, $author$project$VegaLite$dateTimeProperty, d));
							},
							ds);
					default:
						var ss = vals.a;
						return A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$string, ss);
				}
			}();
			return _List_fromArray(
				[
					_Utils_Tuple2('values', list)
				]);
		case 'LeX':
			var n = legendProp.a;
			return A2($author$project$VegaLite$numExpr, 'legendX', n);
		case 'LeY':
			var n = legendProp.a;
			return A2($author$project$VegaLite$numExpr, 'legendY', n);
		default:
			var n = legendProp.a;
			return A2($author$project$VegaLite$numExpr, 'zindex', n);
	}
};
var $author$project$VegaLite$measurementLabel = function (mType) {
	switch (mType.$) {
		case 'Nominal':
			return 'nominal';
		case 'Ordinal':
			return 'ordinal';
		case 'Quantitative':
			return 'quantitative';
		case 'Temporal':
			return 'temporal';
		default:
			return 'geojson';
	}
};
var $elm$core$String$length = _String_length;
var $author$project$VegaLite$operationSpec = function (op) {
	switch (op.$) {
		case 'ArgMax':
			var maybeField = op.a;
			if (maybeField.$ === 'Nothing') {
				return $elm$json$Json$Encode$string('argmax');
			} else {
				var f = maybeField.a;
				return (!$elm$core$String$length(
					$elm$core$String$trim(f))) ? $elm$json$Json$Encode$string('argmax') : $elm$json$Json$Encode$object(
					_List_fromArray(
						[
							_Utils_Tuple2(
							'argmax',
							$elm$json$Json$Encode$string(f))
						]));
			}
		case 'ArgMin':
			var maybeField = op.a;
			if (maybeField.$ === 'Nothing') {
				return $elm$json$Json$Encode$string('argmin');
			} else {
				var f = maybeField.a;
				return (!$elm$core$String$length(
					$elm$core$String$trim(f))) ? $elm$json$Json$Encode$string('argmin') : $elm$json$Json$Encode$object(
					_List_fromArray(
						[
							_Utils_Tuple2(
							'argmin',
							$elm$json$Json$Encode$string(f))
						]));
			}
		case 'Count':
			return $elm$json$Json$Encode$string('count');
		case 'CI0':
			return $elm$json$Json$Encode$string('ci0');
		case 'CI1':
			return $elm$json$Json$Encode$string('ci1');
		case 'Distinct':
			return $elm$json$Json$Encode$string('distinct');
		case 'Max':
			return $elm$json$Json$Encode$string('max');
		case 'Mean':
			return $elm$json$Json$Encode$string('mean');
		case 'Median':
			return $elm$json$Json$Encode$string('median');
		case 'Min':
			return $elm$json$Json$Encode$string('min');
		case 'Missing':
			return $elm$json$Json$Encode$string('missing');
		case 'Product':
			return $elm$json$Json$Encode$string('product');
		case 'Q1':
			return $elm$json$Json$Encode$string('q1');
		case 'Q3':
			return $elm$json$Json$Encode$string('q3');
		case 'Stdev':
			return $elm$json$Json$Encode$string('stdev');
		case 'StdevP':
			return $elm$json$Json$Encode$string('stdevp');
		case 'Sum':
			return $elm$json$Json$Encode$string('sum');
		case 'Stderr':
			return $elm$json$Json$Encode$string('stderr');
		case 'Valid':
			return $elm$json$Json$Encode$string('valid');
		case 'Variance':
			return $elm$json$Json$Encode$string('variance');
		default:
			return $elm$json$Json$Encode$string('variancep');
	}
};
var $author$project$VegaLite$cInterpolateSpec = function (iType) {
	switch (iType.$) {
		case 'Rgb':
			var gamma = iType.a;
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'type',
						$elm$json$Json$Encode$string('rgb')),
						_Utils_Tuple2(
						'gamma',
						$elm$json$Json$Encode$float(gamma))
					]));
		case 'Hsl':
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'type',
						$elm$json$Json$Encode$string('hsl'))
					]));
		case 'HslLong':
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'type',
						$elm$json$Json$Encode$string('hsl-long'))
					]));
		case 'Lab':
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'type',
						$elm$json$Json$Encode$string('lab'))
					]));
		case 'Hcl':
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'type',
						$elm$json$Json$Encode$string('hcl'))
					]));
		case 'HclLong':
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'type',
						$elm$json$Json$Encode$string('hcl-long'))
					]));
		case 'CubeHelix':
			var gamma = iType.a;
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'type',
						$elm$json$Json$Encode$string('cubehelix')),
						_Utils_Tuple2(
						'gamma',
						$elm$json$Json$Encode$float(gamma))
					]));
		default:
			var gamma = iType.a;
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'type',
						$elm$json$Json$Encode$string('cubehelix-long')),
						_Utils_Tuple2(
						'gamma',
						$elm$json$Json$Encode$float(gamma))
					]));
	}
};
var $author$project$VegaLite$channelLabel = function (ch) {
	switch (ch.$) {
		case 'ChX':
			return 'x';
		case 'ChY':
			return 'y';
		case 'ChX2':
			return 'x2';
		case 'ChY2':
			return 'y2';
		case 'ChColor':
			return 'color';
		case 'ChOpacity':
			return 'opacity';
		case 'ChShape':
			return 'shape';
		case 'ChSize':
			return 'size';
		default:
			return 'strokeDash';
	}
};
var $author$project$VegaLite$scaleDomainSpec = function (sdType) {
	switch (sdType.$) {
		case 'DNumbers':
			var ns = sdType.a;
			return A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$float, ns);
		case 'DMinNumber':
			var x = sdType.a;
			return $elm$json$Json$Encode$float(x);
		case 'DMidNumber':
			var x = sdType.a;
			return $elm$json$Json$Encode$float(x);
		case 'DMaxNumber':
			var x = sdType.a;
			return $elm$json$Json$Encode$float(x);
		case 'DDateTimes':
			var ds = sdType.a;
			return A2(
				$elm$json$Json$Encode$list,
				function (d) {
					return $elm$json$Json$Encode$object(
						A2($elm$core$List$map, $author$project$VegaLite$dateTimeProperty, d));
				},
				ds);
		case 'DMinDateTime':
			var d = sdType.a;
			return $elm$json$Json$Encode$object(
				A2($elm$core$List$map, $author$project$VegaLite$dateTimeProperty, d));
		case 'DMaxDateTime':
			var d = sdType.a;
			return $elm$json$Json$Encode$object(
				A2($elm$core$List$map, $author$project$VegaLite$dateTimeProperty, d));
		case 'DStrings':
			var cats = sdType.a;
			return A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$string, cats);
		case 'DSelection':
			var selName = sdType.a;
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'param',
						$elm$json$Json$Encode$string(selName))
					]));
		case 'DSelectionChannel':
			var selName = sdType.a;
			var ch = sdType.b;
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'param',
						$elm$json$Json$Encode$string(selName)),
						_Utils_Tuple2(
						'encoding',
						$elm$json$Json$Encode$string(
							$author$project$VegaLite$channelLabel(ch)))
					]));
		case 'DSelectionField':
			var selName = sdType.a;
			var f = sdType.b;
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'param',
						$elm$json$Json$Encode$string(selName)),
						_Utils_Tuple2(
						'field',
						$elm$json$Json$Encode$string(f))
					]));
		case 'Unaggregated':
			return $elm$json$Json$Encode$string('unaggregated');
		default:
			var scDo = sdType.a;
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'unionWith',
						$author$project$VegaLite$scaleDomainSpec(scDo))
					]));
	}
};
var $author$project$VegaLite$scaleLabel = function (sc) {
	switch (sc.$) {
		case 'ScLinear':
			return 'linear';
		case 'ScPow':
			return 'pow';
		case 'ScSymLog':
			return 'symlog';
		case 'ScSqrt':
			return 'sqrt';
		case 'ScLog':
			return 'log';
		case 'ScTime':
			return 'time';
		case 'ScUtc':
			return 'utc';
		case 'ScOrdinal':
			return 'ordinal';
		case 'ScBand':
			return 'band';
		case 'ScPoint':
			return 'point';
		case 'ScBinOrdinal':
			return 'bin-ordinal';
		case 'ScQuantile':
			return 'quantile';
		case 'ScQuantize':
			return 'quantize';
		default:
			return 'threshold';
	}
};
var $author$project$VegaLite$schemeProperty = F2(
	function (schName, extent) {
		if (!extent.b) {
			return _Utils_Tuple2(
				'scheme',
				$elm$json$Json$Encode$string(schName));
		} else {
			if (!extent.b.b) {
				var n = extent.a;
				return _Utils_Tuple2(
					'scheme',
					$elm$json$Json$Encode$object(
						_List_fromArray(
							[
								_Utils_Tuple2(
								'name',
								$elm$json$Json$Encode$string(schName)),
								_Utils_Tuple2(
								'count',
								$elm$json$Json$Encode$float(n))
							])));
			} else {
				if (!extent.b.b.b) {
					var mn = extent.a;
					var _v1 = extent.b;
					var mx = _v1.a;
					return _Utils_Tuple2(
						'scheme',
						$elm$json$Json$Encode$object(
							_List_fromArray(
								[
									_Utils_Tuple2(
									'name',
									$elm$json$Json$Encode$string(schName)),
									_Utils_Tuple2(
									'extent',
									A2(
										$elm$json$Json$Encode$list,
										$elm$json$Json$Encode$float,
										_List_fromArray(
											[mn, mx])))
								])));
				} else {
					return _Utils_Tuple2(
						'scheme',
						$elm$json$Json$Encode$string(schName));
				}
			}
		}
	});
var $author$project$VegaLite$scaleProperty = function (scaleProp) {
	switch (scaleProp.$) {
		case 'SType':
			var sType = scaleProp.a;
			return _Utils_Tuple2(
				'type',
				$elm$json$Json$Encode$string(
					$author$project$VegaLite$scaleLabel(sType)));
		case 'SDomain':
			var sdType = scaleProp.a;
			switch (sdType.$) {
				case 'DMinNumber':
					var x = sdType.a;
					return _Utils_Tuple2(
						'domainMin',
						$elm$json$Json$Encode$float(x));
				case 'DMidNumber':
					var x = sdType.a;
					return _Utils_Tuple2(
						'domainMid',
						$elm$json$Json$Encode$float(x));
				case 'DMaxNumber':
					var x = sdType.a;
					return _Utils_Tuple2(
						'domainMax',
						$elm$json$Json$Encode$float(x));
				case 'DMinDateTime':
					var d = sdType.a;
					return _Utils_Tuple2(
						'domainMin',
						$elm$json$Json$Encode$object(
							A2($elm$core$List$map, $author$project$VegaLite$dateTimeProperty, d)));
				case 'DMaxDateTime':
					var d = sdType.a;
					return _Utils_Tuple2(
						'domainMax',
						$elm$json$Json$Encode$object(
							A2($elm$core$List$map, $author$project$VegaLite$dateTimeProperty, d)));
				default:
					return _Utils_Tuple2(
						'domain',
						$author$project$VegaLite$scaleDomainSpec(sdType));
			}
		case 'SRange':
			var range = scaleProp.a;
			switch (range.$) {
				case 'RMinNumber':
					var x = range.a;
					return _Utils_Tuple2(
						'rangeMin',
						$elm$json$Json$Encode$float(x));
				case 'RMaxNumber':
					var x = range.a;
					return _Utils_Tuple2(
						'rangeMax',
						$elm$json$Json$Encode$float(x));
				case 'RNumbers':
					var xs = range.a;
					return _Utils_Tuple2(
						'range',
						A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$float, xs));
				case 'RNumberLists':
					var xss = range.a;
					return _Utils_Tuple2(
						'range',
						A2(
							$elm$json$Json$Encode$list,
							$elm$json$Json$Encode$list($elm$json$Json$Encode$float),
							xss));
				case 'RStrings':
					var ss = range.a;
					return _Utils_Tuple2(
						'range',
						A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$string, ss));
				case 'RName':
					var s = range.a;
					return _Utils_Tuple2(
						'range',
						$elm$json$Json$Encode$string(s));
				default:
					var s = range.a;
					return _Utils_Tuple2(
						'range',
						$elm$json$Json$Encode$object(
							_List_fromArray(
								[
									_Utils_Tuple2(
									'field',
									$elm$json$Json$Encode$string(s))
								])));
			}
		case 'SScheme':
			var schName = scaleProp.a;
			var extent = scaleProp.b;
			return A2($author$project$VegaLite$schemeProperty, schName, extent);
		case 'SAlign':
			var x = scaleProp.a;
			return _Utils_Tuple2(
				'align',
				$elm$json$Json$Encode$float(x));
		case 'SPadding':
			var x = scaleProp.a;
			return _Utils_Tuple2(
				'padding',
				$elm$json$Json$Encode$float(x));
		case 'SBase':
			var x = scaleProp.a;
			return _Utils_Tuple2(
				'base',
				$elm$json$Json$Encode$float(x));
		case 'SExponent':
			var x = scaleProp.a;
			return _Utils_Tuple2(
				'exponent',
				$elm$json$Json$Encode$float(x));
		case 'SDomainMid':
			var x = scaleProp.a;
			return _Utils_Tuple2(
				'domainMid',
				$elm$json$Json$Encode$float(x));
		case 'SConstant':
			var x = scaleProp.a;
			return _Utils_Tuple2(
				'constant',
				$elm$json$Json$Encode$float(x));
		case 'SPaddingInner':
			var x = scaleProp.a;
			return _Utils_Tuple2(
				'paddingInner',
				$elm$json$Json$Encode$float(x));
		case 'SPaddingOuter':
			var x = scaleProp.a;
			return _Utils_Tuple2(
				'paddingOuter',
				$elm$json$Json$Encode$float(x));
		case 'SRound':
			var b = scaleProp.a;
			return _Utils_Tuple2(
				'round',
				$elm$json$Json$Encode$bool(b));
		case 'SClamp':
			var b = scaleProp.a;
			return _Utils_Tuple2(
				'clamp',
				$elm$json$Json$Encode$bool(b));
		case 'SInterpolate':
			var interp = scaleProp.a;
			return _Utils_Tuple2(
				'interpolate',
				$author$project$VegaLite$cInterpolateSpec(interp));
		case 'SNice':
			var ni = scaleProp.a;
			return _Utils_Tuple2(
				'nice',
				$author$project$VegaLite$scaleNiceSpec(ni));
		case 'SZero':
			var b = scaleProp.a;
			return _Utils_Tuple2(
				'zero',
				$elm$json$Json$Encode$bool(b));
		default:
			var b = scaleProp.a;
			return _Utils_Tuple2(
				'reverse',
				$elm$json$Json$Encode$bool(b));
	}
};
var $author$project$VegaLite$sortProperties = function (sp) {
	switch (sp.$) {
		case 'Ascending':
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'order',
					$elm$json$Json$Encode$string('ascending'))
				]);
		case 'Descending':
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'order',
					$elm$json$Json$Encode$string('descending'))
				]);
		case 'ByChannel':
			var ch = sp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'encoding',
					$elm$json$Json$Encode$string(
						$author$project$VegaLite$channelLabel(ch)))
				]);
		case 'ByFieldOp':
			var field = sp.a;
			var op = sp.b;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'field',
					$elm$json$Json$Encode$string(field)),
					_Utils_Tuple2(
					'op',
					$author$project$VegaLite$operationSpec(op))
				]);
		case 'ByRepeatOp':
			var arr = sp.a;
			var op = sp.b;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'field',
					$elm$json$Json$Encode$object(
						_List_fromArray(
							[
								_Utils_Tuple2(
								'repeat',
								$elm$json$Json$Encode$string(
									$author$project$VegaLite$arrangementLabel(arr)))
							]))),
					_Utils_Tuple2(
					'op',
					$author$project$VegaLite$operationSpec(op))
				]);
		default:
			return _List_Nil;
	}
};
var $author$project$VegaLite$timeUnitProperties = function (tUnit) {
	switch (tUnit.$) {
		case 'Utc':
			var tu = tUnit.a;
			return A2(
				$elm$core$List$cons,
				_Utils_Tuple2(
					'utc',
					$elm$json$Json$Encode$bool(true)),
				$author$project$VegaLite$timeUnitProperties(tu));
		case 'TUMaxBins':
			var n = tUnit.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'maxbins',
					$elm$json$Json$Encode$int(n))
				]);
		case 'TUStep':
			var x = tUnit.a;
			var tu = tUnit.b;
			return A2(
				$elm$core$List$cons,
				_Utils_Tuple2(
					'step',
					$elm$json$Json$Encode$float(x)),
				$author$project$VegaLite$timeUnitProperties(tu));
		default:
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'unit',
					$elm$json$Json$Encode$string(
						$author$project$VegaLite$timeUnitLabel(tUnit)))
				]);
	}
};
var $author$project$VegaLite$timeUnitSpec = function (tUnit) {
	return $elm$json$Json$Encode$object(
		$author$project$VegaLite$timeUnitProperties(tUnit));
};
var $author$project$VegaLite$booleanOpSpec = function (bo) {
	switch (bo.$) {
		case 'Expr':
			var ex = bo.a;
			return $elm$json$Json$Encode$string(ex);
		case 'FilterOp':
			var f = bo.a;
			return $author$project$VegaLite$filterSpec(f);
		case 'FilterOpTrans':
			var tr = bo.a;
			var f = bo.b;
			return A2($author$project$VegaLite$trFilterSpec, tr, f);
		case 'And':
			var operand1 = bo.a;
			var operand2 = bo.b;
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'and',
						A2(
							$elm$json$Json$Encode$list,
							$author$project$VegaLite$booleanOpSpec,
							_List_fromArray(
								[operand1, operand2])))
					]));
		case 'Or':
			var operand1 = bo.a;
			var operand2 = bo.b;
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'or',
						A2(
							$elm$json$Json$Encode$list,
							$author$project$VegaLite$booleanOpSpec,
							_List_fromArray(
								[operand1, operand2])))
					]));
		case 'Not':
			var operand = bo.a;
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'not',
						$author$project$VegaLite$booleanOpSpec(operand))
					]));
		case 'BooleanParam':
			var p = bo.a;
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'param',
						$elm$json$Json$Encode$string(p))
					]));
		case 'SelectionName':
			var selName = bo.a;
			return $elm$json$Json$Encode$string(selName);
		default:
			var sel = bo.a;
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'selection',
						$elm$json$Json$Encode$string(sel))
					]));
	}
};
var $author$project$VegaLite$filterSpec = function (f) {
	switch (f.$) {
		case 'FExpr':
			var ex = f.a;
			return $elm$json$Json$Encode$string(ex);
		case 'FCompose':
			var boolExpr = f.a;
			return $author$project$VegaLite$booleanOpSpec(boolExpr);
		default:
			return $elm$json$Json$Encode$object(
				$author$project$VegaLite$filterProperties(f));
	}
};
var $author$project$VegaLite$markChannelProperties = function (field) {
	switch (field.$) {
		case 'MName':
			var s = field.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'field',
					$elm$json$Json$Encode$string(s))
				]);
		case 'MDatum':
			var d = field.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'datum',
					$author$project$VegaLite$dataValueSpec(d))
				]);
		case 'MRepeat':
			var arr = field.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'field',
					$elm$json$Json$Encode$object(
						_List_fromArray(
							[
								_Utils_Tuple2(
								'repeat',
								$elm$json$Json$Encode$string(
									$author$project$VegaLite$arrangementLabel(arr)))
							])))
				]);
		case 'MRepeatDatum':
			var arr = field.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'datum',
					$elm$json$Json$Encode$object(
						_List_fromArray(
							[
								_Utils_Tuple2(
								'repeat',
								$elm$json$Json$Encode$string(
									$author$project$VegaLite$arrangementLabel(arr)))
							])))
				]);
		case 'MmType':
			var t = field.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'type',
					$elm$json$Json$Encode$string(
						$author$project$VegaLite$measurementLabel(t)))
				]);
		case 'MScale':
			var sps = field.a;
			return _Utils_eq(sps, _List_Nil) ? _List_fromArray(
				[
					_Utils_Tuple2('scale', $elm$json$Json$Encode$null)
				]) : _List_fromArray(
				[
					_Utils_Tuple2(
					'scale',
					$elm$json$Json$Encode$object(
						A2($elm$core$List$map, $author$project$VegaLite$scaleProperty, sps)))
				]);
		case 'MLegend':
			var lps = field.a;
			return _Utils_eq(lps, _List_Nil) ? _List_fromArray(
				[
					_Utils_Tuple2('legend', $elm$json$Json$Encode$null)
				]) : _List_fromArray(
				[
					_Utils_Tuple2(
					'legend',
					$elm$json$Json$Encode$object(
						A2($elm$core$List$concatMap, $author$project$VegaLite$legendProperty, lps)))
				]);
		case 'MBin':
			var bps = field.a;
			return _List_fromArray(
				[
					$author$project$VegaLite$bin(bps)
				]);
		case 'MBand':
			var x = field.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'band',
					$elm$json$Json$Encode$float(x))
				]);
		case 'MSort':
			var sps = field.a;
			_v3$4:
			while (true) {
				if (!sps.b) {
					return _List_fromArray(
						[
							_Utils_Tuple2('sort', $elm$json$Json$Encode$null)
						]);
				} else {
					if (!sps.b.b) {
						switch (sps.a.$) {
							case 'Ascending':
								var _v4 = sps.a;
								return _List_fromArray(
									[
										_Utils_Tuple2(
										'sort',
										$elm$json$Json$Encode$string('ascending'))
									]);
							case 'Descending':
								var _v5 = sps.a;
								return _List_fromArray(
									[
										_Utils_Tuple2(
										'sort',
										$elm$json$Json$Encode$string('descending'))
									]);
							case 'CustomSort':
								var dvs = sps.a.a;
								return _List_fromArray(
									[
										_Utils_Tuple2(
										'sort',
										$author$project$VegaLite$toList(
											$author$project$VegaLite$dataValuesSpecs(dvs)))
									]);
							default:
								break _v3$4;
						}
					} else {
						break _v3$4;
					}
				}
			}
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'sort',
					$elm$json$Json$Encode$object(
						A2($elm$core$List$concatMap, $author$project$VegaLite$sortProperties, sps)))
				]);
		case 'MBinned':
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'bin',
					$elm$json$Json$Encode$string('binned'))
				]);
		case 'MCondition':
			var predicate = field.a;
			var ifClause = field.b;
			var elseClause = field.c;
			return A2(
				$elm$core$List$cons,
				_Utils_Tuple2(
					'condition',
					$elm$json$Json$Encode$object(
						_Utils_ap(
							$author$project$VegaLite$predicateProperties(predicate),
							A2($elm$core$List$concatMap, $author$project$VegaLite$markChannelProperties, ifClause)))),
				A2($elm$core$List$concatMap, $author$project$VegaLite$markChannelProperties, elseClause));
		case 'MConditions':
			var ifClauses = field.a;
			var elseClause = field.b;
			return A2(
				$elm$core$List$cons,
				_Utils_Tuple2(
					'condition',
					A2(
						$elm$json$Json$Encode$list,
						function (_v6) {
							var predicate = _v6.a;
							var ifClause = _v6.b;
							return $elm$json$Json$Encode$object(
								_Utils_ap(
									$author$project$VegaLite$predicateProperties(predicate),
									A2($elm$core$List$concatMap, $author$project$VegaLite$markChannelProperties, ifClause)));
						},
						ifClauses)),
				A2($elm$core$List$concatMap, $author$project$VegaLite$markChannelProperties, elseClause));
		case 'MDataCondition':
			var isSelection = field.a;
			var tests = field.b;
			var elseClause = field.c;
			var testClause = function (_v8) {
				var predicate = _v8.a;
				var ifClause = _v8.b;
				return isSelection ? $elm$json$Json$Encode$object(
					A2(
						$elm$core$List$cons,
						_Utils_Tuple2(
							'selection',
							$author$project$VegaLite$booleanOpSpec(predicate)),
						A2($elm$core$List$concatMap, $author$project$VegaLite$markChannelProperties, ifClause))) : $elm$json$Json$Encode$object(
					A2(
						$elm$core$List$cons,
						_Utils_Tuple2(
							'test',
							$author$project$VegaLite$booleanOpSpec(predicate)),
						A2($elm$core$List$concatMap, $author$project$VegaLite$markChannelProperties, ifClause)));
			};
			return A2(
				$elm$core$List$cons,
				_Utils_Tuple2(
					'condition',
					function () {
						if (tests.b && (!tests.b.b)) {
							var test = tests.a;
							return testClause(test);
						} else {
							return A2($elm$json$Json$Encode$list, testClause, tests);
						}
					}()),
				A2($elm$core$List$concatMap, $author$project$VegaLite$markChannelProperties, elseClause));
		case 'MTimeUnit':
			var tu = field.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'timeUnit',
					$author$project$VegaLite$timeUnitSpec(tu))
				]);
		case 'MTitle':
			var t = field.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'title',
					$author$project$VegaLite$multilineTextSpec(t))
				]);
		case 'MAggregate':
			var op = field.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'aggregate',
					$author$project$VegaLite$operationSpec(op))
				]);
		case 'MPath':
			var s = field.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'value',
					$elm$json$Json$Encode$string(s))
				]);
		case 'MNumber':
			var x = field.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'value',
					$elm$json$Json$Encode$float(x))
				]);
		case 'MString':
			var s = field.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'value',
					$elm$json$Json$Encode$string(s))
				]);
		default:
			var b = field.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'value',
					$elm$json$Json$Encode$bool(b))
				]);
	}
};
var $author$project$VegaLite$predicateProperties = function (predicate) {
	switch (predicate.$) {
		case 'Param':
			var p = predicate.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'param',
					$elm$json$Json$Encode$string(p))
				]);
		case 'ParamEmpty':
			var p = predicate.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'param',
					$elm$json$Json$Encode$string(p)),
					_Utils_Tuple2(
					'empty',
					$elm$json$Json$Encode$bool(false))
				]);
		default:
			var bo = predicate.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'test',
					$author$project$VegaLite$booleanOpSpec(bo))
				]);
	}
};
var $author$project$VegaLite$trFilterSpec = F2(
	function (mc, f) {
		switch (f.$) {
			case 'FExpr':
				var ex = f.a;
				return $elm$json$Json$Encode$string(ex);
			case 'FCompose':
				var boolExpr = f.a;
				return $author$project$VegaLite$booleanOpSpec(boolExpr);
			default:
				return $elm$json$Json$Encode$object(
					_Utils_ap(
						$author$project$VegaLite$markChannelProperties(mc),
						$author$project$VegaLite$filterProperties(f)));
		}
	});
var $elm$core$List$head = function (list) {
	if (list.b) {
		var x = list.a;
		var xs = list.b;
		return $elm$core$Maybe$Just(x);
	} else {
		return $elm$core$Maybe$Nothing;
	}
};
var $elm$core$Tuple$second = function (_v0) {
	var y = _v0.b;
	return y;
};
var $author$project$VegaLite$sideSpec = function (side) {
	switch (side.$) {
		case 'STop':
			return $elm$json$Json$Encode$string('top');
		case 'SBottom':
			return $elm$json$Json$Encode$string('bottom');
		case 'SLeft':
			return $elm$json$Json$Encode$string('left');
		case 'SRight':
			return $elm$json$Json$Encode$string('right');
		default:
			var ex = side.a;
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'expr',
						$elm$json$Json$Encode$string(ex))
					]));
	}
};
var $elm$core$Maybe$withDefault = F2(
	function (_default, maybe) {
		if (maybe.$ === 'Just') {
			var value = maybe.a;
			return value;
		} else {
			return _default;
		}
	});
var $author$project$VegaLite$axisProperty = function (axisProp) {
	switch (axisProp.$) {
		case 'AxAria':
			var aps = axisProp.a;
			if (!aps.b) {
				return _List_fromArray(
					[
						$author$project$VegaLite$ariaProperty(
						$author$project$VegaLite$ArAria(false))
					]);
			} else {
				return A2($elm$core$List$map, $author$project$VegaLite$ariaProperty, aps);
			}
		case 'AxBandPosition':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'bandPosition', n);
		case 'AxDataCondition':
			var predicate = axisProp.a;
			var cap = axisProp.b;
			var firstProp = A2(
				$elm$core$Basics$composeR,
				$elm$core$List$head,
				$elm$core$Maybe$withDefault(
					_Utils_Tuple2('', $elm$json$Json$Encode$null)));
			var _v2 = function () {
				switch (cap.$) {
					case 'CAxLabelAlign':
						var ha1 = cap.a;
						var ha2 = cap.b;
						return _Utils_Tuple2(
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$AxLabelAlign(ha1))),
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axLabelAlign(ha2))));
					case 'CAxLabelBaseline':
						var va1 = cap.a;
						var va2 = cap.b;
						return _Utils_Tuple2(
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axLabelBaseline(va1))),
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axLabelBaseline(va2))));
					case 'CAxLabelColor':
						var c1 = cap.a;
						var c2 = cap.b;
						return _Utils_Tuple2(
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axLabelColor(c1))),
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axLabelColor(c2))));
					case 'CAxLabelFont':
						var f1 = cap.a;
						var f2 = cap.b;
						return _Utils_Tuple2(
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axLabelFont(f1))),
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axLabelFont(f2))));
					case 'CAxLabelFontSize':
						var s1 = cap.a;
						var s2 = cap.b;
						return _Utils_Tuple2(
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axLabelFontSize(s1))),
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axLabelFontSize(s2))));
					case 'CAxLabelFontStyle':
						var s1 = cap.a;
						var s2 = cap.b;
						return _Utils_Tuple2(
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axLabelFontStyle(s1))),
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axLabelFontStyle(s2))));
					case 'CAxLabelFontWeight':
						var w1 = cap.a;
						var w2 = cap.b;
						return _Utils_Tuple2(
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axLabelFontWeight(w1))),
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axLabelFontWeight(w2))));
					case 'CAxLabelOffset':
						var o1 = cap.a;
						var o2 = cap.b;
						return _Utils_Tuple2(
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axLabelOffset(o1))),
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axLabelOffset(o2))));
					case 'CAxLabelOpacity':
						var o1 = cap.a;
						var o2 = cap.b;
						return _Utils_Tuple2(
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axLabelOpacity(o1))),
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axLabelOpacity(o2))));
					case 'CAxLabelPadding':
						var p1 = cap.a;
						var p2 = cap.b;
						return _Utils_Tuple2(
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axLabelPadding(p1))),
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axLabelPadding(p2))));
					case 'CAxTickColor':
						var c1 = cap.a;
						var c2 = cap.b;
						return _Utils_Tuple2(
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axTickColor(c1))),
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axTickColor(c2))));
					case 'CAxTickDash':
						var d1 = cap.a;
						var d2 = cap.b;
						return _Utils_Tuple2(
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axTickDash(d1))),
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axTickDash(d2))));
					case 'CAxTickDashOffset':
						var o1 = cap.a;
						var o2 = cap.b;
						return _Utils_Tuple2(
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axTickDashOffset(o1))),
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axTickDashOffset(o2))));
					case 'CAxTickOpacity':
						var o1 = cap.a;
						var o2 = cap.b;
						return _Utils_Tuple2(
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axTickOpacity(o1))),
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axTickOpacity(o2))));
					case 'CAxTickSize':
						var s1 = cap.a;
						var s2 = cap.b;
						return _Utils_Tuple2(
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axTickSize(s1))),
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axTickSize(s2))));
					case 'CAxTickWidth':
						var w1 = cap.a;
						var w2 = cap.b;
						return _Utils_Tuple2(
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axTickWidth(w1))),
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axTickWidth(w2))));
					case 'CAxGridColor':
						var c1 = cap.a;
						var c2 = cap.b;
						return _Utils_Tuple2(
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axGridColor(c1))),
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axGridColor(c2))));
					case 'CAxGridDash':
						var d1 = cap.a;
						var d2 = cap.b;
						return _Utils_Tuple2(
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axGridDash(d1))),
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axGridDash(d2))));
					case 'CAxGridDashOffset':
						var o1 = cap.a;
						var o2 = cap.b;
						return _Utils_Tuple2(
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axGridDashOffset(o1))),
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axGridDashOffset(o2))));
					case 'CAxGridOpacity':
						var o1 = cap.a;
						var o2 = cap.b;
						return _Utils_Tuple2(
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axGridOpacity(o1))),
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axGridOpacity(o2))));
					default:
						var w1 = cap.a;
						var w2 = cap.b;
						return _Utils_Tuple2(
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axGridWidth(w1))),
							firstProp(
								$author$project$VegaLite$axisProperty(
									$author$project$VegaLite$axGridWidth(w2))));
				}
			}();
			var ifProp = _v2.a;
			var elseProp = _v2.b;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					ifProp.a,
					$elm$json$Json$Encode$object(
						_List_fromArray(
							[
								_Utils_Tuple2(
								'condition',
								$elm$json$Json$Encode$object(
									_List_fromArray(
										[
											_Utils_Tuple2(
											'test',
											$author$project$VegaLite$booleanOpSpec(predicate)),
											_Utils_Tuple2('value', ifProp.b)
										]))),
								_Utils_Tuple2('value', elseProp.b)
							])))
				]);
		case 'AxFormat':
			var s = axisProp.a;
			return A2($author$project$VegaLite$strExpr, 'format', s);
		case 'AxFormatAsNum':
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'formatType',
					$elm$json$Json$Encode$string('number'))
				]);
		case 'AxFormatAsTemporal':
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'formatType',
					$elm$json$Json$Encode$string('time'))
				]);
		case 'AxFormatAsCustom':
			var s = axisProp.a;
			return A2($author$project$VegaLite$strExpr, 'formatType', s);
		case 'AxGridCap':
			var c = axisProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'gridCap',
					$author$project$VegaLite$strokeCapSpec(c))
				]);
		case 'AxGridColor':
			var s = axisProp.a;
			return A2($author$project$VegaLite$strExpr, 'gridColor', s);
		case 'AxGridDash':
			var ds = axisProp.a;
			return _Utils_eq(ds, _List_Nil) ? _List_fromArray(
				[
					_Utils_Tuple2('gridDash', $elm$json$Json$Encode$null)
				]) : _List_fromArray(
				[
					_Utils_Tuple2(
					'gridDash',
					A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$float, ds))
				]);
		case 'AxGridDashOffset':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'gridDashOffset', n);
		case 'AxGridOpacity':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'gridOpacity', n);
		case 'AxGridWidth':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'gridWidth', n);
		case 'AxLabels':
			var b = axisProp.a;
			return A2($author$project$VegaLite$booExpr, 'labels', b);
		case 'AxLabelAlign':
			var ha = axisProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labelAlign',
					$author$project$VegaLite$hAlignSpec(ha))
				]);
		case 'AxLabelBaseline':
			var va = axisProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labelBaseline',
					$author$project$VegaLite$vAlignSpec(va))
				]);
		case 'AxLabelBound':
			var mn = axisProp.a;
			if (mn.$ === 'Just') {
				var n = mn.a;
				return (n === 1) ? _List_fromArray(
					[
						_Utils_Tuple2(
						'labelBound',
						$elm$json$Json$Encode$bool(true))
					]) : _List_fromArray(
					[
						_Utils_Tuple2(
						'labelBound',
						$elm$json$Json$Encode$float(n))
					]);
			} else {
				return _List_fromArray(
					[
						_Utils_Tuple2(
						'labelBound',
						$elm$json$Json$Encode$bool(false))
					]);
			}
		case 'AxLabelAngle':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'labelAngle', n);
		case 'AxLabelColor':
			var s = axisProp.a;
			return A2($author$project$VegaLite$strExpr, 'labelColor', s);
		case 'AxLabelExpr':
			var s = axisProp.a;
			return A2($author$project$VegaLite$strExpr, 'labelExpr', s);
		case 'AxLabelFlush':
			var mn = axisProp.a;
			if (mn.$ === 'Just') {
				var n = mn.a;
				return (n === 1) ? _List_fromArray(
					[
						_Utils_Tuple2(
						'labelFlush',
						$elm$json$Json$Encode$bool(true))
					]) : _List_fromArray(
					[
						_Utils_Tuple2(
						'labelFlush',
						$elm$json$Json$Encode$float(n))
					]);
			} else {
				return _List_fromArray(
					[
						_Utils_Tuple2(
						'labelFlush',
						$elm$json$Json$Encode$bool(false))
					]);
			}
		case 'AxLabelFlushOffset':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'labelFlushOffset', n);
		case 'AxLabelFont':
			var s = axisProp.a;
			return A2($author$project$VegaLite$strExpr, 'labelFont', s);
		case 'AxLabelFontSize':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'labelFontSize', n);
		case 'AxLabelFontStyle':
			var s = axisProp.a;
			return A2($author$project$VegaLite$strExpr, 'labelFontStyle', s);
		case 'AxLabelFontWeight':
			var fw = axisProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labelFontWeight',
					$author$project$VegaLite$fontWeightSpec(fw))
				]);
		case 'AxLabelLimit':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'labelLimit', n);
		case 'AxLabelLineHeight':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'labelLineHeight', n);
		case 'AxLabelOffset':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'labelOffset', n);
		case 'AxLabelOpacity':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'labelOpacity', n);
		case 'AxLabelOverlap':
			var strat = axisProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labelOverlap',
					$author$project$VegaLite$overlapStrategySpec(strat))
				]);
		case 'AxLabelPadding':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'labelPadding', n);
		case 'AxLabelSeparation':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'labelSeparation', n);
		case 'AxDomain':
			var b = axisProp.a;
			return A2($author$project$VegaLite$booExpr, 'domain', b);
		case 'AxDomainCap':
			var c = axisProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'domainCap',
					$author$project$VegaLite$strokeCapSpec(c))
				]);
		case 'AxDomainColor':
			var s = axisProp.a;
			return A2($author$project$VegaLite$strExpr, 'domainColor', s);
		case 'AxDomainDash':
			var ds = axisProp.a;
			return _Utils_eq(ds, _List_Nil) ? _List_fromArray(
				[
					_Utils_Tuple2('domainDash', $elm$json$Json$Encode$null)
				]) : _List_fromArray(
				[
					_Utils_Tuple2(
					'domainDash',
					A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$float, ds))
				]);
		case 'AxDomainDashOffset':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'domainDashOffset', n);
		case 'AxDomainOpacity':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'domainOpacity', n);
		case 'AxDomainWidth':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'domainWidth', n);
		case 'AxGrid':
			var b = axisProp.a;
			return A2($author$project$VegaLite$booExpr, 'grid', b);
		case 'AxMaxExtent':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'maxExtent', n);
		case 'AxMinExtent':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'minExtent', n);
		case 'AxOrient':
			var side = axisProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'orient',
					$author$project$VegaLite$sideSpec(side))
				]);
		case 'AxOffset':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'offset', n);
		case 'AxPosition':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'position', n);
		case 'AxTranslate':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'translate', n);
		case 'AxStyle':
			var ss = axisProp.a;
			if (ss.b && (!ss.b.b)) {
				var s = ss.a;
				return _List_fromArray(
					[
						_Utils_Tuple2(
						'style',
						$elm$json$Json$Encode$string(s))
					]);
			} else {
				return _List_fromArray(
					[
						_Utils_Tuple2(
						'style',
						A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$string, ss))
					]);
			}
		case 'AxZIndex':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'zindex', n);
		case 'AxTicks':
			var b = axisProp.a;
			return A2($author$project$VegaLite$booExpr, 'ticks', b);
		case 'AxTickCap':
			var c = axisProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'tickCap',
					$author$project$VegaLite$strokeCapSpec(c))
				]);
		case 'AxTickColor':
			var s = axisProp.a;
			return A2($author$project$VegaLite$strExpr, 'tickColor', s);
		case 'AxTickCount':
			var tc = axisProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'tickCount',
					$author$project$VegaLite$scaleNiceSpec(tc))
				]);
		case 'AxTickDash':
			var ds = axisProp.a;
			return _Utils_eq(ds, _List_Nil) ? _List_fromArray(
				[
					_Utils_Tuple2('tickDash', $elm$json$Json$Encode$null)
				]) : _List_fromArray(
				[
					_Utils_Tuple2(
					'tickDash',
					A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$float, ds))
				]);
		case 'AxTickDashOffset':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'tickDashOffset', n);
		case 'AxTickExtra':
			var b = axisProp.a;
			return A2($author$project$VegaLite$booExpr, 'tickExtra', b);
		case 'AxTickOffset':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'tickOffset', n);
		case 'AxTickOpacity':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'tickOpacity', n);
		case 'AxTickRound':
			var b = axisProp.a;
			return A2($author$project$VegaLite$booExpr, 'tickRound', b);
		case 'AxTickMinStep':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'tickMinStep', n);
		case 'AxTickSize':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'tickSize', n);
		case 'AxTickWidth':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'tickWidth', n);
		case 'AxValues':
			var vals = axisProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'values',
					$author$project$VegaLite$toList(
						$author$project$VegaLite$dataValuesSpecs(vals)))
				]);
		case 'AxTitle':
			var s = axisProp.a;
			if (s.$ === 'Str') {
				var ttl = s.a;
				return _List_fromArray(
					[
						_Utils_Tuple2(
						'title',
						$author$project$VegaLite$multilineTextSpec(ttl))
					]);
			} else {
				return A2($author$project$VegaLite$strExpr, 'title', s);
			}
		case 'AxTitleAlign':
			var al = axisProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titleAlign',
					$author$project$VegaLite$hAlignSpec(al))
				]);
		case 'AxTitleAngle':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'titleAngle', n);
		case 'AxTitleAnchor':
			var an = axisProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titleAnchor',
					$author$project$VegaLite$anchorSpec(an))
				]);
		case 'AxTitleBaseline':
			var va = axisProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titleBaseline',
					$author$project$VegaLite$vAlignSpec(va))
				]);
		case 'AxTitleColor':
			var s = axisProp.a;
			return A2($author$project$VegaLite$strExpr, 'titleColor', s);
		case 'AxTitleFont':
			var s = axisProp.a;
			return A2($author$project$VegaLite$strExpr, 'titleFont', s);
		case 'AxTitleFontSize':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'titleFontSize', n);
		case 'AxTitleFontStyle':
			var s = axisProp.a;
			return A2($author$project$VegaLite$strExpr, 'titleFontStyle', s);
		case 'AxTitleFontWeight':
			var fw = axisProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titleFontWeight',
					$author$project$VegaLite$fontWeightSpec(fw))
				]);
		case 'AxTitleLimit':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'titleLimit', n);
		case 'AxTitleLineHeight':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'titleLineHeight', n);
		case 'AxTitleOpacity':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'titleOpacity', n);
		case 'AxTitlePadding':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'titlePadding', n);
		case 'AxTitleX':
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'titleX', n);
		default:
			var n = axisProp.a;
			return A2($author$project$VegaLite$numExpr, 'titleY', n);
	}
};
var $author$project$VegaLite$concatConfigProperty = function (ccp) {
	if (ccp.$ === 'CoColumns') {
		var n = ccp.a;
		return _Utils_Tuple2(
			'columns',
			$elm$json$Json$Encode$int(n));
	} else {
		var x = ccp.a;
		return _Utils_Tuple2(
			'spacing',
			$elm$json$Json$Encode$float(x));
	}
};
var $author$project$VegaLite$facetConfigProperty = function (fcp) {
	if (fcp.$ === 'FCColumns') {
		var n = fcp.a;
		return _Utils_Tuple2(
			'columns',
			$elm$json$Json$Encode$int(n));
	} else {
		var x = fcp.a;
		return _Utils_Tuple2(
			'spacing',
			$elm$json$Json$Encode$float(x));
	}
};
var $author$project$VegaLite$fieldTitleLabel = function (ftp) {
	switch (ftp.$) {
		case 'FTVerbal':
			return 'verbal';
		case 'FTFunction':
			return 'functional';
		default:
			return 'plain';
	}
};
var $author$project$VegaLite$headerProperty = function (hProp) {
	switch (hProp.$) {
		case 'HFormat':
			var fmt = hProp.a;
			return _Utils_Tuple2(
				'format',
				$elm$json$Json$Encode$string(fmt));
		case 'HFormatAsNum':
			return _Utils_Tuple2(
				'formatType',
				$elm$json$Json$Encode$string('number'));
		case 'HFormatAsTemporal':
			return _Utils_Tuple2(
				'formatType',
				$elm$json$Json$Encode$string('time'));
		case 'HFormatAsCustom':
			var formatter = hProp.a;
			return _Utils_Tuple2(
				'formatType',
				$elm$json$Json$Encode$string(formatter));
		case 'HLabelAlign':
			var ha = hProp.a;
			return _Utils_Tuple2(
				'labelAlign',
				$author$project$VegaLite$hAlignSpec(ha));
		case 'HLabelAnchor':
			var a = hProp.a;
			return _Utils_Tuple2(
				'labelAnchor',
				$author$project$VegaLite$anchorSpec(a));
		case 'HLabelAngle':
			var x = hProp.a;
			return _Utils_Tuple2(
				'labelAngle',
				$elm$json$Json$Encode$float(x));
		case 'HLabelBaseline':
			var va = hProp.a;
			return _Utils_Tuple2(
				'labelBaseline',
				$author$project$VegaLite$vAlignSpec(va));
		case 'HLabelColor':
			var s = hProp.a;
			return _Utils_Tuple2(
				'labelColor',
				$elm$json$Json$Encode$string(s));
		case 'HLabelExpr':
			var s = hProp.a;
			return _Utils_Tuple2(
				'labelExpr',
				$elm$json$Json$Encode$string(s));
		case 'HLabelFont':
			var s = hProp.a;
			return _Utils_Tuple2(
				'labelFont',
				$elm$json$Json$Encode$string(s));
		case 'HLabelFontSize':
			var x = hProp.a;
			return _Utils_Tuple2(
				'labelFontSize',
				$elm$json$Json$Encode$float(x));
		case 'HLabelFontStyle':
			var s = hProp.a;
			return _Utils_Tuple2(
				'labelFontStyle',
				$elm$json$Json$Encode$string(s));
		case 'HLabelFontWeight':
			var fw = hProp.a;
			return _Utils_Tuple2(
				'labelFontWeight',
				$author$project$VegaLite$fontWeightSpec(fw));
		case 'HLabelLimit':
			var x = hProp.a;
			return _Utils_Tuple2(
				'labelLimit',
				$elm$json$Json$Encode$float(x));
		case 'HLabelLineHeight':
			var x = hProp.a;
			return _Utils_Tuple2(
				'labelLineHeight',
				$elm$json$Json$Encode$float(x));
		case 'HLabelOrient':
			var orient = hProp.a;
			return _Utils_Tuple2(
				'labelOrient',
				$author$project$VegaLite$sideSpec(orient));
		case 'HLabelPadding':
			var x = hProp.a;
			return _Utils_Tuple2(
				'labelPadding',
				$elm$json$Json$Encode$float(x));
		case 'HLabels':
			var b = hProp.a;
			return _Utils_Tuple2(
				'labels',
				$elm$json$Json$Encode$bool(b));
		case 'HOrient':
			var orient = hProp.a;
			return _Utils_Tuple2(
				'orient',
				$author$project$VegaLite$sideSpec(orient));
		case 'HTitle':
			var s = hProp.a;
			if (s === '') {
				return _Utils_Tuple2('title', $elm$json$Json$Encode$null);
			} else {
				return _Utils_Tuple2(
					'title',
					$author$project$VegaLite$multilineTextSpec(s));
			}
		case 'HTitleAnchor':
			var a = hProp.a;
			return _Utils_Tuple2(
				'titleAnchor',
				$author$project$VegaLite$anchorSpec(a));
		case 'HTitleAlign':
			var ha = hProp.a;
			return _Utils_Tuple2(
				'titleAlign',
				$author$project$VegaLite$hAlignSpec(ha));
		case 'HTitleAngle':
			var x = hProp.a;
			return _Utils_Tuple2(
				'titleAngle',
				$elm$json$Json$Encode$float(x));
		case 'HTitleBaseline':
			var va = hProp.a;
			return _Utils_Tuple2(
				'titleBaseline',
				$author$project$VegaLite$vAlignSpec(va));
		case 'HTitleColor':
			var s = hProp.a;
			return _Utils_Tuple2(
				'titleColor',
				$elm$json$Json$Encode$string(s));
		case 'HTitleFont':
			var s = hProp.a;
			return _Utils_Tuple2(
				'titleFont',
				$elm$json$Json$Encode$string(s));
		case 'HTitleFontWeight':
			var fw = hProp.a;
			return _Utils_Tuple2(
				'titleFontWeight',
				$author$project$VegaLite$fontWeightSpec(fw));
		case 'HTitleFontSize':
			var x = hProp.a;
			return _Utils_Tuple2(
				'titleFontSize',
				$elm$json$Json$Encode$float(x));
		case 'HTitleFontStyle':
			var s = hProp.a;
			return _Utils_Tuple2(
				'titleFontStyle',
				$elm$json$Json$Encode$string(s));
		case 'HTitleLimit':
			var x = hProp.a;
			return _Utils_Tuple2(
				'titleLimit',
				$elm$json$Json$Encode$float(x));
		case 'HTitleLineHeight':
			var x = hProp.a;
			return _Utils_Tuple2(
				'titleLineHeight',
				$elm$json$Json$Encode$float(x));
		case 'HTitleOrient':
			var orient = hProp.a;
			return _Utils_Tuple2(
				'titleOrient',
				$author$project$VegaLite$sideSpec(orient));
		default:
			var x = hProp.a;
			return _Utils_Tuple2(
				'titlePadding',
				$elm$json$Json$Encode$float(x));
	}
};
var $author$project$VegaLite$legendConfigProperty = function (legendConfig) {
	switch (legendConfig.$) {
		case 'LeAria':
			var aps = legendConfig.a;
			if (!aps.b) {
				return _List_fromArray(
					[
						$author$project$VegaLite$ariaProperty(
						$author$project$VegaLite$ArAria(false))
					]);
			} else {
				return A2($elm$core$List$map, $author$project$VegaLite$ariaProperty, aps);
			}
		case 'LeDisable':
			var b = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'disable',
					$elm$json$Json$Encode$bool(b))
				]);
		case 'LeClipHeight':
			var h = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'clipHeight',
					$elm$json$Json$Encode$float(h))
				]);
		case 'LeColumnPadding':
			var n = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'columnPadding',
					$elm$json$Json$Encode$float(n))
				]);
		case 'LeRowPadding':
			var n = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'rowPadding',
					$elm$json$Json$Encode$float(n))
				]);
		case 'LeColumns':
			var n = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'columns',
					$elm$json$Json$Encode$float(n))
				]);
		case 'CornerRadius':
			var r = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'cornerRadius',
					$elm$json$Json$Encode$float(r))
				]);
		case 'FillColor':
			var s = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'fillColor',
					$elm$json$Json$Encode$string(s))
				]);
		case 'Orient':
			var orient = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'orient',
					$elm$json$Json$Encode$string(
						$author$project$VegaLite$legendOrientLabel(orient)))
				]);
		case 'Offset':
			var x = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'offset',
					$elm$json$Json$Encode$float(x))
				]);
		case 'StrokeColor':
			var s = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'strokeColor',
					$elm$json$Json$Encode$string(s))
				]);
		case 'LeStrokeDash':
			var xs = legendConfig.a;
			return _Utils_eq(xs, _List_Nil) ? _List_fromArray(
				[
					_Utils_Tuple2('strokeDash', $elm$json$Json$Encode$null)
				]) : _List_fromArray(
				[
					_Utils_Tuple2(
					'strokeDash',
					A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$float, xs))
				]);
		case 'LeStrokeWidth':
			var x = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'strokeWidth',
					$elm$json$Json$Encode$float(x))
				]);
		case 'LePadding':
			var x = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'padding',
					$elm$json$Json$Encode$float(x))
				]);
		case 'GradientDirection':
			var d = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'gradientDirection',
					$elm$json$Json$Encode$string(
						$author$project$VegaLite$markOrientationLabel(d)))
				]);
		case 'GradientLabelBaseline':
			var va = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'gradientLabelBaseline',
					$author$project$VegaLite$vAlignSpec(va))
				]);
		case 'GradientLabelLimit':
			var x = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'gradientLabelLimit',
					$elm$json$Json$Encode$float(x))
				]);
		case 'GradientLabelOffset':
			var x = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'gradientLabelOffset',
					$elm$json$Json$Encode$float(x))
				]);
		case 'GradientStrokeColor':
			var s = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'gradientStrokeColor',
					$elm$json$Json$Encode$string(s))
				]);
		case 'GradientStrokeWidth':
			var x = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'gradientStrokeWidth',
					$elm$json$Json$Encode$float(x))
				]);
		case 'GradientHeight':
			var x = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'gradientHeight',
					$elm$json$Json$Encode$float(x))
				]);
		case 'GradientWidth':
			var x = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'gradientWidth',
					$elm$json$Json$Encode$float(x))
				]);
		case 'LeGridAlign':
			var ga = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'gridAlign',
					$elm$json$Json$Encode$string(
						$author$project$VegaLite$compositionAlignmentLabel(ga)))
				]);
		case 'LeLabelAlign':
			var ha = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labelAlign',
					$author$project$VegaLite$hAlignSpec(ha))
				]);
		case 'LeLabelBaseline':
			var va = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labelBaseline',
					$author$project$VegaLite$vAlignSpec(va))
				]);
		case 'LeLabelColor':
			var s = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labelColor',
					$elm$json$Json$Encode$string(s))
				]);
		case 'LeLabelFont':
			var s = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labelFont',
					$elm$json$Json$Encode$string(s))
				]);
		case 'LeLabelFontSize':
			var x = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labelFontSize',
					$elm$json$Json$Encode$float(x))
				]);
		case 'LeLabelLimit':
			var x = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labelLimit',
					$elm$json$Json$Encode$float(x))
				]);
		case 'LeLabelOffset':
			var x = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labelOffset',
					$elm$json$Json$Encode$float(x))
				]);
		case 'LeLabelOverlap':
			var lo = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'labelOverlap',
					$author$project$VegaLite$overlapStrategySpec(lo))
				]);
		case 'LeShortTimeLabels':
			var b = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'shortTimeLabels',
					$elm$json$Json$Encode$bool(b))
				]);
		case 'EntryPadding':
			var x = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'entryPadding',
					$elm$json$Json$Encode$float(x))
				]);
		case 'SymbolDirection':
			var d = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'symbolDirection',
					$elm$json$Json$Encode$string(
						$author$project$VegaLite$markOrientationLabel(d)))
				]);
		case 'SymbolLimit':
			var n = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'symbolLimit',
					$elm$json$Json$Encode$int(n))
				]);
		case 'SymbolFillColor':
			var s = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'symbolFillColor',
					$elm$json$Json$Encode$string(s))
				]);
		case 'SymbolBaseFillColor':
			var s = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'symbolBaseFillColor',
					$elm$json$Json$Encode$string(s))
				]);
		case 'SymbolStrokeColor':
			var s = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'symbolStrokeColor',
					$elm$json$Json$Encode$string(s))
				]);
		case 'SymbolBaseStrokeColor':
			var s = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'symbolBaseStrokeColor',
					$elm$json$Json$Encode$string(s))
				]);
		case 'SymbolOffset':
			var o = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'symbolOffset',
					$elm$json$Json$Encode$float(o))
				]);
		case 'SymbolType':
			var s = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'symbolType',
					$author$project$VegaLite$symbolSpec(s))
				]);
		case 'SymbolSize':
			var x = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'symbolSize',
					$elm$json$Json$Encode$float(x))
				]);
		case 'SymbolStrokeWidth':
			var x = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'symbolStrokeWidth',
					$elm$json$Json$Encode$float(x))
				]);
		case 'LeTitleAlign':
			var ha = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titleAlign',
					$author$project$VegaLite$hAlignSpec(ha))
				]);
		case 'LeTitleBaseline':
			var va = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titleBaseline',
					$author$project$VegaLite$vAlignSpec(va))
				]);
		case 'LeTitleColor':
			var s = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titleColor',
					$elm$json$Json$Encode$string(s))
				]);
		case 'LeTitleFont':
			var s = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titleFont',
					$elm$json$Json$Encode$string(s))
				]);
		case 'LeTitleFontSize':
			var x = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titleFontSize',
					$elm$json$Json$Encode$float(x))
				]);
		case 'LeTitleFontWeight':
			var fw = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titleFontWeight',
					$author$project$VegaLite$fontWeightSpec(fw))
				]);
		case 'LeTitleLimit':
			var x = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titleLimit',
					$elm$json$Json$Encode$float(x))
				]);
		case 'LeTitleLineHeight':
			var x = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titleLineHeight',
					$elm$json$Json$Encode$float(x))
				]);
		case 'LeTitlePadding':
			var x = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'titlePadding',
					$elm$json$Json$Encode$float(x))
				]);
		default:
			var o = legendConfig.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'unselectedOpacity',
					$elm$json$Json$Encode$float(o))
				]);
	}
};
var $author$project$VegaLite$paddingSpec = function (pad) {
	switch (pad.$) {
		case 'PSize':
			var p = pad.a;
			return $elm$json$Json$Encode$float(p);
		case 'PEdges':
			var l = pad.a;
			var t = pad.b;
			var r = pad.c;
			var b = pad.d;
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'left',
						$elm$json$Json$Encode$float(l)),
						_Utils_Tuple2(
						'top',
						$elm$json$Json$Encode$float(t)),
						_Utils_Tuple2(
						'right',
						$elm$json$Json$Encode$float(r)),
						_Utils_Tuple2(
						'bottom',
						$elm$json$Json$Encode$float(b))
					]));
		case 'PEdgesExpr':
			var l = pad.a;
			var t = pad.b;
			var r = pad.c;
			var b = pad.d;
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'left',
						$elm$json$Json$Encode$object(
							_List_fromArray(
								[
									_Utils_Tuple2(
									'expr',
									$elm$json$Json$Encode$string(l))
								]))),
						_Utils_Tuple2(
						'top',
						$elm$json$Json$Encode$object(
							_List_fromArray(
								[
									_Utils_Tuple2(
									'expr',
									$elm$json$Json$Encode$string(t))
								]))),
						_Utils_Tuple2(
						'right',
						$elm$json$Json$Encode$object(
							_List_fromArray(
								[
									_Utils_Tuple2(
									'expr',
									$elm$json$Json$Encode$string(r))
								]))),
						_Utils_Tuple2(
						'bottom',
						$elm$json$Json$Encode$object(
							_List_fromArray(
								[
									_Utils_Tuple2(
									'expr',
									$elm$json$Json$Encode$string(b))
								])))
					]));
		default:
			var s = pad.a;
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'expr',
						$elm$json$Json$Encode$string(s))
					]));
	}
};
var $author$project$VegaLite$projectionLabel = function (proj) {
	switch (proj.$) {
		case 'Albers':
			return 'albers';
		case 'AlbersUsa':
			return 'albersUsa';
		case 'AzimuthalEqualArea':
			return 'azimuthalEqualArea';
		case 'AzimuthalEquidistant':
			return 'azimuthalEquidistant';
		case 'ConicConformal':
			return 'conicConformal';
		case 'ConicEqualArea':
			return 'conicEqualarea';
		case 'ConicEquidistant':
			return 'conicEquidistant';
		case 'Custom':
			var projName = proj.a;
			return projName;
		case 'EqualEarth':
			return 'equalEarth';
		case 'Equirectangular':
			return 'equirectangular';
		case 'Gnomonic':
			return 'gnomonic';
		case 'Identity':
			return 'identity';
		case 'Mercator':
			return 'mercator';
		case 'NaturalEarth1':
			return 'naturalEarth1';
		case 'Orthographic':
			return 'orthographic';
		case 'Stereographic':
			return 'stereographic';
		default:
			return 'transverseMercator';
	}
};
var $author$project$VegaLite$projectionProperty = function (pp) {
	switch (pp.$) {
		case 'PType':
			var proj = pp.a;
			return _Utils_Tuple2(
				'type',
				$elm$json$Json$Encode$string(
					$author$project$VegaLite$projectionLabel(proj)));
		case 'PClipAngle':
			var numOrNull = pp.a;
			if (numOrNull.$ === 'Just') {
				var x = numOrNull.a;
				return _Utils_Tuple2(
					'clipAngle',
					$elm$json$Json$Encode$float(x));
			} else {
				return _Utils_Tuple2('clipAngle', $elm$json$Json$Encode$null);
			}
		case 'PClipExtent':
			var rClip = pp.a;
			if (rClip.$ === 'NoClip') {
				return _Utils_Tuple2('clipExtent', $elm$json$Json$Encode$null);
			} else {
				var l = rClip.a;
				var t = rClip.b;
				var r = rClip.c;
				var b = rClip.d;
				return _Utils_Tuple2(
					'clipExtent',
					A2(
						$elm$json$Json$Encode$list,
						$elm$json$Json$Encode$float,
						_List_fromArray(
							[l, t, r, b])));
			}
		case 'PReflectX':
			var b = pp.a;
			return _Utils_Tuple2(
				'reflectX',
				$elm$json$Json$Encode$bool(b));
		case 'PReflectY':
			var b = pp.a;
			return _Utils_Tuple2(
				'reflectY',
				$elm$json$Json$Encode$bool(b));
		case 'PCenter':
			var lon = pp.a;
			var lat = pp.b;
			return _Utils_Tuple2(
				'center',
				A2(
					$elm$json$Json$Encode$list,
					$elm$json$Json$Encode$float,
					_List_fromArray(
						[lon, lat])));
		case 'PrScale':
			var sc = pp.a;
			return _Utils_Tuple2(
				'scale',
				$elm$json$Json$Encode$float(sc));
		case 'PrTranslate':
			var tx = pp.a;
			var ty = pp.b;
			return _Utils_Tuple2(
				'translate',
				A2(
					$elm$json$Json$Encode$list,
					$elm$json$Json$Encode$float,
					_List_fromArray(
						[tx, ty])));
		case 'PrRotate':
			var lambda = pp.a;
			var phi = pp.b;
			var gamma = pp.c;
			return _Utils_Tuple2(
				'rotate',
				A2(
					$elm$json$Json$Encode$list,
					$elm$json$Json$Encode$float,
					_List_fromArray(
						[lambda, phi, gamma])));
		case 'PPrecision':
			var pr = pp.a;
			return _Utils_Tuple2(
				'precision',
				$elm$json$Json$Encode$float(pr));
		case 'PCoefficient':
			var x = pp.a;
			return _Utils_Tuple2(
				'coefficient',
				$elm$json$Json$Encode$float(x));
		case 'PDistance':
			var x = pp.a;
			return _Utils_Tuple2(
				'distance',
				$elm$json$Json$Encode$float(x));
		case 'PFraction':
			var x = pp.a;
			return _Utils_Tuple2(
				'fraction',
				$elm$json$Json$Encode$float(x));
		case 'PLobes':
			var n = pp.a;
			return _Utils_Tuple2(
				'lobes',
				$elm$json$Json$Encode$int(n));
		case 'PParallel':
			var x = pp.a;
			return _Utils_Tuple2(
				'parallel',
				$elm$json$Json$Encode$float(x));
		case 'PRadius':
			var x = pp.a;
			return _Utils_Tuple2(
				'radius',
				$elm$json$Json$Encode$float(x));
		case 'PRatio':
			var x = pp.a;
			return _Utils_Tuple2(
				'ratio',
				$elm$json$Json$Encode$float(x));
		case 'PSpacing':
			var x = pp.a;
			return _Utils_Tuple2(
				'spacing',
				$elm$json$Json$Encode$float(x));
		default:
			var x = pp.a;
			return _Utils_Tuple2(
				'tilt',
				$elm$json$Json$Encode$float(x));
	}
};
var $author$project$VegaLite$rangeConfigProperty = function (rangeCfg) {
	switch (rangeCfg.$) {
		case 'RCategory':
			var schemeName = rangeCfg.a;
			return _Utils_Tuple2(
				'category',
				$elm$json$Json$Encode$object(
					_List_fromArray(
						[
							A2($author$project$VegaLite$schemeProperty, schemeName, _List_Nil)
						])));
		case 'RDiverging':
			var schemeName = rangeCfg.a;
			return _Utils_Tuple2(
				'diverging',
				$elm$json$Json$Encode$object(
					_List_fromArray(
						[
							A2($author$project$VegaLite$schemeProperty, schemeName, _List_Nil)
						])));
		case 'RHeatmap':
			var schemeName = rangeCfg.a;
			return _Utils_Tuple2(
				'heatmap',
				$elm$json$Json$Encode$object(
					_List_fromArray(
						[
							A2($author$project$VegaLite$schemeProperty, schemeName, _List_Nil)
						])));
		case 'ROrdinal':
			var schemeName = rangeCfg.a;
			return _Utils_Tuple2(
				'ordinal',
				$elm$json$Json$Encode$object(
					_List_fromArray(
						[
							A2($author$project$VegaLite$schemeProperty, schemeName, _List_Nil)
						])));
		case 'RRamp':
			var schemeName = rangeCfg.a;
			return _Utils_Tuple2(
				'ramp',
				$elm$json$Json$Encode$object(
					_List_fromArray(
						[
							A2($author$project$VegaLite$schemeProperty, schemeName, _List_Nil)
						])));
		default:
			var schemeName = rangeCfg.a;
			return _Utils_Tuple2(
				'symbol',
				$elm$json$Json$Encode$object(
					_List_fromArray(
						[
							A2($author$project$VegaLite$schemeProperty, schemeName, _List_Nil)
						])));
	}
};
var $author$project$VegaLite$scaleConfigProperty = function (scaleCfg) {
	switch (scaleCfg.$) {
		case 'SCBandPaddingInner':
			var x = scaleCfg.a;
			return _Utils_Tuple2(
				'bandPaddingInner',
				$elm$json$Json$Encode$float(x));
		case 'SCBandPaddingOuter':
			var x = scaleCfg.a;
			return _Utils_Tuple2(
				'bandPaddingOuter',
				$elm$json$Json$Encode$float(x));
		case 'SCBarBandPaddingInner':
			var x = scaleCfg.a;
			return _Utils_Tuple2(
				'barBandPaddingInner',
				$elm$json$Json$Encode$float(x));
		case 'SCBarBandPaddingOuter':
			var x = scaleCfg.a;
			return _Utils_Tuple2(
				'barBandPaddingOuter',
				$elm$json$Json$Encode$float(x));
		case 'SCRectBandPaddingInner':
			var x = scaleCfg.a;
			return _Utils_Tuple2(
				'rectBandPaddingInner',
				$elm$json$Json$Encode$float(x));
		case 'SCRectBandPaddingOuter':
			var x = scaleCfg.a;
			return _Utils_Tuple2(
				'rectBandPaddingOuter',
				$elm$json$Json$Encode$float(x));
		case 'SCClamp':
			var b = scaleCfg.a;
			return _Utils_Tuple2(
				'clamp',
				$elm$json$Json$Encode$bool(b));
		case 'SCMaxBandSize':
			var x = scaleCfg.a;
			return _Utils_Tuple2(
				'maxBandSize',
				$elm$json$Json$Encode$float(x));
		case 'SCMinBandSize':
			var x = scaleCfg.a;
			return _Utils_Tuple2(
				'minBandSize',
				$elm$json$Json$Encode$float(x));
		case 'SCMaxFontSize':
			var x = scaleCfg.a;
			return _Utils_Tuple2(
				'maxFontSize',
				$elm$json$Json$Encode$float(x));
		case 'SCMinFontSize':
			var x = scaleCfg.a;
			return _Utils_Tuple2(
				'minFontSize',
				$elm$json$Json$Encode$float(x));
		case 'SCMaxOpacity':
			var x = scaleCfg.a;
			return _Utils_Tuple2(
				'maxOpacity',
				$elm$json$Json$Encode$float(x));
		case 'SCMinOpacity':
			var x = scaleCfg.a;
			return _Utils_Tuple2(
				'minOpacity',
				$elm$json$Json$Encode$float(x));
		case 'SCMaxSize':
			var x = scaleCfg.a;
			return _Utils_Tuple2(
				'maxSize',
				$elm$json$Json$Encode$float(x));
		case 'SCMinSize':
			var x = scaleCfg.a;
			return _Utils_Tuple2(
				'minSize',
				$elm$json$Json$Encode$float(x));
		case 'SCMaxStrokeWidth':
			var x = scaleCfg.a;
			return _Utils_Tuple2(
				'maxStrokeWidth',
				$elm$json$Json$Encode$float(x));
		case 'SCMinStrokeWidth':
			var x = scaleCfg.a;
			return _Utils_Tuple2(
				'minStrokeWidth',
				$elm$json$Json$Encode$float(x));
		case 'SCPointPadding':
			var x = scaleCfg.a;
			return _Utils_Tuple2(
				'pointPadding',
				$elm$json$Json$Encode$float(x));
		case 'SCRound':
			var b = scaleCfg.a;
			return _Utils_Tuple2(
				'round',
				$elm$json$Json$Encode$bool(b));
		case 'SCUseUnaggregatedDomain':
			var b = scaleCfg.a;
			return _Utils_Tuple2(
				'useUnaggregatedDomain',
				$elm$json$Json$Encode$bool(b));
		default:
			var b = scaleCfg.a;
			return _Utils_Tuple2(
				'xReverse',
				$elm$json$Json$Encode$bool(b));
	}
};
var $author$project$VegaLite$selectionLabel = function (seType) {
	switch (seType.$) {
		case 'SePoint':
			return 'point';
		case 'SeInterval':
			return 'interval';
		case 'SeSingle':
			return 'single';
		default:
			return 'multi';
	}
};
var $author$project$VegaLite$NullValue = {$: 'NullValue'};
var $author$project$VegaLite$bindLegendProperty = function (blProp) {
	switch (blProp.$) {
		case 'BLChannel':
			var ch = blProp.a;
			return _Utils_Tuple2(
				'encodings',
				A2(
					$elm$json$Json$Encode$list,
					$elm$json$Json$Encode$string,
					_List_fromArray(
						[
							$author$project$VegaLite$channelLabel(ch)
						])));
		case 'BLField':
			var f = blProp.a;
			return _Utils_Tuple2(
				'fields',
				A2(
					$elm$json$Json$Encode$list,
					$elm$json$Json$Encode$string,
					_List_fromArray(
						[f])));
		default:
			var es = blProp.a;
			return _Utils_Tuple2(
				'bind',
				$elm$json$Json$Encode$object(
					_List_fromArray(
						[
							_Utils_Tuple2(
							'legend',
							$elm$json$Json$Encode$string(es))
						])));
	}
};
var $author$project$VegaLite$inputProperty = function (prop) {
	switch (prop.$) {
		case 'InMin':
			var x = prop.a;
			return _Utils_Tuple2(
				'min',
				$elm$json$Json$Encode$float(x));
		case 'InMax':
			var x = prop.a;
			return _Utils_Tuple2(
				'max',
				$elm$json$Json$Encode$float(x));
		case 'InStep':
			var x = prop.a;
			return _Utils_Tuple2(
				'step',
				$elm$json$Json$Encode$float(x));
		case 'Debounce':
			var x = prop.a;
			return _Utils_Tuple2(
				'debounce',
				$elm$json$Json$Encode$float(x));
		case 'InName':
			var s = prop.a;
			return _Utils_Tuple2(
				'name',
				$elm$json$Json$Encode$string(s));
		case 'InOptions':
			var opts = prop.a;
			return _Utils_Tuple2(
				'options',
				A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$string, opts));
		case 'InPlaceholder':
			var el = prop.a;
			return _Utils_Tuple2(
				'placeholder',
				$elm$json$Json$Encode$string(el));
		default:
			var el = prop.a;
			return _Utils_Tuple2(
				'element',
				$elm$json$Json$Encode$string(el));
	}
};
var $author$project$VegaLite$bindingProperty = function (bnd) {
	switch (bnd.$) {
		case 'IRange':
			var label = bnd.a;
			var props = bnd.b;
			return _Utils_Tuple2(
				label,
				$elm$json$Json$Encode$object(
					A2(
						$elm$core$List$cons,
						_Utils_Tuple2(
							'input',
							$elm$json$Json$Encode$string('range')),
						A2($elm$core$List$map, $author$project$VegaLite$inputProperty, props))));
		case 'ICheckbox':
			var label = bnd.a;
			var props = bnd.b;
			return _Utils_Tuple2(
				label,
				$elm$json$Json$Encode$object(
					A2(
						$elm$core$List$cons,
						_Utils_Tuple2(
							'input',
							$elm$json$Json$Encode$string('checkbox')),
						A2($elm$core$List$map, $author$project$VegaLite$inputProperty, props))));
		case 'IRadio':
			var label = bnd.a;
			var props = bnd.b;
			return _Utils_Tuple2(
				label,
				$elm$json$Json$Encode$object(
					A2(
						$elm$core$List$cons,
						_Utils_Tuple2(
							'input',
							$elm$json$Json$Encode$string('radio')),
						A2($elm$core$List$map, $author$project$VegaLite$inputProperty, props))));
		case 'ISelect':
			var label = bnd.a;
			var props = bnd.b;
			return _Utils_Tuple2(
				label,
				$elm$json$Json$Encode$object(
					A2(
						$elm$core$List$cons,
						_Utils_Tuple2(
							'input',
							$elm$json$Json$Encode$string('select')),
						A2($elm$core$List$map, $author$project$VegaLite$inputProperty, props))));
		case 'IText':
			var label = bnd.a;
			var props = bnd.b;
			return _Utils_Tuple2(
				label,
				$elm$json$Json$Encode$object(
					A2(
						$elm$core$List$cons,
						_Utils_Tuple2(
							'input',
							$elm$json$Json$Encode$string('text')),
						A2($elm$core$List$map, $author$project$VegaLite$inputProperty, props))));
		case 'INumber':
			var label = bnd.a;
			var props = bnd.b;
			return _Utils_Tuple2(
				label,
				$elm$json$Json$Encode$object(
					A2(
						$elm$core$List$cons,
						_Utils_Tuple2(
							'input',
							$elm$json$Json$Encode$string('number')),
						A2($elm$core$List$map, $author$project$VegaLite$inputProperty, props))));
		case 'IDate':
			var label = bnd.a;
			var props = bnd.b;
			return _Utils_Tuple2(
				label,
				$elm$json$Json$Encode$object(
					A2(
						$elm$core$List$cons,
						_Utils_Tuple2(
							'input',
							$elm$json$Json$Encode$string('date')),
						A2($elm$core$List$map, $author$project$VegaLite$inputProperty, props))));
		case 'ITime':
			var label = bnd.a;
			var props = bnd.b;
			return _Utils_Tuple2(
				label,
				$elm$json$Json$Encode$object(
					A2(
						$elm$core$List$cons,
						_Utils_Tuple2(
							'input',
							$elm$json$Json$Encode$string('time')),
						A2($elm$core$List$map, $author$project$VegaLite$inputProperty, props))));
		case 'IMonth':
			var label = bnd.a;
			var props = bnd.b;
			return _Utils_Tuple2(
				label,
				$elm$json$Json$Encode$object(
					A2(
						$elm$core$List$cons,
						_Utils_Tuple2(
							'input',
							$elm$json$Json$Encode$string('month')),
						A2($elm$core$List$map, $author$project$VegaLite$inputProperty, props))));
		case 'IWeek':
			var label = bnd.a;
			var props = bnd.b;
			return _Utils_Tuple2(
				label,
				$elm$json$Json$Encode$object(
					A2(
						$elm$core$List$cons,
						_Utils_Tuple2(
							'input',
							$elm$json$Json$Encode$string('week')),
						A2($elm$core$List$map, $author$project$VegaLite$inputProperty, props))));
		case 'IDateTimeLocal':
			var label = bnd.a;
			var props = bnd.b;
			return _Utils_Tuple2(
				label,
				$elm$json$Json$Encode$object(
					A2(
						$elm$core$List$cons,
						_Utils_Tuple2(
							'input',
							$elm$json$Json$Encode$string('datetimelocal')),
						A2($elm$core$List$map, $author$project$VegaLite$inputProperty, props))));
		case 'ITel':
			var label = bnd.a;
			var props = bnd.b;
			return _Utils_Tuple2(
				label,
				$elm$json$Json$Encode$object(
					A2(
						$elm$core$List$cons,
						_Utils_Tuple2(
							'input',
							$elm$json$Json$Encode$string('tel')),
						A2($elm$core$List$map, $author$project$VegaLite$inputProperty, props))));
		default:
			var label = bnd.a;
			var props = bnd.b;
			return _Utils_Tuple2(
				label,
				$elm$json$Json$Encode$object(
					A2(
						$elm$core$List$cons,
						_Utils_Tuple2(
							'input',
							$elm$json$Json$Encode$string('color')),
						A2($elm$core$List$map, $author$project$VegaLite$inputProperty, props))));
	}
};
var $elm$core$Tuple$mapSecond = F2(
	function (func, _v0) {
		var x = _v0.a;
		var y = _v0.b;
		return _Utils_Tuple2(
			x,
			func(y));
	});
var $elm$core$List$any = F2(
	function (isOkay, list) {
		any:
		while (true) {
			if (!list.b) {
				return false;
			} else {
				var x = list.a;
				var xs = list.b;
				if (isOkay(x)) {
					return true;
				} else {
					var $temp$isOkay = isOkay,
						$temp$list = xs;
					isOkay = $temp$isOkay;
					list = $temp$list;
					continue any;
				}
			}
		}
	});
var $elm$core$List$member = F2(
	function (x, xs) {
		return A2(
			$elm$core$List$any,
			function (a) {
				return _Utils_eq(a, x);
			},
			xs);
	});
var $author$project$VegaLite$selectionMarkProperty = function (markProp) {
	switch (markProp.$) {
		case 'SMFill':
			var colour = markProp.a;
			return _Utils_Tuple2(
				'fill',
				$elm$json$Json$Encode$string(colour));
		case 'SMFillOpacity':
			var x = markProp.a;
			return _Utils_Tuple2(
				'fillOpacity',
				$elm$json$Json$Encode$float(x));
		case 'SMStroke':
			var colour = markProp.a;
			return _Utils_Tuple2(
				'stroke',
				$elm$json$Json$Encode$string(colour));
		case 'SMStrokeOpacity':
			var x = markProp.a;
			return _Utils_Tuple2(
				'strokeOpacity',
				$elm$json$Json$Encode$float(x));
		case 'SMStrokeWidth':
			var x = markProp.a;
			return _Utils_Tuple2(
				'strokeWidth',
				$elm$json$Json$Encode$float(x));
		case 'SMStrokeDash':
			var xs = markProp.a;
			return _Utils_eq(xs, _List_Nil) ? _Utils_Tuple2('strokeDash', $elm$json$Json$Encode$null) : _Utils_Tuple2(
				'strokeDash',
				A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$float, xs));
		case 'SMStrokeDashOffset':
			var x = markProp.a;
			return _Utils_Tuple2(
				'strokeDashOffset',
				$elm$json$Json$Encode$float(x));
		default:
			var cur = markProp.a;
			return _Utils_Tuple2(
				'cursor',
				$author$project$VegaLite$cursorSpec(cur));
	}
};
var $author$project$VegaLite$selectionResolutionLabel = function (res) {
	switch (res.$) {
		case 'SeGlobal':
			return 'global';
		case 'SeUnion':
			return 'union';
		default:
			return 'intersect';
	}
};
var $author$project$VegaLite$togglePredicateSpec = function (tp) {
	switch (tp.$) {
		case 'TpFalse':
			return $elm$json$Json$Encode$bool(false);
		case 'TpExpr':
			var ex = tp.a;
			return $elm$json$Json$Encode$string(ex);
		case 'TpShiftKey':
			return $elm$json$Json$Encode$string('event.shiftKey');
		case 'TpCtrlKey':
			return $elm$json$Json$Encode$string('event.ctrlKey');
		default:
			return $elm$json$Json$Encode$string('event.altKey');
	}
};
var $author$project$VegaLite$selectionProperties = function (selProp) {
	switch (selProp.$) {
		case 'Fields':
			var fNames = selProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'fields',
					A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$string, fNames))
				]);
		case 'SInit':
			var iVals = selProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'init',
					$elm$json$Json$Encode$object(
						A2(
							$elm$core$List$map,
							$elm$core$Tuple$mapSecond($author$project$VegaLite$dataValueSpec),
							iVals)))
				]);
		case 'SInitInterval':
			var maybeX = selProp.a;
			var maybeY = selProp.b;
			var yExtent = _Utils_eq(
				maybeY,
				$elm$core$Maybe$Just(
					_Utils_Tuple2($author$project$VegaLite$NullValue, $author$project$VegaLite$NullValue))) ? $elm$core$Maybe$Nothing : maybeY;
			var xExtent = _Utils_eq(
				maybeX,
				$elm$core$Maybe$Just(
					_Utils_Tuple2($author$project$VegaLite$NullValue, $author$project$VegaLite$NullValue))) ? $elm$core$Maybe$Nothing : maybeX;
			var _v1 = _Utils_Tuple2(xExtent, yExtent);
			if (_v1.a.$ === 'Just') {
				if (_v1.b.$ === 'Just') {
					var _v2 = _v1.a.a;
					var xMin = _v2.a;
					var xMax = _v2.b;
					var _v3 = _v1.b.a;
					var yMin = _v3.a;
					var yMax = _v3.b;
					return _List_fromArray(
						[
							_Utils_Tuple2(
							'init',
							$elm$json$Json$Encode$object(
								_List_fromArray(
									[
										_Utils_Tuple2(
										'x',
										$author$project$VegaLite$toList(
											_List_fromArray(
												[
													$author$project$VegaLite$dataValueSpec(xMin),
													$author$project$VegaLite$dataValueSpec(xMax)
												]))),
										_Utils_Tuple2(
										'y',
										$author$project$VegaLite$toList(
											_List_fromArray(
												[
													$author$project$VegaLite$dataValueSpec(yMin),
													$author$project$VegaLite$dataValueSpec(yMax)
												])))
									])))
						]);
				} else {
					var _v4 = _v1.a.a;
					var xMin = _v4.a;
					var xMax = _v4.b;
					var _v5 = _v1.b;
					return _List_fromArray(
						[
							_Utils_Tuple2(
							'init',
							$elm$json$Json$Encode$object(
								_List_fromArray(
									[
										_Utils_Tuple2(
										'x',
										$author$project$VegaLite$toList(
											_List_fromArray(
												[
													$author$project$VegaLite$dataValueSpec(xMin),
													$author$project$VegaLite$dataValueSpec(xMax)
												])))
									])))
						]);
				}
			} else {
				if (_v1.b.$ === 'Just') {
					var _v6 = _v1.a;
					var _v7 = _v1.b.a;
					var yMin = _v7.a;
					var yMax = _v7.b;
					return _List_fromArray(
						[
							_Utils_Tuple2(
							'init',
							$elm$json$Json$Encode$object(
								_List_fromArray(
									[
										_Utils_Tuple2(
										'y',
										$author$project$VegaLite$toList(
											_List_fromArray(
												[
													$author$project$VegaLite$dataValueSpec(yMin),
													$author$project$VegaLite$dataValueSpec(yMax)
												])))
									])))
						]);
				} else {
					var _v8 = _v1.a;
					var _v9 = _v1.b;
					return _List_fromArray(
						[
							_Utils_Tuple2('init', $elm$json$Json$Encode$null)
						]);
				}
			}
		case 'Encodings':
			var channels = selProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'encodings',
					A2(
						$elm$json$Json$Encode$list,
						A2($elm$core$Basics$composeL, $elm$json$Json$Encode$string, $author$project$VegaLite$channelLabel),
						channels))
				]);
		case 'On':
			var evStr = selProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'on',
					$elm$json$Json$Encode$string(evStr))
				]);
		case 'Clear':
			var evStr = selProp.a;
			var _v10 = $elm$core$String$trim(evStr);
			if (_v10 === '') {
				return _List_fromArray(
					[
						_Utils_Tuple2(
						'clear',
						$elm$json$Json$Encode$bool(false))
					]);
			} else {
				var evStrTrimmed = _v10;
				return _List_fromArray(
					[
						_Utils_Tuple2(
						'clear',
						$elm$json$Json$Encode$string(evStrTrimmed))
					]);
			}
		case 'Empty':
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'empty',
					$elm$json$Json$Encode$string('none'))
				]);
		case 'ResolveSelections':
			var res = selProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'resolve',
					$elm$json$Json$Encode$string(
						$author$project$VegaLite$selectionResolutionLabel(res)))
				]);
		case 'SelectionMark':
			var markProps = selProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'mark',
					$elm$json$Json$Encode$object(
						A2($elm$core$List$map, $author$project$VegaLite$selectionMarkProperty, markProps)))
				]);
		case 'BindScales':
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'bind',
					$elm$json$Json$Encode$string('scales'))
				]);
		case 'BindLegend':
			var blProps = selProp.a;
			var labelledSpecs = A2($elm$core$List$map, $author$project$VegaLite$bindLegendProperty, blProps);
			return A2(
				$elm$core$List$member,
				'bind',
				A2($elm$core$List$map, $elm$core$Tuple$first, labelledSpecs)) ? labelledSpecs : A2(
				$elm$core$List$cons,
				_Utils_Tuple2(
					'bind',
					$elm$json$Json$Encode$string('legend')),
				labelledSpecs);
		case 'Bind':
			var binds = selProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'bind',
					$elm$json$Json$Encode$object(
						A2($elm$core$List$map, $author$project$VegaLite$bindingProperty, binds)))
				]);
		case 'Nearest':
			var b = selProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'nearest',
					$elm$json$Json$Encode$bool(b))
				]);
		case 'Toggle':
			var tp = selProp.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'toggle',
					$author$project$VegaLite$togglePredicateSpec(tp))
				]);
		case 'Translate':
			var e = selProp.a;
			return (e === '') ? _List_fromArray(
				[
					_Utils_Tuple2(
					'translate',
					$elm$json$Json$Encode$bool(false))
				]) : _List_fromArray(
				[
					_Utils_Tuple2(
					'translate',
					$elm$json$Json$Encode$string(e))
				]);
		default:
			var e = selProp.a;
			return (e === '') ? _List_fromArray(
				[
					_Utils_Tuple2(
					'zoom',
					$elm$json$Json$Encode$bool(false))
				]) : _List_fromArray(
				[
					_Utils_Tuple2(
					'zoom',
					$elm$json$Json$Encode$string(e))
				]);
	}
};
var $author$project$VegaLite$tfLabel = function (tf) {
	if (tf.$ === 'FrGroup') {
		return 'group';
	} else {
		return 'bounds';
	}
};
var $author$project$VegaLite$titleConfigProperty = function (titleCfg) {
	switch (titleCfg.$) {
		case 'TAnchor':
			var an = titleCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'anchor',
					$author$project$VegaLite$anchorSpec(an))
				]);
		case 'TAngle':
			var n = titleCfg.a;
			return A2($author$project$VegaLite$numExpr, 'angle', n);
		case 'TBaseline':
			var va = titleCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'baseline',
					$author$project$VegaLite$vAlignSpec(va))
				]);
		case 'TColor':
			var s = titleCfg.a;
			return A2($author$project$VegaLite$strExpr, 'color', s);
		case 'TFont':
			var s = titleCfg.a;
			return A2($author$project$VegaLite$strExpr, 'font', s);
		case 'TFontSize':
			var n = titleCfg.a;
			return A2($author$project$VegaLite$numExpr, 'fontSize', n);
		case 'TFontStyle':
			var s = titleCfg.a;
			return A2($author$project$VegaLite$strExpr, 'fontStyle', s);
		case 'TFrame':
			var tf = titleCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'frame',
					$elm$json$Json$Encode$string(
						$author$project$VegaLite$tfLabel(tf)))
				]);
		case 'TFontWeight':
			var w = titleCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'fontWeight',
					$author$project$VegaLite$fontWeightSpec(w))
				]);
		case 'TLimit':
			var n = titleCfg.a;
			return A2($author$project$VegaLite$numExpr, 'limit', n);
		case 'TLineHeight':
			var n = titleCfg.a;
			return A2($author$project$VegaLite$numExpr, 'lineHeight', n);
		case 'TOffset':
			var n = titleCfg.a;
			return A2($author$project$VegaLite$numExpr, 'offset', n);
		case 'TOrient':
			var sd = titleCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'orient',
					$author$project$VegaLite$sideSpec(sd))
				]);
		case 'TStyle':
			var ss = titleCfg.a;
			if (ss.b && (!ss.b.b)) {
				var s = ss.a;
				return _List_fromArray(
					[
						_Utils_Tuple2(
						'style',
						$elm$json$Json$Encode$string(s))
					]);
			} else {
				return _List_fromArray(
					[
						_Utils_Tuple2(
						'style',
						A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$string, ss))
					]);
			}
		case 'TSubtitle':
			var s = titleCfg.a;
			return A2($author$project$VegaLite$strExpr, 'subtitle', s);
		case 'TSubtitleColor':
			var s = titleCfg.a;
			return A2($author$project$VegaLite$strExpr, 'subtitleColor', s);
		case 'TSubtitleFont':
			var s = titleCfg.a;
			return A2($author$project$VegaLite$strExpr, 'subtitleFont', s);
		case 'TSubtitleFontSize':
			var n = titleCfg.a;
			return A2($author$project$VegaLite$numExpr, 'subtitleFontSize', n);
		case 'TSubtitleFontStyle':
			var s = titleCfg.a;
			return A2($author$project$VegaLite$strExpr, 'subtitleFontStyle', s);
		case 'TSubtitleFontWeight':
			var w = titleCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'subtitleFontWeight',
					$author$project$VegaLite$fontWeightSpec(w))
				]);
		case 'TSubtitleLineHeight':
			var n = titleCfg.a;
			return A2($author$project$VegaLite$numExpr, 'subtitleLineHeight', n);
		case 'TSubtitlePadding':
			var n = titleCfg.a;
			return A2($author$project$VegaLite$numExpr, 'subtitlePadding', n);
		default:
			var n = titleCfg.a;
			return A2($author$project$VegaLite$numExpr, 'zindex', n);
	}
};
var $author$project$VegaLite$viewBackgroundProperty = function (vb) {
	switch (vb.$) {
		case 'VBStyle':
			var styles = vb.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'style',
					A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$string, styles))
				]);
		case 'VBCornerRadius':
			var n = vb.a;
			return A2($author$project$VegaLite$numExpr, 'cornerRadius', n);
		case 'VBFill':
			var s = vb.a;
			return A2($author$project$VegaLite$strExpr, 'fill', s);
		case 'VBFillOpacity':
			var n = vb.a;
			return A2($author$project$VegaLite$numExpr, 'fillOpacity', n);
		case 'VBOpacity':
			var n = vb.a;
			return A2($author$project$VegaLite$numExpr, 'opacity', n);
		case 'VBStroke':
			var s = vb.a;
			return A2($author$project$VegaLite$strExpr, 'stroke', s);
		case 'VBStrokeOpacity':
			var n = vb.a;
			return A2($author$project$VegaLite$numExpr, 'strokeOpacity', n);
		case 'VBStrokeCap':
			var cap = vb.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'strokeCap',
					$author$project$VegaLite$strokeCapSpec(cap))
				]);
		case 'VBStrokeJoin':
			var jn = vb.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'strokeJoin',
					$author$project$VegaLite$strokeJoinSpec(jn))
				]);
		case 'VBStrokeWidth':
			var n = vb.a;
			return A2($author$project$VegaLite$numExpr, 'strokeWidth', n);
		case 'VBStrokeDash':
			var xs = vb.a;
			return _Utils_eq(xs, _List_Nil) ? _List_fromArray(
				[
					_Utils_Tuple2('strokeDash', $elm$json$Json$Encode$null)
				]) : _List_fromArray(
				[
					_Utils_Tuple2(
					'strokeDash',
					A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$float, xs))
				]);
		case 'VBStrokeDashOffset':
			var n = vb.a;
			return A2($author$project$VegaLite$numExpr, 'strokeDashOffset', n);
		default:
			var n = vb.a;
			return A2($author$project$VegaLite$numExpr, 'strokeMiterLimit', n);
	}
};
var $author$project$VegaLite$viewConfigProperties = function (viewCfg) {
	switch (viewCfg.$) {
		case 'VContinuousWidth':
			var x = viewCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'continuousWidth',
					$elm$json$Json$Encode$float(x))
				]);
		case 'VContinuousHeight':
			var x = viewCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'continuousHeight',
					$elm$json$Json$Encode$float(x))
				]);
		case 'VDiscreteWidth':
			var x = viewCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'discreteWidth',
					$elm$json$Json$Encode$float(x))
				]);
		case 'VDiscreteHeight':
			var x = viewCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'discreteHeight',
					$elm$json$Json$Encode$float(x))
				]);
		case 'VClip':
			var b = viewCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'clip',
					$elm$json$Json$Encode$bool(b))
				]);
		case 'VCornerRadius':
			var r = viewCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'cornerRadius',
					$elm$json$Json$Encode$float(r))
				]);
		case 'VCursor':
			var cur = viewCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'cursor',
					$author$project$VegaLite$cursorSpec(cur))
				]);
		case 'VFill':
			var ms = viewCfg.a;
			if (ms.$ === 'Just') {
				var s = ms.a;
				return _List_fromArray(
					[
						_Utils_Tuple2(
						'fill',
						$elm$json$Json$Encode$string(s))
					]);
			} else {
				return _List_fromArray(
					[
						_Utils_Tuple2(
						'fill',
						$elm$json$Json$Encode$string(''))
					]);
			}
		case 'VFillOpacity':
			var x = viewCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'fillOpacity',
					$elm$json$Json$Encode$float(x))
				]);
		case 'VOpacity':
			var x = viewCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'opacity',
					$elm$json$Json$Encode$float(x))
				]);
		case 'VStep':
			var x = viewCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'step',
					$elm$json$Json$Encode$float(x))
				]);
		case 'VStroke':
			var ms = viewCfg.a;
			if (ms.$ === 'Just') {
				var s = ms.a;
				return _List_fromArray(
					[
						_Utils_Tuple2(
						'stroke',
						$elm$json$Json$Encode$string(s))
					]);
			} else {
				return _List_fromArray(
					[
						_Utils_Tuple2(
						'stroke',
						$elm$json$Json$Encode$string(''))
					]);
			}
		case 'VStrokeOpacity':
			var x = viewCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'strokeOpacity',
					$elm$json$Json$Encode$float(x))
				]);
		case 'VStrokeCap':
			var cap = viewCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'strokeCap',
					$author$project$VegaLite$strokeCapSpec(cap))
				]);
		case 'VStrokeJoin':
			var jn = viewCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'strokeJoin',
					$author$project$VegaLite$strokeJoinSpec(jn))
				]);
		case 'VStrokeWidth':
			var x = viewCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'strokeWidth',
					$elm$json$Json$Encode$float(x))
				]);
		case 'VStrokeDash':
			var xs = viewCfg.a;
			return _Utils_eq(xs, _List_Nil) ? _List_fromArray(
				[
					_Utils_Tuple2('strokeDash', $elm$json$Json$Encode$null)
				]) : _List_fromArray(
				[
					_Utils_Tuple2(
					'strokeDash',
					A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$float, xs))
				]);
		case 'VStrokeDashOffset':
			var x = viewCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'strokeDashOffset',
					$elm$json$Json$Encode$float(x))
				]);
		case 'VStrokeMiterLimit':
			var x = viewCfg.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'strokeMiterLimit',
					$elm$json$Json$Encode$float(x))
				]);
		default:
			var vbs = viewCfg.a;
			return A2($elm$core$List$concatMap, $author$project$VegaLite$viewBackgroundProperty, vbs);
	}
};
var $author$project$VegaLite$configProperty = function (configProp) {
	switch (configProp.$) {
		case 'Aria':
			var b = configProp.a;
			return _Utils_Tuple2(
				'aria',
				$elm$json$Json$Encode$bool(b));
		case 'Autosize':
			var aus = configProp.a;
			return _Utils_Tuple2(
				'autosize',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$map, $author$project$VegaLite$autosizeProperty, aus)));
		case 'Background':
			var bg = configProp.a;
			return _Utils_Tuple2(
				'background',
				$elm$json$Json$Encode$string(bg));
		case 'CountTitle':
			var s = configProp.a;
			return _Utils_Tuple2(
				'countTitle',
				$elm$json$Json$Encode$string(s));
		case 'FieldTitle':
			var ftp = configProp.a;
			return _Utils_Tuple2(
				'fieldTitle',
				$elm$json$Json$Encode$string(
					$author$project$VegaLite$fieldTitleLabel(ftp)));
		case 'NumberFormat':
			var fmt = configProp.a;
			return _Utils_Tuple2(
				'numberFormat',
				$elm$json$Json$Encode$string(fmt));
		case 'Padding':
			var pad = configProp.a;
			return _Utils_Tuple2(
				'padding',
				$author$project$VegaLite$paddingSpec(pad));
		case 'TimeFormat':
			var fmt = configProp.a;
			return _Utils_Tuple2(
				'timeFormat',
				$elm$json$Json$Encode$string(fmt));
		case 'Axis':
			var axType = configProp.a;
			var acs = configProp.b;
			return _Utils_Tuple2(
				$author$project$VegaLite$axisLabel(axType),
				$elm$json$Json$Encode$object(
					A2($elm$core$List$concatMap, $author$project$VegaLite$axisConfigProperty, acs)));
		case 'AxisLeft':
			var acs = configProp.a;
			return _Utils_Tuple2(
				'axisLeft',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$concatMap, $author$project$VegaLite$axisConfigProperty, acs)));
		case 'AxisRight':
			var acs = configProp.a;
			return _Utils_Tuple2(
				'axisRight',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$concatMap, $author$project$VegaLite$axisConfigProperty, acs)));
		case 'AxisTop':
			var acs = configProp.a;
			return _Utils_Tuple2(
				'axisTop',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$concatMap, $author$project$VegaLite$axisConfigProperty, acs)));
		case 'AxisBottom':
			var acs = configProp.a;
			return _Utils_Tuple2(
				'axisBottom',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$concatMap, $author$project$VegaLite$axisConfigProperty, acs)));
		case 'AxisBand':
			var axType = configProp.a;
			var acs = configProp.b;
			return _Utils_Tuple2(
				$author$project$VegaLite$axisLabel(axType) + 'Band',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$concatMap, $author$project$VegaLite$axisConfigProperty, acs)));
		case 'AxisDiscrete':
			var axType = configProp.a;
			var acs = configProp.b;
			return _Utils_Tuple2(
				$author$project$VegaLite$axisLabel(axType) + 'Discrete',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$concatMap, $author$project$VegaLite$axisConfigProperty, acs)));
		case 'AxisPoint':
			var axType = configProp.a;
			var acs = configProp.b;
			return _Utils_Tuple2(
				$author$project$VegaLite$axisLabel(axType) + 'Point',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$concatMap, $author$project$VegaLite$axisConfigProperty, acs)));
		case 'AxisQuant':
			var axType = configProp.a;
			var acs = configProp.b;
			return _Utils_Tuple2(
				$author$project$VegaLite$axisLabel(axType) + 'Quantitative',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$concatMap, $author$project$VegaLite$axisConfigProperty, acs)));
		case 'AxisTemporal':
			var axType = configProp.a;
			var acs = configProp.b;
			return _Utils_Tuple2(
				$author$project$VegaLite$axisLabel(axType) + 'Temporal',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$concatMap, $author$project$VegaLite$axisConfigProperty, acs)));
		case 'Legend':
			var lcs = configProp.a;
			return _Utils_Tuple2(
				'legend',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$concatMap, $author$project$VegaLite$legendConfigProperty, lcs)));
		case 'Font':
			var fnt = configProp.a;
			return _Utils_Tuple2(
				'font',
				$elm$json$Json$Encode$string(fnt));
		case 'MarkStyle':
			var mps = configProp.a;
			return _Utils_Tuple2(
				'mark',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$concatMap, $author$project$VegaLite$markProperty, mps)));
		case 'Projection':
			var pps = configProp.a;
			return _Utils_Tuple2(
				'projection',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$map, $author$project$VegaLite$projectionProperty, pps)));
		case 'AreaStyle':
			var mps = configProp.a;
			return _Utils_Tuple2(
				'area',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$concatMap, $author$project$VegaLite$markProperty, mps)));
		case 'BarStyle':
			var mps = configProp.a;
			return _Utils_Tuple2(
				'bar',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$concatMap, $author$project$VegaLite$markProperty, mps)));
		case 'CircleStyle':
			var mps = configProp.a;
			return _Utils_Tuple2(
				'circle',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$concatMap, $author$project$VegaLite$markProperty, mps)));
		case 'FacetStyle':
			var fps = configProp.a;
			return _Utils_Tuple2(
				'facet',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$map, $author$project$VegaLite$facetConfigProperty, fps)));
		case 'ConcatStyle':
			var cps = configProp.a;
			return _Utils_Tuple2(
				'concat',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$map, $author$project$VegaLite$concatConfigProperty, cps)));
		case 'CustomFormatTypes':
			var b = configProp.a;
			return _Utils_Tuple2(
				'customFormatTypes',
				$elm$json$Json$Encode$bool(b));
		case 'GeoshapeStyle':
			var mps = configProp.a;
			return _Utils_Tuple2(
				'geoshape',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$concatMap, $author$project$VegaLite$markProperty, mps)));
		case 'HeaderStyle':
			var hps = configProp.a;
			return _Utils_Tuple2(
				'header',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$map, $author$project$VegaLite$headerProperty, hps)));
		case 'LineStyle':
			var mps = configProp.a;
			return _Utils_Tuple2(
				'line',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$concatMap, $author$project$VegaLite$markProperty, mps)));
		case 'PointStyle':
			var mps = configProp.a;
			return _Utils_Tuple2(
				'point',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$concatMap, $author$project$VegaLite$markProperty, mps)));
		case 'RectStyle':
			var mps = configProp.a;
			return _Utils_Tuple2(
				'rect',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$concatMap, $author$project$VegaLite$markProperty, mps)));
		case 'RuleStyle':
			var mps = configProp.a;
			return _Utils_Tuple2(
				'rule',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$concatMap, $author$project$VegaLite$markProperty, mps)));
		case 'SquareStyle':
			var mps = configProp.a;
			return _Utils_Tuple2(
				'square',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$concatMap, $author$project$VegaLite$markProperty, mps)));
		case 'TextStyle':
			var mps = configProp.a;
			return _Utils_Tuple2(
				'text',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$concatMap, $author$project$VegaLite$markProperty, mps)));
		case 'TickStyle':
			var mps = configProp.a;
			return _Utils_Tuple2(
				'tick',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$concatMap, $author$project$VegaLite$markProperty, mps)));
		case 'TitleStyle':
			var tcs = configProp.a;
			return _Utils_Tuple2(
				'title',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$concatMap, $author$project$VegaLite$titleConfigProperty, tcs)));
		case 'MarkStyles':
			var styles = configProp.a;
			return _Utils_Tuple2(
				'style',
				$elm$json$Json$Encode$object(
					A2(
						$elm$core$List$map,
						function (_v1) {
							var sName = _v1.a;
							var mps = _v1.b;
							return _Utils_Tuple2(
								sName,
								$elm$json$Json$Encode$object(
									A2($elm$core$List$concatMap, $author$project$VegaLite$markProperty, mps)));
						},
						styles)));
		case 'AxisStyles':
			var styles = configProp.a;
			return _Utils_Tuple2(
				'style',
				$elm$json$Json$Encode$object(
					A2(
						$elm$core$List$map,
						function (_v2) {
							var sName = _v2.a;
							var mps = _v2.b;
							return _Utils_Tuple2(
								sName,
								$elm$json$Json$Encode$object(
									A2($elm$core$List$concatMap, $author$project$VegaLite$axisProperty, mps)));
						},
						styles)));
		case 'Scale':
			var scs = configProp.a;
			return _Utils_Tuple2(
				'scale',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$map, $author$project$VegaLite$scaleConfigProperty, scs)));
		case 'Range':
			var rcs = configProp.a;
			return _Utils_Tuple2(
				'range',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$map, $author$project$VegaLite$rangeConfigProperty, rcs)));
		case 'SelectionStyle':
			var selConfig = configProp.a;
			var selProp = function (_v3) {
				var sel = _v3.a;
				var sps = _v3.b;
				return _Utils_Tuple2(
					$author$project$VegaLite$selectionLabel(sel),
					$elm$json$Json$Encode$object(
						A2($elm$core$List$concatMap, $author$project$VegaLite$selectionProperties, sps)));
			};
			return _Utils_Tuple2(
				'selection',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$map, selProp, selConfig)));
		case 'View':
			var vcs = configProp.a;
			return _Utils_Tuple2(
				'view',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$concatMap, $author$project$VegaLite$viewConfigProperties, vcs)));
		default:
			var mps = configProp.a;
			return _Utils_Tuple2(
				'trail',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$concatMap, $author$project$VegaLite$markProperty, mps)));
	}
};
var $author$project$VegaLite$configuration = function (cfg) {
	return $elm$core$List$cons(
		$author$project$VegaLite$configProperty(cfg));
};
var $author$project$VegaLite$VLConfig = {$: 'VLConfig'};
var $author$project$VegaLite$configure = function (configs) {
	return _Utils_Tuple2(
		$author$project$VegaLite$VLConfig,
		$elm$json$Json$Encode$object(configs));
};
var $author$project$VegaLite$dataColumn = F2(
	function (colName, data) {
		switch (data.$) {
			case 'Numbers':
				var col = data.a;
				return $elm$core$List$cons(
					A2(
						$elm$core$List$map,
						function (x) {
							return _Utils_Tuple2(
								colName,
								$elm$json$Json$Encode$float(x));
						},
						col));
			case 'Strings':
				var col = data.a;
				return $elm$core$List$cons(
					A2(
						$elm$core$List$map,
						function (s) {
							return _Utils_Tuple2(
								colName,
								$elm$json$Json$Encode$string(s));
						},
						col));
			case 'DateTimes':
				var col = data.a;
				return $elm$core$List$cons(
					A2(
						$elm$core$List$map,
						function (ds) {
							return _Utils_Tuple2(
								colName,
								$elm$json$Json$Encode$object(
									A2($elm$core$List$map, $author$project$VegaLite$dateTimeProperty, ds)));
						},
						col));
			default:
				var col = data.a;
				return $elm$core$List$cons(
					A2(
						$elm$core$List$map,
						function (b) {
							return _Utils_Tuple2(
								colName,
								$elm$json$Json$Encode$bool(b));
						},
						col));
		}
	});
var $author$project$VegaLite$VLData = {$: 'VLData'};
var $author$project$VegaLite$dataTypeLabel = function (dType) {
	switch (dType.$) {
		case 'FoNum':
			return 'number';
		case 'FoBoo':
			return 'boolean';
		case 'FoDate':
			var dateFmt = dType.a;
			return (dateFmt === '') ? 'date' : ('date:\'' + (dateFmt + '\''));
		default:
			var dateFmt = dType.a;
			return (dateFmt === '') ? 'utc' : ('utc:\'' + (dateFmt + '\''));
	}
};
var $elm$core$String$cons = _String_cons;
var $elm$core$String$fromChar = function (_char) {
	return A2($elm$core$String$cons, _char, '');
};
var $author$project$VegaLite$formatProperties = function (fmt) {
	switch (fmt.$) {
		case 'JSON':
			var propertyName = fmt.a;
			return ($elm$core$String$trim(propertyName) === '') ? _List_fromArray(
				[
					_Utils_Tuple2(
					'type',
					$elm$json$Json$Encode$string('json'))
				]) : _List_fromArray(
				[
					_Utils_Tuple2(
					'type',
					$elm$json$Json$Encode$string('json')),
					_Utils_Tuple2(
					'property',
					$elm$json$Json$Encode$string(propertyName))
				]);
		case 'CSV':
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'type',
					$elm$json$Json$Encode$string('csv'))
				]);
		case 'TSV':
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'type',
					$elm$json$Json$Encode$string('tsv'))
				]);
		case 'DSV':
			var delim = fmt.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'type',
					$elm$json$Json$Encode$string('dsv')),
					_Utils_Tuple2(
					'delimiter',
					$elm$json$Json$Encode$string(
						$elm$core$String$fromChar(delim)))
				]);
		case 'Arrow':
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'type',
					$elm$json$Json$Encode$string('arrow'))
				]);
		case 'TopojsonFeature':
			var objectSet = fmt.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'type',
					$elm$json$Json$Encode$string('topojson')),
					_Utils_Tuple2(
					'feature',
					$elm$json$Json$Encode$string(objectSet))
				]);
		case 'TopojsonMesh':
			var objectSet = fmt.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'type',
					$elm$json$Json$Encode$string('topojson')),
					_Utils_Tuple2(
					'mesh',
					$elm$json$Json$Encode$string(objectSet))
				]);
		default:
			var fmts = fmt.a;
			return _Utils_eq(fmts, _List_Nil) ? _List_fromArray(
				[
					_Utils_Tuple2('parse', $elm$json$Json$Encode$null)
				]) : _List_fromArray(
				[
					_Utils_Tuple2(
					'parse',
					$elm$json$Json$Encode$object(
						A2(
							$elm$core$List$map,
							function (_v1) {
								var field = _v1.a;
								var fFormat = _v1.b;
								return _Utils_Tuple2(
									field,
									$elm$json$Json$Encode$string(
										$author$project$VegaLite$dataTypeLabel(fFormat)));
							},
							fmts)))
				]);
	}
};
var $elm$core$List$repeatHelp = F3(
	function (result, n, value) {
		repeatHelp:
		while (true) {
			if (n <= 0) {
				return result;
			} else {
				var $temp$result = A2($elm$core$List$cons, value, result),
					$temp$n = n - 1,
					$temp$value = value;
				result = $temp$result;
				n = $temp$n;
				value = $temp$value;
				continue repeatHelp;
			}
		}
	});
var $elm$core$List$repeat = F2(
	function (n, value) {
		return A3($elm$core$List$repeatHelp, _List_Nil, n, value);
	});
var $author$project$VegaLite$transpose = function (xss) {
	var numCols = A2(
		$elm$core$Basics$composeR,
		$elm$core$List$head,
		A2(
			$elm$core$Basics$composeR,
			$elm$core$Maybe$withDefault(_List_Nil),
			$elm$core$List$length));
	return A3(
		$elm$core$List$foldr,
		$elm$core$List$map2($elm$core$List$cons),
		A2(
			$elm$core$List$repeat,
			numCols(xss),
			_List_Nil),
		xss);
};
var $author$project$VegaLite$dataFromColumns = F2(
	function (fmts, cols) {
		if (_Utils_eq(cols, _List_Nil)) {
			return _Utils_Tuple2(
				$author$project$VegaLite$VLData,
				$elm$json$Json$Encode$object(
					_List_fromArray(
						[
							_Utils_Tuple2(
							'values',
							$author$project$VegaLite$toList(
								_List_fromArray(
									[
										$elm$json$Json$Encode$object(_List_Nil)
									])))
						])));
		} else {
			var dataArray = A2(
				$elm$json$Json$Encode$list,
				$elm$json$Json$Encode$object,
				$author$project$VegaLite$transpose(cols));
			return _Utils_eq(fmts, _List_Nil) ? _Utils_Tuple2(
				$author$project$VegaLite$VLData,
				$elm$json$Json$Encode$object(
					_List_fromArray(
						[
							_Utils_Tuple2('values', dataArray)
						]))) : _Utils_Tuple2(
				$author$project$VegaLite$VLData,
				$elm$json$Json$Encode$object(
					_List_fromArray(
						[
							_Utils_Tuple2('values', dataArray),
							_Utils_Tuple2(
							'format',
							$elm$json$Json$Encode$object(
								A2($elm$core$List$concatMap, $author$project$VegaLite$formatProperties, fmts)))
						])));
		}
	});
var $author$project$VegaLite$VLDescription = {$: 'VLDescription'};
var $author$project$VegaLite$description = function (s) {
	return _Utils_Tuple2(
		$author$project$VegaLite$VLDescription,
		$elm$json$Json$Encode$string(s));
};
var $author$project$VegaLite$VLEncoding = {$: 'VLEncoding'};
var $author$project$VegaLite$encoding = function (channels) {
	return _Utils_Tuple2(
		$author$project$VegaLite$VLEncoding,
		$elm$json$Json$Encode$object(channels));
};
var $author$project$VegaLite$HAlignLeft = {$: 'HAlignLeft'};
var $author$project$VegaLite$haLeft = $author$project$VegaLite$HAlignLeft;
var $author$project$VegaLite$VLLayer = {$: 'VLLayer'};
var $author$project$VegaLite$layer = function (specs) {
	return _Utils_Tuple2(
		$author$project$VegaLite$VLLayer,
		$author$project$VegaLite$toList(specs));
};
var $author$project$VegaLite$MAlign = function (a) {
	return {$: 'MAlign', a: a};
};
var $author$project$VegaLite$maAlign = $author$project$VegaLite$MAlign;
var $author$project$VegaLite$MBaseline = function (a) {
	return {$: 'MBaseline', a: a};
};
var $author$project$VegaLite$maBaseline = $author$project$VegaLite$MBaseline;
var $author$project$VegaLite$MdX = function (a) {
	return {$: 'MdX', a: a};
};
var $author$project$VegaLite$maDx = function (n) {
	return $author$project$VegaLite$MdX(
		$author$project$VegaLite$Num(n));
};
var $author$project$VegaLite$MStyle = function (a) {
	return {$: 'MStyle', a: a};
};
var $author$project$VegaLite$maStyle = $author$project$VegaLite$MStyle;
var $author$project$VegaLite$Numbers = function (a) {
	return {$: 'Numbers', a: a};
};
var $author$project$VegaLite$nums = $author$project$VegaLite$Numbers;
var $author$project$VegaLite$PName = function (a) {
	return {$: 'PName', a: a};
};
var $author$project$VegaLite$pName = $author$project$VegaLite$PName;
var $author$project$VegaLite$Ordinal = {$: 'Ordinal'};
var $author$project$VegaLite$PmType = function (a) {
	return {$: 'PmType', a: a};
};
var $author$project$VegaLite$pOrdinal = $author$project$VegaLite$PmType($author$project$VegaLite$Ordinal);
var $author$project$VegaLite$Quantitative = {$: 'Quantitative'};
var $author$project$VegaLite$pQuant = $author$project$VegaLite$PmType($author$project$VegaLite$Quantitative);
var $author$project$VegaLite$imMethodLabel = function (method) {
	switch (method.$) {
		case 'ImValue':
			return 'value';
		case 'ImMean':
			return 'mean';
		case 'ImMedian':
			return 'median';
		case 'ImMax':
			return 'max';
		default:
			return 'min';
	}
};
var $author$project$VegaLite$imputeProperty = function (ip) {
	switch (ip.$) {
		case 'ImFrame':
			if (ip.a.$ === 'Just') {
				if (ip.b.$ === 'Just') {
					var n1 = ip.a.a;
					var n2 = ip.b.a;
					return _Utils_Tuple2(
						'frame',
						A2(
							$elm$json$Json$Encode$list,
							$elm$json$Json$Encode$int,
							_List_fromArray(
								[n1, n2])));
				} else {
					var n1 = ip.a.a;
					var _v2 = ip.b;
					return _Utils_Tuple2(
						'frame',
						$author$project$VegaLite$toList(
							_List_fromArray(
								[
									$elm$json$Json$Encode$int(n1),
									$elm$json$Json$Encode$null
								])));
				}
			} else {
				if (ip.b.$ === 'Just') {
					var _v1 = ip.a;
					var n2 = ip.b.a;
					return _Utils_Tuple2(
						'frame',
						$author$project$VegaLite$toList(
							_List_fromArray(
								[
									$elm$json$Json$Encode$null,
									$elm$json$Json$Encode$int(n2)
								])));
				} else {
					var _v3 = ip.a;
					var _v4 = ip.b;
					return _Utils_Tuple2(
						'frame',
						$author$project$VegaLite$toList(
							_List_fromArray(
								[$elm$json$Json$Encode$null, $elm$json$Json$Encode$null])));
				}
			}
		case 'ImKeyVals':
			var dVals = ip.a;
			return _Utils_Tuple2(
				'keyvals',
				$author$project$VegaLite$toList(
					$author$project$VegaLite$dataValuesSpecs(dVals)));
		case 'ImKeyValSequence':
			var start = ip.a;
			var stop = ip.b;
			var step = ip.c;
			return _Utils_Tuple2(
				'keyvals',
				$elm$json$Json$Encode$object(
					_List_fromArray(
						[
							_Utils_Tuple2(
							'start',
							$elm$json$Json$Encode$float(start)),
							_Utils_Tuple2(
							'stop',
							$elm$json$Json$Encode$float(stop)),
							_Utils_Tuple2(
							'step',
							$elm$json$Json$Encode$float(step))
						])));
		case 'ImMethod':
			var method = ip.a;
			return _Utils_Tuple2(
				'method',
				$elm$json$Json$Encode$string(
					$author$project$VegaLite$imMethodLabel(method)));
		case 'ImNewValue':
			var dVal = ip.a;
			return _Utils_Tuple2(
				'value',
				$author$project$VegaLite$dataValueSpec(dVal));
		default:
			var fields = ip.a;
			return _Utils_Tuple2(
				'groupby',
				A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$string, fields));
	}
};
var $author$project$VegaLite$stackOffsetSpec = function (sp) {
	switch (sp.$) {
		case 'OfZero':
			return $elm$json$Json$Encode$string('zero');
		case 'OfNormalize':
			return $elm$json$Json$Encode$string('normalize');
		case 'OfCenter':
			return $elm$json$Json$Encode$string('center');
		default:
			return $elm$json$Json$Encode$null;
	}
};
var $author$project$VegaLite$stackOffsetProperty = function (offset) {
	return _Utils_Tuple2(
		'stack',
		$author$project$VegaLite$stackOffsetSpec(offset));
};
var $author$project$VegaLite$positionChannelProperty = function (pDef) {
	switch (pDef.$) {
		case 'PName':
			var s = pDef.a;
			return _Utils_Tuple2(
				'field',
				$elm$json$Json$Encode$string(s));
		case 'PDatum':
			var d = pDef.a;
			return _Utils_Tuple2(
				'datum',
				$author$project$VegaLite$dataValueSpec(d));
		case 'PmType':
			var measure = pDef.a;
			return _Utils_Tuple2(
				'type',
				$elm$json$Json$Encode$string(
					$author$project$VegaLite$measurementLabel(measure)));
		case 'PBin':
			var bps = pDef.a;
			return $author$project$VegaLite$bin(bps);
		case 'PBinned':
			return _Utils_Tuple2(
				'bin',
				$elm$json$Json$Encode$string('binned'));
		case 'PAggregate':
			var op = pDef.a;
			return _Utils_Tuple2(
				'aggregate',
				$author$project$VegaLite$operationSpec(op));
		case 'PTimeUnit':
			var tu = pDef.a;
			return _Utils_Tuple2(
				'timeUnit',
				$author$project$VegaLite$timeUnitSpec(tu));
		case 'PTitle':
			var t = pDef.a;
			return _Utils_Tuple2(
				'title',
				$author$project$VegaLite$multilineTextSpec(t));
		case 'PSort':
			var sps = pDef.a;
			_v1$4:
			while (true) {
				if (!sps.b) {
					return _Utils_Tuple2('sort', $elm$json$Json$Encode$null);
				} else {
					if (!sps.b.b) {
						switch (sps.a.$) {
							case 'Ascending':
								var _v2 = sps.a;
								return _Utils_Tuple2(
									'sort',
									$elm$json$Json$Encode$string('ascending'));
							case 'Descending':
								var _v3 = sps.a;
								return _Utils_Tuple2(
									'sort',
									$elm$json$Json$Encode$string('descending'));
							case 'CustomSort':
								var dvs = sps.a.a;
								return _Utils_Tuple2(
									'sort',
									$author$project$VegaLite$toList(
										$author$project$VegaLite$dataValuesSpecs(dvs)));
							default:
								break _v1$4;
						}
					} else {
						break _v1$4;
					}
				}
			}
			return _Utils_Tuple2(
				'sort',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$concatMap, $author$project$VegaLite$sortProperties, sps)));
		case 'PBandPosition':
			var x = pDef.a;
			return _Utils_Tuple2(
				'bandPosition',
				$elm$json$Json$Encode$float(x));
		case 'PScale':
			var sps = pDef.a;
			return _Utils_eq(sps, _List_Nil) ? _Utils_Tuple2('scale', $elm$json$Json$Encode$null) : _Utils_Tuple2(
				'scale',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$map, $author$project$VegaLite$scaleProperty, sps)));
		case 'PAxis':
			var aps = pDef.a;
			return _Utils_eq(aps, _List_Nil) ? _Utils_Tuple2('axis', $elm$json$Json$Encode$null) : _Utils_Tuple2(
				'axis',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$concatMap, $author$project$VegaLite$axisProperty, aps)));
		case 'PStack':
			var so = pDef.a;
			return $author$project$VegaLite$stackOffsetProperty(so);
		case 'PRepeat':
			var arr = pDef.a;
			return _Utils_Tuple2(
				'field',
				$elm$json$Json$Encode$object(
					_List_fromArray(
						[
							_Utils_Tuple2(
							'repeat',
							$elm$json$Json$Encode$string(
								$author$project$VegaLite$arrangementLabel(arr)))
						])));
		case 'PWidth':
			return _Utils_Tuple2(
				'value',
				$elm$json$Json$Encode$string('width'));
		case 'PHeight':
			return _Utils_Tuple2(
				'value',
				$elm$json$Json$Encode$string('height'));
		case 'PNumber':
			var x = pDef.a;
			return _Utils_Tuple2(
				'value',
				$elm$json$Json$Encode$float(x));
		default:
			var ips = pDef.a;
			return _Utils_Tuple2(
				'impute',
				$elm$json$Json$Encode$object(
					A2($elm$core$List$map, $author$project$VegaLite$imputeProperty, ips)));
	}
};
var $author$project$VegaLite$positionLabel = function (pChannel) {
	switch (pChannel.$) {
		case 'X':
			return 'x';
		case 'Y':
			return 'y';
		case 'X2':
			return 'x2';
		case 'Y2':
			return 'y2';
		case 'Theta':
			return 'theta';
		case 'Theta2':
			return 'theta2';
		case 'R':
			return 'radius';
		case 'R2':
			return 'radius2';
		case 'XError':
			return 'xError';
		case 'YError':
			return 'yError';
		case 'XError2':
			return 'xError2';
		case 'YError2':
			return 'yError2';
		case 'Longitude':
			return 'longitude';
		case 'Latitude':
			return 'latitude';
		case 'Longitude2':
			return 'longitude2';
		default:
			return 'latitude2';
	}
};
var $author$project$VegaLite$position = F2(
	function (pos, pDefs) {
		return $elm$core$List$cons(
			_Utils_Tuple2(
				$author$project$VegaLite$positionLabel(pos),
				$elm$json$Json$Encode$object(
					A2($elm$core$List$map, $author$project$VegaLite$positionChannelProperty, pDefs))));
	});
var $author$project$VegaLite$Strings = function (a) {
	return {$: 'Strings', a: a};
};
var $author$project$VegaLite$strs = $author$project$VegaLite$Strings;
var $author$project$VegaLite$TName = function (a) {
	return {$: 'TName', a: a};
};
var $author$project$VegaLite$tName = $author$project$VegaLite$TName;
var $author$project$VegaLite$TmType = function (a) {
	return {$: 'TmType', a: a};
};
var $author$project$VegaLite$tQuant = $author$project$VegaLite$TmType($author$project$VegaLite$Quantitative);
var $author$project$VegaLite$textChannelProperties = function (tDef) {
	switch (tDef.$) {
		case 'TName':
			var s = tDef.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'field',
					$elm$json$Json$Encode$string(s))
				]);
		case 'TRepeat':
			var arr = tDef.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'field',
					$elm$json$Json$Encode$object(
						_List_fromArray(
							[
								_Utils_Tuple2(
								'repeat',
								$elm$json$Json$Encode$string(
									$author$project$VegaLite$arrangementLabel(arr)))
							])))
				]);
		case 'TmType':
			var measure = tDef.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'type',
					$elm$json$Json$Encode$string(
						$author$project$VegaLite$measurementLabel(measure)))
				]);
		case 'TBin':
			var bps = tDef.a;
			return _List_fromArray(
				[
					$author$project$VegaLite$bin(bps)
				]);
		case 'TBinned':
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'bin',
					$elm$json$Json$Encode$string('binned'))
				]);
		case 'TAggregate':
			var op = tDef.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'aggregate',
					$author$project$VegaLite$operationSpec(op))
				]);
		case 'TTimeUnit':
			var tu = tDef.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'timeUnit',
					$author$project$VegaLite$timeUnitSpec(tu))
				]);
		case 'TTitle':
			var t = tDef.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'title',
					$author$project$VegaLite$multilineTextSpec(t))
				]);
		case 'TFormat':
			var fmt = tDef.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'format',
					$elm$json$Json$Encode$string(fmt))
				]);
		case 'TFormatAsNum':
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'formatType',
					$elm$json$Json$Encode$string('number'))
				]);
		case 'TFormatAsTemporal':
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'formatType',
					$elm$json$Json$Encode$string('time'))
				]);
		case 'TFormatAsCustom':
			var formatter = tDef.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'formatType',
					$elm$json$Json$Encode$string(formatter))
				]);
		case 'TCondition':
			var predicate = tDef.a;
			var ifClause = tDef.b;
			var elseClause = tDef.c;
			return A2(
				$elm$core$List$cons,
				_Utils_Tuple2(
					'condition',
					$elm$json$Json$Encode$object(
						_Utils_ap(
							$author$project$VegaLite$predicateProperties(predicate),
							A2($elm$core$List$concatMap, $author$project$VegaLite$textChannelProperties, ifClause)))),
				A2($elm$core$List$concatMap, $author$project$VegaLite$textChannelProperties, elseClause));
		case 'TConditions':
			var ifClauses = tDef.a;
			var elseClause = tDef.b;
			return A2(
				$elm$core$List$cons,
				_Utils_Tuple2(
					'condition',
					A2(
						$elm$json$Json$Encode$list,
						function (_v1) {
							var predicate = _v1.a;
							var ifClause = _v1.b;
							return $elm$json$Json$Encode$object(
								_Utils_ap(
									$author$project$VegaLite$predicateProperties(predicate),
									A2($elm$core$List$concatMap, $author$project$VegaLite$textChannelProperties, ifClause)));
						},
						ifClauses)),
				A2($elm$core$List$concatMap, $author$project$VegaLite$textChannelProperties, elseClause));
		case 'TDataCondition':
			var isSelection = tDef.a;
			var tests = tDef.b;
			var elseClause = tDef.c;
			var testClause = function (_v2) {
				var predicate = _v2.a;
				var ifClause = _v2.b;
				return isSelection ? $elm$json$Json$Encode$object(
					A2(
						$elm$core$List$cons,
						_Utils_Tuple2(
							'selection',
							$author$project$VegaLite$booleanOpSpec(predicate)),
						A2($elm$core$List$concatMap, $author$project$VegaLite$textChannelProperties, ifClause))) : $elm$json$Json$Encode$object(
					A2(
						$elm$core$List$cons,
						_Utils_Tuple2(
							'test',
							$author$project$VegaLite$booleanOpSpec(predicate)),
						A2($elm$core$List$concatMap, $author$project$VegaLite$textChannelProperties, ifClause)));
			};
			return A2(
				$elm$core$List$cons,
				_Utils_Tuple2(
					'condition',
					A2($elm$json$Json$Encode$list, testClause, tests)),
				A2($elm$core$List$concatMap, $author$project$VegaLite$textChannelProperties, elseClause));
		case 'TString':
			var s = tDef.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'value',
					$author$project$VegaLite$multilineTextSpec(s))
				]);
		default:
			var d = tDef.a;
			return _List_fromArray(
				[
					_Utils_Tuple2(
					'datum',
					$author$project$VegaLite$dataValueSpec(d))
				]);
	}
};
var $author$project$VegaLite$text = function (tDefs) {
	return $elm$core$List$cons(
		_Utils_Tuple2(
			'text',
			$elm$json$Json$Encode$object(
				A2($elm$core$List$concatMap, $author$project$VegaLite$textChannelProperties, tDefs))));
};
var $author$project$VegaLite$Text = {$: 'Text'};
var $author$project$VegaLite$textMark = $author$project$VegaLite$mark($author$project$VegaLite$Text);
var $author$project$VegaLite$toVegaLite = function (spec) {
	return $elm$json$Json$Encode$object(
		A2(
			$elm$core$List$cons,
			_Utils_Tuple2(
				'$schema',
				$elm$json$Json$Encode$string('https://vega.github.io/schema/vega-lite/v5.json')),
			A2(
				$elm$core$List$map,
				function (_v0) {
					var s = _v0.a;
					var v = _v0.b;
					return _Utils_Tuple2(
						$author$project$VegaLite$vlPropertyLabel(s),
						v);
				},
				spec)));
};
var $author$project$VegaLite$VAlignMiddle = {$: 'VAlignMiddle'};
var $author$project$VegaLite$vaMiddle = $author$project$VegaLite$VAlignMiddle;
var $author$project$GalleryLabel$label1 = function () {
	var specText = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				$author$project$VegaLite$encoding(
				A2(
					$author$project$VegaLite$text,
					_List_fromArray(
						[
							$author$project$VegaLite$tName('b'),
							$author$project$VegaLite$tQuant
						]),
					_List_Nil)),
				$author$project$VegaLite$textMark(
				_List_fromArray(
					[
						$author$project$VegaLite$maStyle(
						_List_fromArray(
							['label']))
					]))
			]));
	var specBar = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				$author$project$VegaLite$bar(_List_Nil)
			]));
	var enc = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			$author$project$VegaLite$encoding,
			A2(
				$author$project$VegaLite$position,
				$author$project$VegaLite$X,
				_List_fromArray(
					[
						$author$project$VegaLite$pName('b'),
						$author$project$VegaLite$pQuant
					]))),
		A2(
			$author$project$VegaLite$position,
			$author$project$VegaLite$Y,
			_List_fromArray(
				[
					$author$project$VegaLite$pName('a'),
					$author$project$VegaLite$pOrdinal
				])));
	var desc = $author$project$VegaLite$description('A simple bar chart with embedded data labels');
	var data = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			$author$project$VegaLite$dataFromColumns(_List_Nil),
			A2(
				$author$project$VegaLite$dataColumn,
				'a',
				$author$project$VegaLite$strs(
					_List_fromArray(
						['A', 'B', 'C'])))),
		A2(
			$author$project$VegaLite$dataColumn,
			'b',
			$author$project$VegaLite$nums(
				_List_fromArray(
					[28, 55, 43]))));
	var cfg = A2(
		$elm$core$Basics$composeL,
		$author$project$VegaLite$configure,
		$author$project$VegaLite$configuration(
			$author$project$VegaLite$coMarkStyles(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'label',
						_List_fromArray(
							[
								$author$project$VegaLite$maAlign($author$project$VegaLite$haLeft),
								$author$project$VegaLite$maBaseline($author$project$VegaLite$vaMiddle),
								$author$project$VegaLite$maDx(3)
							]))
					]))));
	return $author$project$VegaLite$toVegaLite(
		_List_fromArray(
			[
				desc,
				cfg(_List_Nil),
				data(_List_Nil),
				enc(_List_Nil),
				$author$project$VegaLite$layer(
				_List_fromArray(
					[specBar, specText]))
			]));
}();
var $author$project$VegaLite$X2 = {$: 'X2'};
var $author$project$VegaLite$AxDataCondition = F2(
	function (a, b) {
		return {$: 'AxDataCondition', a: a, b: b};
	});
var $author$project$VegaLite$axDataCondition = $author$project$VegaLite$AxDataCondition;
var $author$project$VegaLite$AxDomain = function (a) {
	return {$: 'AxDomain', a: a};
};
var $author$project$VegaLite$Boo = function (a) {
	return {$: 'Boo', a: a};
};
var $author$project$VegaLite$axDomain = function (b) {
	return $author$project$VegaLite$AxDomain(
		$author$project$VegaLite$Boo(b));
};
var $author$project$VegaLite$AxGrid = function (a) {
	return {$: 'AxGrid', a: a};
};
var $author$project$VegaLite$axGrid = function (b) {
	return $author$project$VegaLite$AxGrid(
		$author$project$VegaLite$Boo(b));
};
var $author$project$VegaLite$AxTicks = function (a) {
	return {$: 'AxTicks', a: a};
};
var $author$project$VegaLite$axTicks = function (b) {
	return $author$project$VegaLite$AxTicks(
		$author$project$VegaLite$Boo(b));
};
var $author$project$VegaLite$AxTitle = function (a) {
	return {$: 'AxTitle', a: a};
};
var $author$project$VegaLite$axTitle = function (s) {
	return $author$project$VegaLite$AxTitle(
		$author$project$VegaLite$Str(s));
};
var $author$project$VegaLite$CAxGridColor = F2(
	function (a, b) {
		return {$: 'CAxGridColor', a: a, b: b};
	});
var $author$project$VegaLite$cAxGridColor = $author$project$VegaLite$CAxGridColor;
var $author$project$VegaLite$Circle = {$: 'Circle'};
var $author$project$VegaLite$circle = $author$project$VegaLite$mark($author$project$VegaLite$Circle);
var $author$project$VegaLite$TitleStyle = function (a) {
	return {$: 'TitleStyle', a: a};
};
var $author$project$VegaLite$coTitle = $author$project$VegaLite$TitleStyle;
var $author$project$VegaLite$View = function (a) {
	return {$: 'View', a: a};
};
var $author$project$VegaLite$coView = $author$project$VegaLite$View;
var $author$project$VegaLite$color = function (markProps) {
	return $elm$core$List$cons(
		_Utils_Tuple2(
			'color',
			$elm$json$Json$Encode$object(
				A2($elm$core$List$concatMap, $author$project$VegaLite$markChannelProperties, markProps))));
};
var $author$project$VegaLite$DNumbers = function (a) {
	return {$: 'DNumbers', a: a};
};
var $author$project$VegaLite$doNums = $author$project$VegaLite$DNumbers;
var $author$project$VegaLite$Expr = function (a) {
	return {$: 'Expr', a: a};
};
var $author$project$VegaLite$expr = $author$project$VegaLite$Expr;
var $author$project$VegaLite$FExpr = function (a) {
	return {$: 'FExpr', a: a};
};
var $author$project$VegaLite$fiExpr = $author$project$VegaLite$FExpr;
var $author$project$VegaLite$filter = function (f) {
	return $elm$core$List$cons(
		_Utils_Tuple2(
			'filter',
			$author$project$VegaLite$filterSpec(f)));
};
var $author$project$VegaLite$HAlignRight = {$: 'HAlignRight'};
var $author$project$VegaLite$haRight = $author$project$VegaLite$HAlignRight;
var $author$project$VegaLite$MCondition = F3(
	function (a, b, c) {
		return {$: 'MCondition', a: a, b: b, c: c};
	});
var $author$project$VegaLite$mCondition = $author$project$VegaLite$MCondition;
var $author$project$VegaLite$MLegend = function (a) {
	return {$: 'MLegend', a: a};
};
var $author$project$VegaLite$mLegend = $author$project$VegaLite$MLegend;
var $author$project$VegaLite$MName = function (a) {
	return {$: 'MName', a: a};
};
var $author$project$VegaLite$mName = $author$project$VegaLite$MName;
var $author$project$VegaLite$MScale = function (a) {
	return {$: 'MScale', a: a};
};
var $author$project$VegaLite$mScale = $author$project$VegaLite$MScale;
var $author$project$VegaLite$MString = function (a) {
	return {$: 'MString', a: a};
};
var $author$project$VegaLite$mSymbol = function (sym) {
	return $author$project$VegaLite$MString(
		$author$project$VegaLite$symbolLabel(sym));
};
var $author$project$VegaLite$MdY = function (a) {
	return {$: 'MdY', a: a};
};
var $author$project$VegaLite$maDy = function (n) {
	return $author$project$VegaLite$MdY(
		$author$project$VegaLite$Num(n));
};
var $author$project$VegaLite$MFill = function (a) {
	return {$: 'MFill', a: a};
};
var $author$project$VegaLite$maFill = function (s) {
	return $author$project$VegaLite$MFill(
		$author$project$VegaLite$Str(s));
};
var $author$project$VegaLite$MFilled = function (a) {
	return {$: 'MFilled', a: a};
};
var $author$project$VegaLite$maFilled = function (b) {
	return $author$project$VegaLite$MFilled(
		$author$project$VegaLite$Boo(b));
};
var $author$project$VegaLite$MFontSize = function (a) {
	return {$: 'MFontSize', a: a};
};
var $author$project$VegaLite$maFontSize = function (n) {
	return $author$project$VegaLite$MFontSize(
		$author$project$VegaLite$Num(n));
};
var $author$project$VegaLite$MOpacity = function (a) {
	return {$: 'MOpacity', a: a};
};
var $author$project$VegaLite$maOpacity = function (n) {
	return $author$project$VegaLite$MOpacity(
		$author$project$VegaLite$Num(n));
};
var $author$project$VegaLite$MSize = function (a) {
	return {$: 'MSize', a: a};
};
var $author$project$VegaLite$maSize = function (n) {
	return $author$project$VegaLite$MSize(
		$author$project$VegaLite$Num(n));
};
var $author$project$VegaLite$MStroke = function (a) {
	return {$: 'MStroke', a: a};
};
var $author$project$VegaLite$maStroke = function (s) {
	return $author$project$VegaLite$MStroke(
		$author$project$VegaLite$Str(s));
};
var $author$project$VegaLite$MText = function (a) {
	return {$: 'MText', a: a};
};
var $author$project$VegaLite$maText = function (s) {
	return $author$project$VegaLite$MText(
		$author$project$VegaLite$Str(s));
};
var $elm$core$Basics$negate = function (n) {
	return -n;
};
var $author$project$VegaLite$PAxis = function (a) {
	return {$: 'PAxis', a: a};
};
var $author$project$VegaLite$pAxis = $author$project$VegaLite$PAxis;
var $author$project$VegaLite$PScale = function (a) {
	return {$: 'PScale', a: a};
};
var $author$project$VegaLite$pScale = $author$project$VegaLite$PScale;
var $author$project$VegaLite$Point = {$: 'Point'};
var $author$project$VegaLite$point = $author$project$VegaLite$mark($author$project$VegaLite$Point);
var $author$project$VegaLite$Test = function (a) {
	return {$: 'Test', a: a};
};
var $author$project$VegaLite$prTest = $author$project$VegaLite$Test;
var $author$project$VegaLite$RStrings = function (a) {
	return {$: 'RStrings', a: a};
};
var $author$project$VegaLite$raStrs = $author$project$VegaLite$RStrings;
var $author$project$VegaLite$Rule = {$: 'Rule'};
var $author$project$VegaLite$rule = $author$project$VegaLite$mark($author$project$VegaLite$Rule);
var $author$project$VegaLite$SDomain = function (a) {
	return {$: 'SDomain', a: a};
};
var $author$project$VegaLite$scDomain = $author$project$VegaLite$SDomain;
var $author$project$VegaLite$SRange = function (a) {
	return {$: 'SRange', a: a};
};
var $author$project$VegaLite$scRange = $author$project$VegaLite$SRange;
var $author$project$VegaLite$SZero = function (a) {
	return {$: 'SZero', a: a};
};
var $author$project$VegaLite$scZero = $author$project$VegaLite$SZero;
var $author$project$VegaLite$shape = function (markProps) {
	return $elm$core$List$cons(
		_Utils_Tuple2(
			'shape',
			$elm$json$Json$Encode$object(
				A2($elm$core$List$concatMap, $author$project$VegaLite$markChannelProperties, markProps))));
};
var $author$project$VegaLite$VLSpacing = {$: 'VLSpacing'};
var $author$project$VegaLite$spacing = function (sp) {
	return _Utils_Tuple2(
		$author$project$VegaLite$VLSpacing,
		$elm$json$Json$Encode$float(sp));
};
var $author$project$VegaLite$SymTriangleLeft = {$: 'SymTriangleLeft'};
var $author$project$VegaLite$symTriangleLeft = $author$project$VegaLite$SymTriangleLeft;
var $author$project$VegaLite$SymTriangleRight = {$: 'SymTriangleRight'};
var $author$project$VegaLite$symTriangleRight = $author$project$VegaLite$SymTriangleRight;
var $author$project$VegaLite$FrBounds = {$: 'FrBounds'};
var $author$project$VegaLite$tfBounds = $author$project$VegaLite$FrBounds;
var $author$project$VegaLite$TFrame = function (a) {
	return {$: 'TFrame', a: a};
};
var $author$project$VegaLite$tiFrame = $author$project$VegaLite$TFrame;
var $author$project$VegaLite$TFontSize = function (a) {
	return {$: 'TFontSize', a: a};
};
var $author$project$VegaLite$ticoFontSize = function (n) {
	return $author$project$VegaLite$TFontSize(
		$author$project$VegaLite$Num(n));
};
var $author$project$VegaLite$VLTitle = {$: 'VLTitle'};
var $author$project$VegaLite$title = F2(
	function (txt, tps) {
		return _Utils_Tuple2(
			$author$project$VegaLite$VLTitle,
			$elm$json$Json$Encode$object(
				A2(
					$elm$core$List$cons,
					_Utils_Tuple2(
						'text',
						$author$project$VegaLite$multilineTextSpec(txt)),
					A2($elm$core$List$concatMap, $author$project$VegaLite$titleConfigProperty, tps))));
	});
var $author$project$VegaLite$VLTransform = {$: 'VLTransform'};
var $elm$core$List$isEmpty = function (xs) {
	if (!xs.b) {
		return true;
	} else {
		return false;
	}
};
var $author$project$VegaLite$transform = function (transforms) {
	var assemble = function (_v1) {
		var trName = _v1.a;
		var val = _v1.b;
		if (trName === 'multiSpecs') {
			return val;
		} else {
			return $elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(trName, val)
					]));
		}
	};
	return $elm$core$List$isEmpty(transforms) ? _Utils_Tuple2($author$project$VegaLite$VLTransform, $elm$json$Json$Encode$null) : _Utils_Tuple2(
		$author$project$VegaLite$VLTransform,
		A2($elm$json$Json$Encode$list, assemble, transforms));
};
var $author$project$VegaLite$VLVConcat = {$: 'VLVConcat'};
var $author$project$VegaLite$vConcat = function (specs) {
	return _Utils_Tuple2(
		$author$project$VegaLite$VLVConcat,
		$author$project$VegaLite$toList(specs));
};
var $author$project$VegaLite$VStroke = function (a) {
	return {$: 'VStroke', a: a};
};
var $author$project$VegaLite$vicoStroke = $author$project$VegaLite$VStroke;
var $author$project$GalleryLabel$label10 = function () {
	var transLabel4 = A2(
		$elm$core$Basics$composeL,
		$author$project$VegaLite$transform,
		$author$project$VegaLite$filter(
			$author$project$VegaLite$fiExpr('datum.label !== \'PoleStar\'')));
	var transLabel3 = A2(
		$elm$core$Basics$composeL,
		$author$project$VegaLite$transform,
		$author$project$VegaLite$filter(
			$author$project$VegaLite$fiExpr('datum.label === \'PoleStar\'')));
	var likertData = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			A2(
				$elm$core$Basics$composeL,
				A2(
					$elm$core$Basics$composeL,
					A2(
						$elm$core$Basics$composeL,
						$author$project$VegaLite$dataFromColumns(_List_Nil),
						A2(
							$author$project$VegaLite$dataColumn,
							'measure',
							$author$project$VegaLite$strs(
								_List_fromArray(
									['Open Exploration', 'Focused Question Answering', 'Open Exploration', 'Focused Question Answering'])))),
					A2(
						$author$project$VegaLite$dataColumn,
						'mean',
						$author$project$VegaLite$nums(
							_List_fromArray(
								[1.81, -1.69, 2.19, -0.06])))),
				A2(
					$author$project$VegaLite$dataColumn,
					'lo',
					$author$project$VegaLite$nums(
						_List_fromArray(
							[1.26, -2.33, 1.67, -0.47])))),
			A2(
				$author$project$VegaLite$dataColumn,
				'hi',
				$author$project$VegaLite$nums(
					_List_fromArray(
						[2.37, -1.05, 2.71, 0.35])))),
		A2(
			$author$project$VegaLite$dataColumn,
			'study',
			$author$project$VegaLite$strs(
				_List_fromArray(
					['PoleStar vs Voyager', 'PoleStar vs Voyager', 'PoleStar vs Voyager 2', 'PoleStar vs Voyager 2']))));
	var labelData = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			A2(
				$elm$core$Basics$composeL,
				$author$project$VegaLite$dataFromColumns(_List_Nil),
				A2(
					$author$project$VegaLite$dataColumn,
					'from',
					$author$project$VegaLite$nums(
						_List_fromArray(
							[-0.25, 0.25])))),
			A2(
				$author$project$VegaLite$dataColumn,
				'to',
				$author$project$VegaLite$nums(
					_List_fromArray(
						[-2.9, 2.9])))),
		A2(
			$author$project$VegaLite$dataColumn,
			'label',
			$author$project$VegaLite$strs(
				_List_fromArray(
					['PoleStar', 'Voyager / Voyager 2']))));
	var encLikertWhiskers = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			$author$project$VegaLite$encoding,
			A2(
				$author$project$VegaLite$position,
				$author$project$VegaLite$X,
				_List_fromArray(
					[
						$author$project$VegaLite$pName('lo'),
						$author$project$VegaLite$pQuant,
						$author$project$VegaLite$pScale(
						_List_fromArray(
							[
								$author$project$VegaLite$scDomain(
								$author$project$VegaLite$doNums(
									_List_fromArray(
										[-3, 3])))
							])),
						$author$project$VegaLite$pAxis(
						_List_fromArray(
							[
								$author$project$VegaLite$axTitle(''),
								$author$project$VegaLite$axGridDash(
								_List_fromArray(
									[3, 3])),
								A2(
								$author$project$VegaLite$axDataCondition,
								$author$project$VegaLite$expr('datum.value === 0'),
								A2($author$project$VegaLite$cAxGridColor, '#666', '#ccc'))
							]))
					]))),
		A2(
			$author$project$VegaLite$position,
			$author$project$VegaLite$X2,
			_List_fromArray(
				[
					$author$project$VegaLite$pName('hi')
				])));
	var specLikertWhiskers = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				encLikertWhiskers(_List_Nil),
				$author$project$VegaLite$rule(_List_Nil)
			]));
	var encLikertMeans = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			$author$project$VegaLite$encoding,
			A2(
				$author$project$VegaLite$position,
				$author$project$VegaLite$X,
				_List_fromArray(
					[
						$author$project$VegaLite$pName('mean'),
						$author$project$VegaLite$pQuant
					]))),
		$author$project$VegaLite$color(
			_List_fromArray(
				[
					$author$project$VegaLite$mName('measure'),
					$author$project$VegaLite$mScale(
					_List_fromArray(
						[
							$author$project$VegaLite$scRange(
							$author$project$VegaLite$raStrs(
								_List_fromArray(
									['black', 'white'])))
						])),
					$author$project$VegaLite$mLegend(_List_Nil)
				])));
	var specLikertMeans = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				encLikertMeans(_List_Nil),
				$author$project$VegaLite$circle(
				_List_fromArray(
					[
						$author$project$VegaLite$maStroke('black'),
						$author$project$VegaLite$maOpacity(1)
					]))
			]));
	var encLikert = A2(
		$elm$core$Basics$composeL,
		$author$project$VegaLite$encoding,
		A2(
			$author$project$VegaLite$position,
			$author$project$VegaLite$Y,
			_List_fromArray(
				[
					$author$project$VegaLite$pName('study'),
					$author$project$VegaLite$pAxis(
					_List_fromArray(
						[
							$author$project$VegaLite$axTitle(''),
							$author$project$VegaLite$axLabelPadding(5),
							$author$project$VegaLite$axDomain(false),
							$author$project$VegaLite$axTicks(false),
							$author$project$VegaLite$axGrid(false)
						]))
				])));
	var specLikert = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				A2(
				$author$project$VegaLite$title,
				'Mean of Subject Ratings (95% CIs)',
				_List_fromArray(
					[
						$author$project$VegaLite$tiFrame($author$project$VegaLite$tfBounds)
					])),
				encLikert(_List_Nil),
				$author$project$VegaLite$layer(
				_List_fromArray(
					[specLikertWhiskers, specLikertMeans]))
			]));
	var encLabel4 = A2(
		$elm$core$Basics$composeL,
		$author$project$VegaLite$encoding,
		A2(
			$author$project$VegaLite$position,
			$author$project$VegaLite$X,
			_List_fromArray(
				[
					$author$project$VegaLite$pName('from'),
					$author$project$VegaLite$pQuant,
					$author$project$VegaLite$pAxis(_List_Nil)
				])));
	var specLabel4 = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				transLabel4(_List_Nil),
				encLabel4(_List_Nil),
				$author$project$VegaLite$textMark(
				_List_fromArray(
					[
						$author$project$VegaLite$maText('Voyager / Voyager 2\nmore valuable'),
						$author$project$VegaLite$maAlign($author$project$VegaLite$haLeft),
						$author$project$VegaLite$maStyle(
						_List_fromArray(
							['arrow-label']))
					]))
			]));
	var encLabel3 = A2(
		$elm$core$Basics$composeL,
		$author$project$VegaLite$encoding,
		A2(
			$author$project$VegaLite$position,
			$author$project$VegaLite$X,
			_List_fromArray(
				[
					$author$project$VegaLite$pName('from'),
					$author$project$VegaLite$pQuant,
					$author$project$VegaLite$pAxis(_List_Nil)
				])));
	var specLabel3 = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				transLabel3(_List_Nil),
				encLabel3(_List_Nil),
				$author$project$VegaLite$textMark(
				_List_fromArray(
					[
						$author$project$VegaLite$maText('PoleStar\nmore valuable'),
						$author$project$VegaLite$maAlign($author$project$VegaLite$haRight),
						$author$project$VegaLite$maStyle(
						_List_fromArray(
							['arrow-label']))
					]))
			]));
	var encLabel2 = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			$author$project$VegaLite$encoding,
			A2(
				$author$project$VegaLite$position,
				$author$project$VegaLite$X,
				_List_fromArray(
					[
						$author$project$VegaLite$pName('to'),
						$author$project$VegaLite$pQuant,
						$author$project$VegaLite$pAxis(_List_Nil)
					]))),
		$author$project$VegaLite$shape(
			_List_fromArray(
				[
					A3(
					$author$project$VegaLite$mCondition,
					$author$project$VegaLite$prTest(
						$author$project$VegaLite$expr('datum.to > 0')),
					_List_fromArray(
						[
							$author$project$VegaLite$mSymbol($author$project$VegaLite$symTriangleRight)
						]),
					_List_fromArray(
						[
							$author$project$VegaLite$mSymbol($author$project$VegaLite$symTriangleLeft)
						]))
				])));
	var specLabel2 = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				encLabel2(_List_Nil),
				$author$project$VegaLite$point(
				_List_fromArray(
					[
						$author$project$VegaLite$maFilled(true),
						$author$project$VegaLite$maSize(60),
						$author$project$VegaLite$maFill('black')
					]))
			]));
	var encLabel1 = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			$author$project$VegaLite$encoding,
			A2(
				$author$project$VegaLite$position,
				$author$project$VegaLite$X,
				_List_fromArray(
					[
						$author$project$VegaLite$pName('from'),
						$author$project$VegaLite$pQuant,
						$author$project$VegaLite$pScale(
						_List_fromArray(
							[
								$author$project$VegaLite$scZero(false)
							])),
						$author$project$VegaLite$pAxis(_List_Nil)
					]))),
		A2(
			$author$project$VegaLite$position,
			$author$project$VegaLite$X2,
			_List_fromArray(
				[
					$author$project$VegaLite$pName('to')
				])));
	var specLabel1 = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				encLabel1(_List_Nil),
				$author$project$VegaLite$rule(_List_Nil)
			]));
	var specLabels = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				labelData(_List_Nil),
				$author$project$VegaLite$layer(
				_List_fromArray(
					[specLabel1, specLabel2, specLabel3, specLabel4]))
			]));
	var desc = $author$project$VegaLite$description('Comparing Likert scale ratings between two conditions.');
	var cfg = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			A2(
				$elm$core$Basics$composeL,
				$author$project$VegaLite$configure,
				$author$project$VegaLite$configuration(
					$author$project$VegaLite$coView(
						_List_fromArray(
							[
								$author$project$VegaLite$vicoStroke($elm$core$Maybe$Nothing)
							])))),
			$author$project$VegaLite$configuration(
				$author$project$VegaLite$coMarkStyles(
					_List_fromArray(
						[
							_Utils_Tuple2(
							'arrow-label',
							_List_fromArray(
								[
									$author$project$VegaLite$maDy(12),
									$author$project$VegaLite$maFontSize(9.5)
								]))
						])))),
		$author$project$VegaLite$configuration(
			$author$project$VegaLite$coTitle(
				_List_fromArray(
					[
						$author$project$VegaLite$ticoFontSize(12)
					]))));
	return $author$project$VegaLite$toVegaLite(
		_List_fromArray(
			[
				desc,
				cfg(_List_Nil),
				likertData(_List_Nil),
				$author$project$VegaLite$spacing(10),
				$author$project$VegaLite$vConcat(
				_List_fromArray(
					[specLikert, specLabels]))
			]));
}();
var $author$project$VegaLite$ChX = {$: 'ChX'};
var $author$project$VegaLite$chX = $author$project$VegaLite$ChX;
var $author$project$VegaLite$MmType = function (a) {
	return {$: 'MmType', a: a};
};
var $author$project$VegaLite$mQuant = $author$project$VegaLite$MmType($author$project$VegaLite$Quantitative);
var $author$project$VegaLite$mStr = $author$project$VegaLite$MString;
var $author$project$VegaLite$MXOffset = function (a) {
	return {$: 'MXOffset', a: a};
};
var $author$project$VegaLite$maXOffset = function (n) {
	return $author$project$VegaLite$MXOffset(
		$author$project$VegaLite$Num(n));
};
var $author$project$VegaLite$PSort = function (a) {
	return {$: 'PSort', a: a};
};
var $author$project$VegaLite$pSort = $author$project$VegaLite$PSort;
var $author$project$VegaLite$ByChannel = function (a) {
	return {$: 'ByChannel', a: a};
};
var $author$project$VegaLite$soByChannel = $author$project$VegaLite$ByChannel;
var $author$project$VegaLite$Descending = {$: 'Descending'};
var $author$project$VegaLite$soDescending = $author$project$VegaLite$Descending;
var $author$project$VegaLite$VLWidth = {$: 'VLWidth'};
var $author$project$VegaLite$width = function (w) {
	return _Utils_Tuple2(
		$author$project$VegaLite$VLWidth,
		$elm$json$Json$Encode$float(w));
};
var $author$project$GalleryLabel$label2 = function () {
	var labelEnc = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			$author$project$VegaLite$encoding,
			$author$project$VegaLite$text(
				_List_fromArray(
					[
						$author$project$VegaLite$tName('count'),
						$author$project$VegaLite$tQuant
					]))),
		$author$project$VegaLite$color(
			_List_fromArray(
				[
					A3(
					$author$project$VegaLite$mCondition,
					$author$project$VegaLite$prTest(
						$author$project$VegaLite$expr('datum.count > 10')),
					_List_fromArray(
						[
							$author$project$VegaLite$mStr('white')
						]),
					_List_fromArray(
						[
							$author$project$VegaLite$mStr('black')
						]))
				])));
	var specText = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				labelEnc(_List_Nil),
				$author$project$VegaLite$textMark(
				_List_fromArray(
					[
						$author$project$VegaLite$maAlign($author$project$VegaLite$haRight),
						$author$project$VegaLite$maXOffset(-4)
					]))
			]));
	var enc = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			$author$project$VegaLite$encoding,
			A2(
				$author$project$VegaLite$position,
				$author$project$VegaLite$X,
				_List_fromArray(
					[
						$author$project$VegaLite$pName('count'),
						$author$project$VegaLite$pQuant,
						$author$project$VegaLite$pAxis(
						_List_fromArray(
							[
								$author$project$VegaLite$axGrid(false),
								$author$project$VegaLite$axTitle('')
							]))
					]))),
		A2(
			$author$project$VegaLite$position,
			$author$project$VegaLite$Y,
			_List_fromArray(
				[
					$author$project$VegaLite$pName('fruit'),
					$author$project$VegaLite$pOrdinal,
					$author$project$VegaLite$pSort(
					_List_fromArray(
						[
							$author$project$VegaLite$soByChannel($author$project$VegaLite$chX),
							$author$project$VegaLite$soDescending
						])),
					$author$project$VegaLite$pAxis(
					_List_fromArray(
						[
							$author$project$VegaLite$axTitle(''),
							$author$project$VegaLite$axTicks(false)
						]))
				])));
	var desc = $author$project$VegaLite$description('Version of bar chart from https://observablehq.com/@d3/learn-d3-scales.');
	var data = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			$author$project$VegaLite$dataFromColumns(_List_Nil),
			A2(
				$author$project$VegaLite$dataColumn,
				'fruit',
				$author$project$VegaLite$strs(
					_List_fromArray(
						['🍊', '🍇', '🍏', '🍌', '🍐', '🍋', '🍎', '🍉'])))),
		A2(
			$author$project$VegaLite$dataColumn,
			'count',
			$author$project$VegaLite$nums(
				_List_fromArray(
					[21, 13, 8, 5, 3, 2, 1, 1]))));
	var cfg = A2(
		$elm$core$Basics$composeL,
		$author$project$VegaLite$configure,
		$author$project$VegaLite$configuration(
			$author$project$VegaLite$coView(
				_List_fromArray(
					[
						$author$project$VegaLite$vicoStroke($elm$core$Maybe$Nothing)
					]))));
	var barEnc = A2(
		$elm$core$Basics$composeL,
		$author$project$VegaLite$encoding,
		$author$project$VegaLite$color(
			_List_fromArray(
				[
					$author$project$VegaLite$mName('count'),
					$author$project$VegaLite$mQuant,
					$author$project$VegaLite$mLegend(_List_Nil)
				])));
	var specBar = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				barEnc(_List_Nil),
				$author$project$VegaLite$bar(_List_Nil)
			]));
	return $author$project$VegaLite$toVegaLite(
		_List_fromArray(
			[
				desc,
				cfg(_List_Nil),
				$author$project$VegaLite$width(400),
				data(_List_Nil),
				enc(_List_Nil),
				$author$project$VegaLite$layer(
				_List_fromArray(
					[specBar, specText]))
			]));
}();
var $author$project$VegaLite$Scale = function (a) {
	return {$: 'Scale', a: a};
};
var $author$project$VegaLite$coScale = $author$project$VegaLite$Scale;
var $author$project$VegaLite$TextStyle = function (a) {
	return {$: 'TextStyle', a: a};
};
var $author$project$VegaLite$coText = $author$project$VegaLite$TextStyle;
var $author$project$VegaLite$dataFromUrl = F2(
	function (u, fmts) {
		return _Utils_eq(fmts, _List_Nil) ? _Utils_Tuple2(
			$author$project$VegaLite$VLData,
			$elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'url',
						$elm$json$Json$Encode$string(u))
					]))) : _Utils_Tuple2(
			$author$project$VegaLite$VLData,
			$elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'url',
						$elm$json$Json$Encode$string(u)),
						_Utils_Tuple2(
						'format',
						$elm$json$Json$Encode$object(
							A2($elm$core$List$concatMap, $author$project$VegaLite$formatProperties, fmts)))
					])));
	});
var $author$project$VegaLite$MAggregate = function (a) {
	return {$: 'MAggregate', a: a};
};
var $author$project$VegaLite$mAggregate = $author$project$VegaLite$MAggregate;
var $author$project$VegaLite$Count = {$: 'Count'};
var $author$project$VegaLite$opCount = $author$project$VegaLite$Count;
var $author$project$GalleryLabel$path = 'https://cdn.jsdelivr.net/npm/vega-datasets@2.2/data/';
var $author$project$VegaLite$Rect = {$: 'Rect'};
var $author$project$VegaLite$rect = $author$project$VegaLite$mark($author$project$VegaLite$Rect);
var $author$project$VegaLite$SCBandPaddingInner = function (a) {
	return {$: 'SCBandPaddingInner', a: a};
};
var $author$project$VegaLite$sacoBandPaddingInner = $author$project$VegaLite$SCBandPaddingInner;
var $author$project$VegaLite$SCBandPaddingOuter = function (a) {
	return {$: 'SCBandPaddingOuter', a: a};
};
var $author$project$VegaLite$sacoBandPaddingOuter = $author$project$VegaLite$SCBandPaddingOuter;
var $author$project$VegaLite$TAggregate = function (a) {
	return {$: 'TAggregate', a: a};
};
var $author$project$VegaLite$tAggregate = $author$project$VegaLite$TAggregate;
var $author$project$GalleryLabel$label3 = function () {
	var encText = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			$author$project$VegaLite$encoding,
			$author$project$VegaLite$color(
				_List_fromArray(
					[
						$author$project$VegaLite$mStr('white')
					]))),
		$author$project$VegaLite$text(
			_List_fromArray(
				[
					$author$project$VegaLite$tName('*'),
					$author$project$VegaLite$tAggregate($author$project$VegaLite$opCount)
				])));
	var specText = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				$author$project$VegaLite$textMark(_List_Nil),
				encText(_List_Nil)
			]));
	var encRect = A2(
		$elm$core$Basics$composeL,
		$author$project$VegaLite$encoding,
		$author$project$VegaLite$color(
			_List_fromArray(
				[
					$author$project$VegaLite$mName('*'),
					$author$project$VegaLite$mAggregate($author$project$VegaLite$opCount)
				])));
	var specRect = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				$author$project$VegaLite$rect(_List_Nil),
				encRect(_List_Nil)
			]));
	var encPos = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			$author$project$VegaLite$encoding,
			A2(
				$author$project$VegaLite$position,
				$author$project$VegaLite$X,
				_List_fromArray(
					[
						$author$project$VegaLite$pName('Cylinders'),
						$author$project$VegaLite$pOrdinal
					]))),
		A2(
			$author$project$VegaLite$position,
			$author$project$VegaLite$Y,
			_List_fromArray(
				[
					$author$project$VegaLite$pName('Origin'),
					$author$project$VegaLite$pOrdinal
				])));
	var desc = $author$project$VegaLite$description('Layering text over \'heatmap\'');
	var data = A2($author$project$VegaLite$dataFromUrl, $author$project$GalleryLabel$path + 'cars.json', _List_Nil);
	var cfg = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			$author$project$VegaLite$configure,
			$author$project$VegaLite$configuration(
				$author$project$VegaLite$coScale(
					_List_fromArray(
						[
							$author$project$VegaLite$sacoBandPaddingInner(0),
							$author$project$VegaLite$sacoBandPaddingOuter(0)
						])))),
		$author$project$VegaLite$configuration(
			$author$project$VegaLite$coText(
				_List_fromArray(
					[
						$author$project$VegaLite$maBaseline($author$project$VegaLite$vaMiddle)
					]))));
	return $author$project$VegaLite$toVegaLite(
		_List_fromArray(
			[
				desc,
				cfg(_List_Nil),
				data,
				encPos(_List_Nil),
				$author$project$VegaLite$layer(
				_List_fromArray(
					[specRect, specText]))
			]));
}();
var $author$project$VegaLite$AxTickCount = function (a) {
	return {$: 'AxTickCount', a: a};
};
var $author$project$VegaLite$axTickCount = $author$project$VegaLite$AxTickCount;
var $author$project$VegaLite$calculateAs = F2(
	function (ex, label) {
		return $elm$core$List$cons(
			_Utils_Tuple2(
				'multiSpecs',
				$elm$json$Json$Encode$object(
					_List_fromArray(
						[
							_Utils_Tuple2(
							'calculate',
							$elm$json$Json$Encode$string(ex)),
							_Utils_Tuple2(
							'as',
							$elm$json$Json$Encode$string(label))
						]))));
	});
var $author$project$VegaLite$FEqual = F2(
	function (a, b) {
		return {$: 'FEqual', a: a, b: b};
	});
var $author$project$VegaLite$fiEqual = $author$project$VegaLite$FEqual;
var $author$project$VegaLite$FoUtc = function (a) {
	return {$: 'FoUtc', a: a};
};
var $author$project$VegaLite$foUtc = $author$project$VegaLite$FoUtc;
var $author$project$VegaLite$VLHeight = {$: 'VLHeight'};
var $author$project$VegaLite$height = function (h) {
	return _Utils_Tuple2(
		$author$project$VegaLite$VLHeight,
		$elm$json$Json$Encode$float(h));
};
var $author$project$VegaLite$Line = {$: 'Line'};
var $author$project$VegaLite$line = $author$project$VegaLite$mark($author$project$VegaLite$Line);
var $author$project$VegaLite$mOrdinal = $author$project$VegaLite$MmType($author$project$VegaLite$Ordinal);
var $author$project$VegaLite$NTickCount = function (a) {
	return {$: 'NTickCount', a: a};
};
var $author$project$VegaLite$niTickCount = $author$project$VegaLite$NTickCount;
var $author$project$VegaLite$PTitle = function (a) {
	return {$: 'PTitle', a: a};
};
var $author$project$VegaLite$pTitle = $author$project$VegaLite$PTitle;
var $author$project$VegaLite$Parse = function (a) {
	return {$: 'Parse', a: a};
};
var $author$project$VegaLite$parse = $author$project$VegaLite$Parse;
var $author$project$VegaLite$SScheme = F2(
	function (a, b) {
		return {$: 'SScheme', a: a, b: b};
	});
var $author$project$VegaLite$scScheme = $author$project$VegaLite$SScheme;
var $author$project$VegaLite$DStr = function (a) {
	return {$: 'DStr', a: a};
};
var $author$project$VegaLite$str = $author$project$VegaLite$DStr;
var $author$project$VegaLite$VAlignBottom = {$: 'VAlignBottom'};
var $author$project$VegaLite$vaBottom = $author$project$VegaLite$VAlignBottom;
var $author$project$VegaLite$VAlignTop = {$: 'VAlignTop'};
var $author$project$VegaLite$vaTop = $author$project$VegaLite$VAlignTop;
var $author$project$VegaLite$WAscending = function (a) {
	return {$: 'WAscending', a: a};
};
var $author$project$VegaLite$wiAscending = $author$project$VegaLite$WAscending;
var $author$project$VegaLite$WField = function (a) {
	return {$: 'WField', a: a};
};
var $author$project$VegaLite$wiField = $author$project$VegaLite$WField;
var $author$project$VegaLite$WFrame = F2(
	function (a, b) {
		return {$: 'WFrame', a: a, b: b};
	});
var $author$project$VegaLite$wiFrame = $author$project$VegaLite$WFrame;
var $author$project$VegaLite$WGroupBy = function (a) {
	return {$: 'WGroupBy', a: a};
};
var $author$project$VegaLite$wiGroupBy = $author$project$VegaLite$WGroupBy;
var $author$project$VegaLite$WOp = function (a) {
	return {$: 'WOp', a: a};
};
var $author$project$VegaLite$wiOp = $author$project$VegaLite$WOp;
var $author$project$VegaLite$WSort = function (a) {
	return {$: 'WSort', a: a};
};
var $author$project$VegaLite$wiSort = $author$project$VegaLite$WSort;
var $author$project$VegaLite$wOperationLabel = function (op) {
	switch (op.$) {
		case 'RowNumber':
			return 'row_number';
		case 'Rank':
			return 'rank';
		case 'DenseRank':
			return 'dense_rank';
		case 'PercentRank':
			return 'percent_rank';
		case 'CumeDist':
			return 'cume_dist';
		case 'Ntile':
			return 'ntile';
		case 'Lag':
			return 'lag';
		case 'Lead':
			return 'lead';
		case 'FirstValue':
			return 'first_value';
		case 'LastValue':
			return 'last_value';
		default:
			return 'nth_value';
	}
};
var $author$project$VegaLite$windowFieldProperty = function (w) {
	switch (w.$) {
		case 'WAggregateOp':
			var op = w.a;
			return _Utils_Tuple2(
				'op',
				$author$project$VegaLite$operationSpec(op));
		case 'WOp':
			var op = w.a;
			return _Utils_Tuple2(
				'op',
				$elm$json$Json$Encode$string(
					$author$project$VegaLite$wOperationLabel(op)));
		case 'WParam':
			var n = w.a;
			return _Utils_Tuple2(
				'param',
				$elm$json$Json$Encode$int(n));
		default:
			var f = w.a;
			return _Utils_Tuple2(
				'field',
				$elm$json$Json$Encode$string(f));
	}
};
var $author$project$VegaLite$sortFieldProperties = function (wsf) {
	if (wsf.$ === 'WAscending') {
		var f = wsf.a;
		return _List_fromArray(
			[
				_Utils_Tuple2(
				'field',
				$elm$json$Json$Encode$string(f)),
				_Utils_Tuple2(
				'order',
				$elm$json$Json$Encode$string('ascending'))
			]);
	} else {
		var f = wsf.a;
		return _List_fromArray(
			[
				_Utils_Tuple2(
				'field',
				$elm$json$Json$Encode$string(f)),
				_Utils_Tuple2(
				'order',
				$elm$json$Json$Encode$string('descending'))
			]);
	}
};
var $author$project$VegaLite$windowProperty = function (wProp) {
	switch (wProp.$) {
		case 'WFrame':
			if (wProp.a.$ === 'Just') {
				if (wProp.b.$ === 'Just') {
					var n1 = wProp.a.a;
					var n2 = wProp.b.a;
					return _Utils_Tuple2(
						'frame',
						A2(
							$elm$json$Json$Encode$list,
							$elm$json$Json$Encode$int,
							_List_fromArray(
								[n1, n2])));
				} else {
					var n1 = wProp.a.a;
					var _v2 = wProp.b;
					return _Utils_Tuple2(
						'frame',
						$author$project$VegaLite$toList(
							_List_fromArray(
								[
									$elm$json$Json$Encode$int(n1),
									$elm$json$Json$Encode$null
								])));
				}
			} else {
				if (wProp.b.$ === 'Just') {
					var _v1 = wProp.a;
					var n2 = wProp.b.a;
					return _Utils_Tuple2(
						'frame',
						$author$project$VegaLite$toList(
							_List_fromArray(
								[
									$elm$json$Json$Encode$null,
									$elm$json$Json$Encode$int(n2)
								])));
				} else {
					var _v3 = wProp.a;
					var _v4 = wProp.b;
					return _Utils_Tuple2(
						'frame',
						$author$project$VegaLite$toList(
							_List_fromArray(
								[$elm$json$Json$Encode$null, $elm$json$Json$Encode$null])));
				}
			}
		case 'WIgnorePeers':
			var b = wProp.a;
			return _Utils_Tuple2(
				'ignorePeers',
				$elm$json$Json$Encode$bool(b));
		case 'WGroupBy':
			var fs = wProp.a;
			return _Utils_Tuple2(
				'groupby',
				A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$string, fs));
		default:
			var sfs = wProp.a;
			return _Utils_Tuple2(
				'sort',
				A2(
					$elm$json$Json$Encode$list,
					A2($elm$core$Basics$composeR, $author$project$VegaLite$sortFieldProperties, $elm$json$Json$Encode$object),
					sfs));
	}
};
var $author$project$VegaLite$window = F2(
	function (wss, wProps) {
		var winFieldDef = F2(
			function (ws, outName) {
				return $elm$json$Json$Encode$object(
					A2(
						$elm$core$List$cons,
						_Utils_Tuple2(
							'as',
							$elm$json$Json$Encode$string(outName)),
						A2($elm$core$List$map, $author$project$VegaLite$windowFieldProperty, ws)));
			});
		return $elm$core$List$cons(
			_Utils_Tuple2(
				'multiSpecs',
				$elm$json$Json$Encode$object(
					A2(
						$elm$core$List$cons,
						_Utils_Tuple2(
							'window',
							A2(
								$elm$json$Json$Encode$list,
								function (_v0) {
									var ws = _v0.a;
									var out = _v0.b;
									return A2(winFieldDef, ws, out);
								},
								wss)),
						A2($elm$core$List$map, $author$project$VegaLite$windowProperty, wProps)))));
	});
var $author$project$VegaLite$FirstValue = {$: 'FirstValue'};
var $author$project$VegaLite$woFirstValue = $author$project$VegaLite$FirstValue;
var $author$project$VegaLite$LastValue = {$: 'LastValue'};
var $author$project$VegaLite$woLastValue = $author$project$VegaLite$LastValue;
var $author$project$GalleryLabel$label4 = function () {
	var transTextMin = A2(
		$elm$core$Basics$composeL,
		$author$project$VegaLite$transform,
		$author$project$VegaLite$filter(
			A2(
				$author$project$VegaLite$fiEqual,
				'end',
				$author$project$VegaLite$str('first'))));
	var transTextMax = A2(
		$elm$core$Basics$composeL,
		$author$project$VegaLite$transform,
		$author$project$VegaLite$filter(
			A2(
				$author$project$VegaLite$fiEqual,
				'end',
				$author$project$VegaLite$str('last'))));
	var trans = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			A2(
				$elm$core$Basics$composeL,
				A2(
					$elm$core$Basics$composeL,
					A2(
						$elm$core$Basics$composeL,
						$author$project$VegaLite$transform,
						A2($author$project$VegaLite$calculateAs, 'year(datum.Date)', 'year')),
					A2($author$project$VegaLite$calculateAs, 'floor(datum.year / 10)', 'decade')),
				A2($author$project$VegaLite$calculateAs, '(datum.year % 10) + (month(datum.Date)/12)', 'scaled_date')),
			A2(
				$author$project$VegaLite$window,
				_List_fromArray(
					[
						_Utils_Tuple2(
						_List_fromArray(
							[
								$author$project$VegaLite$wiOp($author$project$VegaLite$woFirstValue),
								$author$project$VegaLite$wiField('scaled_date')
							]),
						'first_date'),
						_Utils_Tuple2(
						_List_fromArray(
							[
								$author$project$VegaLite$wiOp($author$project$VegaLite$woLastValue),
								$author$project$VegaLite$wiField('scaled_date')
							]),
						'last_date')
					]),
				_List_fromArray(
					[
						$author$project$VegaLite$wiSort(
						_List_fromArray(
							[
								$author$project$VegaLite$wiAscending('scaled_date')
							])),
						$author$project$VegaLite$wiGroupBy(
						_List_fromArray(
							['decade'])),
						A2($author$project$VegaLite$wiFrame, $elm$core$Maybe$Nothing, $elm$core$Maybe$Nothing)
					]))),
		A2($author$project$VegaLite$calculateAs, 'datum.first_date === datum.scaled_date ? \'first\' : datum.last_date === datum.scaled_date ? \'last\' : null', 'end'));
	var encTextMin = A2(
		$elm$core$Basics$composeL,
		$author$project$VegaLite$encoding,
		$author$project$VegaLite$text(
			_List_fromArray(
				[
					$author$project$VegaLite$tName('year')
				])));
	var specTextMin = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				transTextMin(_List_Nil),
				encTextMin(_List_Nil),
				$author$project$VegaLite$textMark(
				_List_fromArray(
					[
						$author$project$VegaLite$maBaseline($author$project$VegaLite$vaTop)
					]))
			]));
	var encTextMax = A2(
		$elm$core$Basics$composeL,
		$author$project$VegaLite$encoding,
		$author$project$VegaLite$text(
			_List_fromArray(
				[
					$author$project$VegaLite$tName('year')
				])));
	var specTextMax = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				transTextMax(_List_Nil),
				encTextMax(_List_Nil),
				$author$project$VegaLite$textMark(
				_List_fromArray(
					[
						$author$project$VegaLite$maBaseline($author$project$VegaLite$vaBottom)
					]))
			]));
	var encPosition = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			$author$project$VegaLite$encoding,
			A2(
				$author$project$VegaLite$position,
				$author$project$VegaLite$X,
				_List_fromArray(
					[
						$author$project$VegaLite$pName('scaled_date'),
						$author$project$VegaLite$pQuant,
						$author$project$VegaLite$pAxis(
						_List_fromArray(
							[
								$author$project$VegaLite$axTitle('Year into decade'),
								$author$project$VegaLite$axTickCount(
								$author$project$VegaLite$niTickCount(11))
							]))
					]))),
		A2(
			$author$project$VegaLite$position,
			$author$project$VegaLite$Y,
			_List_fromArray(
				[
					$author$project$VegaLite$pName('CO2'),
					$author$project$VegaLite$pTitle('CO₂ concentration in ppm'),
					$author$project$VegaLite$pQuant,
					$author$project$VegaLite$pScale(
					_List_fromArray(
						[
							$author$project$VegaLite$scZero(false)
						]))
				])));
	var encLine = A2(
		$elm$core$Basics$composeL,
		$author$project$VegaLite$encoding,
		$author$project$VegaLite$color(
			_List_fromArray(
				[
					$author$project$VegaLite$mName('decade'),
					$author$project$VegaLite$mOrdinal,
					$author$project$VegaLite$mScale(
					_List_fromArray(
						[
							A2($author$project$VegaLite$scScheme, 'magma', _List_Nil)
						])),
					$author$project$VegaLite$mLegend(_List_Nil)
				])));
	var specLine = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				encLine(_List_Nil),
				$author$project$VegaLite$line(_List_Nil)
			]));
	var desc = $author$project$VegaLite$description('Carbon dioxide in the atmosphere.');
	var data = A2(
		$author$project$VegaLite$dataFromUrl,
		$author$project$GalleryLabel$path + 'co2-concentration.csv',
		_List_fromArray(
			[
				$author$project$VegaLite$parse(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'Date',
						$author$project$VegaLite$foUtc('%Y-%m-%d'))
					]))
			]));
	var cfg = A2(
		$elm$core$Basics$composeL,
		$author$project$VegaLite$configure,
		$author$project$VegaLite$configuration(
			$author$project$VegaLite$coText(
				_List_fromArray(
					[
						$author$project$VegaLite$maAlign($author$project$VegaLite$haLeft),
						$author$project$VegaLite$maDx(3),
						$author$project$VegaLite$maDy(1)
					]))));
	return $author$project$VegaLite$toVegaLite(
		_List_fromArray(
			[
				desc,
				cfg(_List_Nil),
				$author$project$VegaLite$width(800),
				$author$project$VegaLite$height(500),
				data,
				trans(_List_Nil),
				encPosition(_List_Nil),
				$author$project$VegaLite$layer(
				_List_fromArray(
					[specLine, specTextMin, specTextMax]))
			]));
}();
var $author$project$VegaLite$Y2 = {$: 'Y2'};
var $author$project$VegaLite$AxLabelAngle = function (a) {
	return {$: 'AxLabelAngle', a: a};
};
var $author$project$VegaLite$positiveAngle = function (a) {
	return (a < 0) ? (a + 360) : a;
};
var $author$project$VegaLite$axLabelAngle = function (n) {
	return $author$project$VegaLite$AxLabelAngle(
		$author$project$VegaLite$Num(
			$author$project$VegaLite$positiveAngle(n)));
};
var $author$project$VegaLite$dataFromRows = F2(
	function (fmts, rows) {
		return _Utils_eq(rows, _List_Nil) ? _Utils_Tuple2(
			$author$project$VegaLite$VLData,
			$elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'values',
						$author$project$VegaLite$toList(
							_List_fromArray(
								[
									$elm$json$Json$Encode$object(_List_Nil)
								])))
					]))) : (_Utils_eq(fmts, _List_Nil) ? _Utils_Tuple2(
			$author$project$VegaLite$VLData,
			$elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'values',
						$author$project$VegaLite$toList(rows))
					]))) : _Utils_Tuple2(
			$author$project$VegaLite$VLData,
			$elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'values',
						$author$project$VegaLite$toList(rows)),
						_Utils_Tuple2(
						'format',
						$elm$json$Json$Encode$object(
							A2($elm$core$List$concatMap, $author$project$VegaLite$formatProperties, fmts)))
					]))));
	});
var $author$project$VegaLite$dataRow = function (r) {
	return $elm$core$List$cons(
		$elm$json$Json$Encode$object(
			A2(
				$elm$core$List$map,
				function (_v0) {
					var colName = _v0.a;
					var val = _v0.b;
					return _Utils_Tuple2(
						colName,
						$author$project$VegaLite$dataValueSpec(val));
				},
				r)));
};
var $author$project$VegaLite$Number = function (a) {
	return {$: 'Number', a: a};
};
var $author$project$VegaLite$num = $author$project$VegaLite$Number;
var $author$project$VegaLite$PWidth = {$: 'PWidth'};
var $author$project$VegaLite$pWidth = $author$project$VegaLite$PWidth;
var $author$project$VegaLite$tOrdinal = $author$project$VegaLite$TmType($author$project$VegaLite$Ordinal);
var $author$project$GalleryLabel$label5 = function () {
	var trans = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			$author$project$VegaLite$transform,
			$author$project$VegaLite$filter(
				$author$project$VegaLite$fiExpr('datum.Value >= 300'))),
		A2($author$project$VegaLite$calculateAs, '300', 'baseline'));
	var thresholdData = A2(
		$elm$core$Basics$composeL,
		$author$project$VegaLite$dataFromRows(_List_Nil),
		$author$project$VegaLite$dataRow(
			_List_fromArray(
				[
					_Utils_Tuple2(
					'ThresholdValue',
					$author$project$VegaLite$num(300)),
					_Utils_Tuple2(
					'Threshold',
					$author$project$VegaLite$str('hazardous'))
				])));
	var encUpperBar = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			A2(
				$elm$core$Basics$composeL,
				A2(
					$elm$core$Basics$composeL,
					$author$project$VegaLite$encoding,
					A2(
						$author$project$VegaLite$position,
						$author$project$VegaLite$X,
						_List_fromArray(
							[
								$author$project$VegaLite$pName('Day'),
								$author$project$VegaLite$pOrdinal,
								$author$project$VegaLite$pAxis(
								_List_fromArray(
									[
										$author$project$VegaLite$axLabelAngle(0)
									]))
							]))),
				A2(
					$author$project$VegaLite$position,
					$author$project$VegaLite$Y,
					_List_fromArray(
						[
							$author$project$VegaLite$pName('baseline'),
							$author$project$VegaLite$pQuant
						]))),
			A2(
				$author$project$VegaLite$position,
				$author$project$VegaLite$Y2,
				_List_fromArray(
					[
						$author$project$VegaLite$pName('Value')
					]))),
		$author$project$VegaLite$color(
			_List_fromArray(
				[
					$author$project$VegaLite$mStr('#e45755')
				])));
	var specUpperBar = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				trans(_List_Nil),
				$author$project$VegaLite$bar(_List_Nil),
				encUpperBar(_List_Nil)
			]));
	var encText = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			A2(
				$elm$core$Basics$composeL,
				$author$project$VegaLite$encoding,
				A2(
					$author$project$VegaLite$position,
					$author$project$VegaLite$X,
					_List_fromArray(
						[$author$project$VegaLite$pWidth]))),
			A2(
				$author$project$VegaLite$position,
				$author$project$VegaLite$Y,
				_List_fromArray(
					[
						$author$project$VegaLite$pName('ThresholdValue'),
						$author$project$VegaLite$pQuant,
						$author$project$VegaLite$pTitle('PM2.5 Value')
					]))),
		$author$project$VegaLite$text(
			_List_fromArray(
				[
					$author$project$VegaLite$tName('Threshold'),
					$author$project$VegaLite$tOrdinal
				])));
	var specText = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				$author$project$VegaLite$textMark(
				_List_fromArray(
					[
						$author$project$VegaLite$maAlign($author$project$VegaLite$haRight),
						$author$project$VegaLite$maDx(-2),
						$author$project$VegaLite$maDy(-4)
					])),
				encText(_List_Nil)
			]));
	var encRule = A2(
		$elm$core$Basics$composeL,
		$author$project$VegaLite$encoding,
		A2(
			$author$project$VegaLite$position,
			$author$project$VegaLite$Y,
			_List_fromArray(
				[
					$author$project$VegaLite$pName('ThresholdValue'),
					$author$project$VegaLite$pQuant
				])));
	var specRule = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				$author$project$VegaLite$rule(_List_Nil),
				encRule(_List_Nil)
			]));
	var layer1 = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				thresholdData(_List_Nil),
				$author$project$VegaLite$layer(
				_List_fromArray(
					[specRule, specText]))
			]));
	var encBar = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			$author$project$VegaLite$encoding,
			A2(
				$author$project$VegaLite$position,
				$author$project$VegaLite$X,
				_List_fromArray(
					[
						$author$project$VegaLite$pName('Day'),
						$author$project$VegaLite$pOrdinal,
						$author$project$VegaLite$pAxis(
						_List_fromArray(
							[
								$author$project$VegaLite$axLabelAngle(0)
							]))
					]))),
		A2(
			$author$project$VegaLite$position,
			$author$project$VegaLite$Y,
			_List_fromArray(
				[
					$author$project$VegaLite$pName('Value'),
					$author$project$VegaLite$pQuant
				])));
	var specBar = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				$author$project$VegaLite$bar(_List_Nil),
				encBar(_List_Nil)
			]));
	var desc = $author$project$VegaLite$description('Bar chart that highlights values beyond a threshold. The PM2.5 value of Beijing observed 15 days, highlighting the days when PM2.5 level is hazardous to human health. Data source https://chartaccent.github.io/chartaccent.html');
	var data = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			$author$project$VegaLite$dataFromColumns(_List_Nil),
			A2(
				$author$project$VegaLite$dataColumn,
				'Day',
				$author$project$VegaLite$nums(
					A2(
						$elm$core$List$map,
						$elm$core$Basics$toFloat,
						A2($elm$core$List$range, 1, 15))))),
		A2(
			$author$project$VegaLite$dataColumn,
			'Value',
			$author$project$VegaLite$nums(
				_List_fromArray(
					[54.8, 112.1, 63.6, 37.6, 79.7, 137.9, 120.1, 103.3, 394.8, 199.5, 72.3, 51.1, 112.0, 174.5, 130.5]))));
	var layer0 = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				data(_List_Nil),
				$author$project$VegaLite$layer(
				_List_fromArray(
					[specBar, specUpperBar]))
			]));
	return $author$project$VegaLite$toVegaLite(
		_List_fromArray(
			[
				desc,
				$author$project$VegaLite$layer(
				_List_fromArray(
					[layer0, layer1]))
			]));
}();
var $author$project$VegaLite$MNumber = function (a) {
	return {$: 'MNumber', a: a};
};
var $author$project$VegaLite$mNum = $author$project$VegaLite$MNumber;
var $author$project$VegaLite$Month = {$: 'Month'};
var $author$project$VegaLite$month = $author$project$VegaLite$Month;
var $author$project$VegaLite$Mean = {$: 'Mean'};
var $author$project$VegaLite$opMean = $author$project$VegaLite$Mean;
var $author$project$VegaLite$PAggregate = function (a) {
	return {$: 'PAggregate', a: a};
};
var $author$project$VegaLite$pAggregate = $author$project$VegaLite$PAggregate;
var $author$project$VegaLite$PTimeUnit = function (a) {
	return {$: 'PTimeUnit', a: a};
};
var $author$project$VegaLite$pTimeUnit = $author$project$VegaLite$PTimeUnit;
var $author$project$VegaLite$size = function (markProps) {
	return $elm$core$List$cons(
		_Utils_Tuple2(
			'size',
			$elm$json$Json$Encode$object(
				A2($elm$core$List$concatMap, $author$project$VegaLite$markChannelProperties, markProps))));
};
var $author$project$GalleryLabel$label6 = function () {
	var encLine = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			A2(
				$elm$core$Basics$composeL,
				$author$project$VegaLite$encoding,
				A2(
					$author$project$VegaLite$position,
					$author$project$VegaLite$Y,
					_List_fromArray(
						[
							$author$project$VegaLite$pName('precipitation'),
							$author$project$VegaLite$pAggregate($author$project$VegaLite$opMean)
						]))),
			$author$project$VegaLite$color(
				_List_fromArray(
					[
						$author$project$VegaLite$mStr('red')
					]))),
		$author$project$VegaLite$size(
			_List_fromArray(
				[
					$author$project$VegaLite$mNum(3)
				])));
	var specLine = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				$author$project$VegaLite$rule(_List_Nil),
				encLine(_List_Nil)
			]));
	var encBar = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			$author$project$VegaLite$encoding,
			A2(
				$author$project$VegaLite$position,
				$author$project$VegaLite$X,
				_List_fromArray(
					[
						$author$project$VegaLite$pName('date'),
						$author$project$VegaLite$pOrdinal,
						$author$project$VegaLite$pTimeUnit($author$project$VegaLite$month)
					]))),
		A2(
			$author$project$VegaLite$position,
			$author$project$VegaLite$Y,
			_List_fromArray(
				[
					$author$project$VegaLite$pName('precipitation'),
					$author$project$VegaLite$pAggregate($author$project$VegaLite$opMean)
				])));
	var specBar = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				$author$project$VegaLite$bar(_List_Nil),
				encBar(_List_Nil)
			]));
	var desc = $author$project$VegaLite$description('Monthly precipitation with mean value overlay');
	var data = A2($author$project$VegaLite$dataFromUrl, $author$project$GalleryLabel$path + 'seattle-weather.csv', _List_Nil);
	return $author$project$VegaLite$toVegaLite(
		_List_fromArray(
			[
				desc,
				data,
				$author$project$VegaLite$layer(
				_List_fromArray(
					[specBar, specLine]))
			]));
}();
var $author$project$VegaLite$PBin = function (a) {
	return {$: 'PBin', a: a};
};
var $author$project$VegaLite$pBin = $author$project$VegaLite$PBin;
var $author$project$GalleryLabel$label7 = function () {
	var encMean = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			A2(
				$elm$core$Basics$composeL,
				$author$project$VegaLite$encoding,
				A2(
					$author$project$VegaLite$position,
					$author$project$VegaLite$X,
					_List_fromArray(
						[
							$author$project$VegaLite$pName('IMDB Rating'),
							$author$project$VegaLite$pAggregate($author$project$VegaLite$opMean)
						]))),
			$author$project$VegaLite$color(
				_List_fromArray(
					[
						$author$project$VegaLite$mStr('red')
					]))),
		$author$project$VegaLite$size(
			_List_fromArray(
				[
					$author$project$VegaLite$mNum(5)
				])));
	var specMean = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				$author$project$VegaLite$rule(_List_Nil),
				encMean(_List_Nil)
			]));
	var encBars = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			$author$project$VegaLite$encoding,
			A2(
				$author$project$VegaLite$position,
				$author$project$VegaLite$X,
				_List_fromArray(
					[
						$author$project$VegaLite$pName('IMDB Rating'),
						$author$project$VegaLite$pBin(_List_Nil),
						$author$project$VegaLite$pAxis(_List_Nil)
					]))),
		A2(
			$author$project$VegaLite$position,
			$author$project$VegaLite$Y,
			_List_fromArray(
				[
					$author$project$VegaLite$pAggregate($author$project$VegaLite$opCount)
				])));
	var specBars = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				$author$project$VegaLite$bar(_List_Nil),
				encBars(_List_Nil)
			]));
	var desc = $author$project$VegaLite$description('Histogram with global mean overlay');
	var data = A2($author$project$VegaLite$dataFromUrl, $author$project$GalleryLabel$path + 'movies.json', _List_Nil);
	return $author$project$VegaLite$toVegaLite(
		_List_fromArray(
			[
				desc,
				data,
				$author$project$VegaLite$layer(
				_List_fromArray(
					[specBars, specMean]))
			]));
}();
var $author$project$VegaLite$FoDate = function (a) {
	return {$: 'FoDate', a: a};
};
var $author$project$VegaLite$foDate = $author$project$VegaLite$FoDate;
var $author$project$VegaLite$Year = {$: 'Year'};
var $author$project$VegaLite$year = $author$project$VegaLite$Year;
var $author$project$GalleryLabel$label8 = function () {
	var highlights = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			A2(
				$elm$core$Basics$composeL,
				$author$project$VegaLite$dataFromColumns(
					_List_fromArray(
						[
							$author$project$VegaLite$parse(
							_List_fromArray(
								[
									_Utils_Tuple2(
									'start',
									$author$project$VegaLite$foDate('%Y')),
									_Utils_Tuple2(
									'end',
									$author$project$VegaLite$foDate('%Y'))
								]))
						])),
				A2(
					$author$project$VegaLite$dataColumn,
					'start',
					$author$project$VegaLite$strs(
						_List_fromArray(
							['1933', '1948'])))),
			A2(
				$author$project$VegaLite$dataColumn,
				'end',
				$author$project$VegaLite$strs(
					_List_fromArray(
						['1945', '1989'])))),
		A2(
			$author$project$VegaLite$dataColumn,
			'event',
			$author$project$VegaLite$strs(
				_List_fromArray(
					['Nazi Rule', 'GDR (East Germany)']))));
	var encRects = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			A2(
				$elm$core$Basics$composeL,
				$author$project$VegaLite$encoding,
				A2(
					$author$project$VegaLite$position,
					$author$project$VegaLite$X,
					_List_fromArray(
						[
							$author$project$VegaLite$pName('start'),
							$author$project$VegaLite$pTimeUnit($author$project$VegaLite$year),
							$author$project$VegaLite$pAxis(_List_Nil)
						]))),
			A2(
				$author$project$VegaLite$position,
				$author$project$VegaLite$X2,
				_List_fromArray(
					[
						$author$project$VegaLite$pName('end')
					]))),
		$author$project$VegaLite$color(
			_List_fromArray(
				[
					$author$project$VegaLite$mName('event')
				])));
	var specRects = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				highlights(_List_Nil),
				$author$project$VegaLite$rect(_List_Nil),
				encRects(_List_Nil)
			]));
	var encPopulation = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			A2(
				$elm$core$Basics$composeL,
				$author$project$VegaLite$encoding,
				A2(
					$author$project$VegaLite$position,
					$author$project$VegaLite$X,
					_List_fromArray(
						[
							$author$project$VegaLite$pName('year'),
							$author$project$VegaLite$pTimeUnit($author$project$VegaLite$year),
							$author$project$VegaLite$pTitle('')
						]))),
			A2(
				$author$project$VegaLite$position,
				$author$project$VegaLite$Y,
				_List_fromArray(
					[
						$author$project$VegaLite$pName('population'),
						$author$project$VegaLite$pQuant
					]))),
		$author$project$VegaLite$color(
			_List_fromArray(
				[
					$author$project$VegaLite$mStr('#333')
				])));
	var specLine = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				$author$project$VegaLite$line(_List_Nil),
				encPopulation(_List_Nil)
			]));
	var specPoints = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				$author$project$VegaLite$point(_List_Nil),
				encPopulation(_List_Nil)
			]));
	var desc = $author$project$VegaLite$description('The population of the German city of Falkensee over time with annotated time periods highlighted');
	var data = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			$author$project$VegaLite$dataFromColumns(
				_List_fromArray(
					[
						$author$project$VegaLite$parse(
						_List_fromArray(
							[
								_Utils_Tuple2(
								'year',
								$author$project$VegaLite$foDate('%Y'))
							]))
					])),
			A2(
				$author$project$VegaLite$dataColumn,
				'year',
				$author$project$VegaLite$strs(
					_List_fromArray(
						['1875', '1890', '1910', '1925', '1933', '1939', '1946', '1950', '1964', '1971', '1981', '1985', '1989', '1990', '1991', '1992', '1993', '1994', '1995', '1996', '1997', '1998', '1999', '2000', '2001', '2002', '2003', '2004', '2005', '2006', '2007', '2008', '2009', '2010', '2011', '2012', '2013', '2014'])))),
		A2(
			$author$project$VegaLite$dataColumn,
			'population',
			$author$project$VegaLite$nums(
				_List_fromArray(
					[1309, 1558, 4512, 8180, 15915, 24824, 28275, 29189, 29881, 26007, 24029, 23340, 22307, 22087, 22139, 22105, 22242, 22801, 24273, 25640, 27393, 29505, 32124, 33791, 35297, 36179, 36829, 37493, 38376, 39008, 39366, 39821, 40179, 40511, 40465, 40905, 41258, 41777]))));
	return $author$project$VegaLite$toVegaLite(
		_List_fromArray(
			[
				desc,
				$author$project$VegaLite$width(500),
				data(_List_Nil),
				$author$project$VegaLite$layer(
				_List_fromArray(
					[specRects, specLine, specPoints]))
			]));
}();
var $author$project$VegaLite$AxOffset = function (a) {
	return {$: 'AxOffset', a: a};
};
var $author$project$VegaLite$axOffset = function (n) {
	return $author$project$VegaLite$AxOffset(
		$author$project$VegaLite$Num(n));
};
var $author$project$VegaLite$AxValues = function (a) {
	return {$: 'AxValues', a: a};
};
var $author$project$VegaLite$axValues = $author$project$VegaLite$AxValues;
var $author$project$VegaLite$dataFromSource = F2(
	function (sourceName, fmts) {
		return _Utils_eq(fmts, _List_Nil) ? _Utils_Tuple2(
			$author$project$VegaLite$VLData,
			$elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'name',
						$elm$json$Json$Encode$string(sourceName))
					]))) : _Utils_Tuple2(
			$author$project$VegaLite$VLData,
			$elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'name',
						$elm$json$Json$Encode$string(sourceName)),
						_Utils_Tuple2(
						'format',
						$elm$json$Json$Encode$object(
							A2($elm$core$List$concatMap, $author$project$VegaLite$formatProperties, fmts)))
					])));
	});
var $author$project$VegaLite$VLDatasets = {$: 'VLDatasets'};
var $elm$json$Json$Decode$decodeString = _Json_runOnString;
var $elm$json$Json$Decode$keyValuePairs = _Json_decodeKeyValuePairs;
var $elm$json$Json$Decode$value = _Json_decodeValue;
var $author$project$VegaLite$datasets = function (namedData) {
	var extract = function (data) {
		var _v2 = A2(
			$elm$json$Json$Decode$decodeString,
			$elm$json$Json$Decode$keyValuePairs($elm$json$Json$Decode$value),
			A2($elm$json$Json$Encode$encode, 0, data));
		if (((_v2.$ === 'Ok') && _v2.a.b) && (!_v2.a.b.b)) {
			var _v3 = _v2.a;
			var _v4 = _v3.a;
			var value = _v4.b;
			return value;
		} else {
			return data;
		}
	};
	var specs = A2(
		$elm$core$List$map,
		function (_v0) {
			var s = _v0.a;
			var data = _v0.b;
			return _Utils_Tuple2(
				s,
				function (_v1) {
					var spec = _v1.b;
					return extract(spec);
				}(data));
		},
		namedData);
	return _Utils_Tuple2(
		$author$project$VegaLite$VLDatasets,
		$elm$json$Json$Encode$object(specs));
};
var $author$project$VegaLite$Bold = {$: 'Bold'};
var $author$project$VegaLite$fwBold = $author$project$VegaLite$Bold;
var $author$project$VegaLite$LOffset = function (a) {
	return {$: 'LOffset', a: a};
};
var $author$project$VegaLite$leOffset = function (n) {
	return $author$project$VegaLite$LOffset(
		$author$project$VegaLite$Num(n));
};
var $author$project$VegaLite$LTitle = function (a) {
	return {$: 'LTitle', a: a};
};
var $author$project$VegaLite$leTitle = function (s) {
	return $author$project$VegaLite$LTitle(
		$author$project$VegaLite$Str(s));
};
var $author$project$VegaLite$MColor = function (a) {
	return {$: 'MColor', a: a};
};
var $author$project$VegaLite$maColor = function (s) {
	return $author$project$VegaLite$MColor(
		$author$project$VegaLite$Str(s));
};
var $author$project$VegaLite$MX = function (a) {
	return {$: 'MX', a: a};
};
var $author$project$VegaLite$maX = function (n) {
	return $author$project$VegaLite$MX(
		$author$project$VegaLite$Num(n));
};
var $author$project$VegaLite$Tick = {$: 'Tick'};
var $author$project$VegaLite$tick = $author$project$VegaLite$mark($author$project$VegaLite$Tick);
var $author$project$GalleryLabel$label9 = function () {
	var values = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			A2(
				$elm$core$Basics$composeL,
				$author$project$VegaLite$dataFromColumns(_List_Nil),
				A2(
					$author$project$VegaLite$dataColumn,
					'value',
					$author$project$VegaLite$strs(
						_List_fromArray(
							['P1', '2', '2', '3', '4', '2', '5', '5', '1', '1', 'P2', '2', '3', '4', '5', '5', '5', '5', '1', '1', 'P3', '2', '2', '2', '1', '2', '1', '5', '1', '0', 'P4', '3', '3', '2', '2', '4', '1', '5', '1', '0', 'P5', '2', '2', '4', '4', '4', '5', '5', '0', '1', 'P6', '1', '3', '3', '4', '4', '4', '4', '0', '1', 'P7', '2', '3', '4', '5', '3', '2', '4', '0', '0', 'P8', '3', '1', '2', '4', '2', '5', '5', '0', '0', 'P9', '2', '3', '2', '4', '1', '4', '4', '1', '1', 'P10', '2', '2', '1', '1', '1', '1', '5', '1', '1', 'P11', '2', '2', '1', '1', '1', '1', '4', '1', '0', 'P12', '1', '3', '2', '3', '1', '3', '3', '0', '1', 'P13', '2', '2', '1', '1', '1', '1', '5', '0', '0', 'P14', '3', '3', '2', '2', '1', '1', '1', '1', '1', 'P15', '4', '5', '1', '1', '1', '1', '5', '1', '0', 'P16', '1', '3', '2', '2', '1', '4', '5', '0', '1', 'P17', '3', '2', '2', '2', '1', '3', '2', '0', '0'])))),
			A2(
				$author$project$VegaLite$dataColumn,
				'name',
				$author$project$VegaLite$strs(
					_List_fromArray(
						['Participant ID', 'Identify Errors:', 'Fix Errors:', 'Easier to Fix:', 'Faster to Fix:', 'Easier on Phone:', 'Easier on Tablet:', 'Device Preference:', 'Tablet_First', 'Toolbar_First', 'Participant ID', 'Identify Errors:', 'Fix Errors:', 'Easier to Fix:', 'Faster to Fix:', 'Easier on Phone:', 'Easier on Tablet:', 'Device Preference:', 'Tablet_First', 'Toolbar_First', 'Participant ID', 'Identify Errors:', 'Fix Errors:', 'Easier to Fix:', 'Faster to Fix:', 'Easier on Phone:', 'Easier on Tablet:', 'Device Preference:', 'Tablet_First', 'Toolbar_First', 'Participant ID', 'Identify Errors:', 'Fix Errors:', 'Easier to Fix:', 'Faster to Fix:', 'Easier on Phone:', 'Easier on Tablet:', 'Device Preference:', 'Tablet_First', 'Toolbar_First', 'Participant ID', 'Identify Errors:', 'Fix Errors:', 'Easier to Fix:', 'Faster to Fix:', 'Easier on Phone:', 'Easier on Tablet:', 'Device Preference:', 'Tablet_First', 'Toolbar_First', 'Participant ID', 'Identify Errors:', 'Fix Errors:', 'Easier to Fix:', 'Faster to Fix:', 'Easier on Phone:', 'Easier on Tablet:', 'Device Preference:', 'Tablet_First', 'Toolbar_First', 'Participant ID', 'Identify Errors:', 'Fix Errors:', 'Easier to Fix:', 'Faster to Fix:', 'Easier on Phone:', 'Easier on Tablet:', 'Device Preference:', 'Tablet_First', 'Toolbar_First', 'Participant ID', 'Identify Errors:', 'Fix Errors:', 'Easier to Fix:', 'Faster to Fix:', 'Easier on Phone:', 'Easier on Tablet:', 'Device Preference:', 'Tablet_First', 'Toolbar_First', 'Participant ID', 'Identify Errors:', 'Fix Errors:', 'Easier to Fix:', 'Faster to Fix:', 'Easier on Phone:', 'Easier on Tablet:', 'Device Preference:', 'Tablet_First', 'Toolbar_First', 'Participant ID', 'Identify Errors:', 'Fix Errors:', 'Easier to Fix:', 'Faster to Fix:', 'Easier on Phone:', 'Easier on Tablet:', 'Device Preference:', 'Tablet_First', 'Toolbar_First', 'Participant ID', 'Identify Errors:', 'Fix Errors:', 'Easier to Fix:', 'Faster to Fix:', 'Easier on Phone:', 'Easier on Tablet:', 'Device Preference:', 'Tablet_First', 'Toolbar_First', 'Participant ID', 'Identify Errors:', 'Fix Errors:', 'Easier to Fix:', 'Faster to Fix:', 'Easier on Phone:', 'Easier on Tablet:', 'Device Preference:', 'Tablet_First', 'Toolbar_First', 'Participant ID', 'Identify Errors:', 'Fix Errors:', 'Easier to Fix:', 'Faster to Fix:', 'Easier on Phone:', 'Easier on Tablet:', 'Device Preference:', 'Tablet_First', 'Toolbar_First', 'Participant ID', 'Identify Errors:', 'Fix Errors:', 'Easier to Fix:', 'Faster to Fix:', 'Easier on Phone:', 'Easier on Tablet:', 'Device Preference:', 'Tablet_First', 'Toolbar_First', 'Participant ID', 'Identify Errors:', 'Fix Errors:', 'Easier to Fix:', 'Faster to Fix:', 'Easier on Phone:', 'Easier on Tablet:', 'Device Preference:', 'Tablet_First', 'Toolbar_First', 'Participant ID', 'Identify Errors:', 'Fix Errors:', 'Easier to Fix:', 'Faster to Fix:', 'Easier on Phone:', 'Easier on Tablet:', 'Device Preference:', 'Tablet_First', 'Toolbar_First', 'Participant ID', 'Identify Errors:', 'Fix Errors:', 'Easier to Fix:', 'Faster to Fix:', 'Easier on Phone:', 'Easier on Tablet:', 'Device Preference:', 'Tablet_First', 'Toolbar_First'])))),
		A2(
			$author$project$VegaLite$dataColumn,
			'id',
			$author$project$VegaLite$strs(
				_List_fromArray(
					['P1', 'P1', 'P1', 'P1', 'P1', 'P1', 'P1', 'P1', 'P1', 'P1', 'P2', 'P2', 'P2', 'P2', 'P2', 'P2', 'P2', 'P2', 'P2', 'P2', 'P3', 'P3', 'P3', 'P3', 'P3', 'P3', 'P3', 'P3', 'P3', 'P3', 'P4', 'P4', 'P4', 'P4', 'P4', 'P4', 'P4', 'P4', 'P4', 'P4', 'P5', 'P5', 'P5', 'P5', 'P5', 'P5', 'P5', 'P5', 'P5', 'P5', 'P6', 'P6', 'P6', 'P6', 'P6', 'P6', 'P6', 'P6', 'P6', 'P6', 'P7', 'P7', 'P7', 'P7', 'P7', 'P7', 'P7', 'P7', 'P7', 'P7', 'P8', 'P8', 'P8', 'P8', 'P8', 'P8', 'P8', 'P8', 'P8', 'P8', 'P9', 'P9', 'P9', 'P9', 'P9', 'P9', 'P9', 'P9', 'P9', 'P9', 'P10', 'P10', 'P10', 'P10', 'P10', 'P10', 'P10', 'P10', 'P10', 'P10', 'P11', 'P11', 'P11', 'P11', 'P11', 'P11', 'P11', 'P11', 'P11', 'P11', 'P12', 'P12', 'P12', 'P12', 'P12', 'P12', 'P12', 'P12', 'P12', 'P12', 'P13', 'P13', 'P13', 'P13', 'P13', 'P13', 'P13', 'P13', 'P13', 'P13', 'P14', 'P14', 'P14', 'P14', 'P14', 'P14', 'P14', 'P14', 'P14', 'P14', 'P15', 'P15', 'P15', 'P15', 'P15', 'P15', 'P15', 'P15', 'P15', 'P15', 'P16', 'P16', 'P16', 'P16', 'P16', 'P16', 'P16', 'P16', 'P16', 'P16', 'P17', 'P17', 'P17', 'P17', 'P17', 'P17', 'P17', 'P17', 'P17', 'P17']))));
	var trans = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			A2(
				$elm$core$Basics$composeL,
				$author$project$VegaLite$transform,
				$author$project$VegaLite$filter(
					$author$project$VegaLite$fiExpr('datum.name != \'Toolbar_First\''))),
			$author$project$VegaLite$filter(
				$author$project$VegaLite$fiExpr('datum.name != \'Tablet_First\''))),
		$author$project$VegaLite$filter(
			$author$project$VegaLite$fiExpr('datum.name != \'Participant ID\'')));
	var medians = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			A2(
				$elm$core$Basics$composeL,
				A2(
					$elm$core$Basics$composeL,
					$author$project$VegaLite$dataFromColumns(_List_Nil),
					A2(
						$author$project$VegaLite$dataColumn,
						'name',
						$author$project$VegaLite$strs(
							_List_fromArray(
								['Identify Errors:', 'Fix Errors:', 'Easier to Fix:', 'Faster to Fix:', 'Easier on Phone:', 'Easier on Tablet:', 'Device Preference:'])))),
				A2(
					$author$project$VegaLite$dataColumn,
					'median',
					$author$project$VegaLite$nums(
						_List_fromArray(
							[1.999976, 2, 1.999969, 2.500045, 1.500022, 2.99998, 4.500007])))),
			A2(
				$author$project$VegaLite$dataColumn,
				'lo',
				$author$project$VegaLite$strs(
					_List_fromArray(
						['Easy', 'Easy', 'Toolbar', 'Toolbar', 'Toolbar', 'Toolbar', 'Phone'])))),
		A2(
			$author$project$VegaLite$dataColumn,
			'hi',
			$author$project$VegaLite$strs(
				_List_fromArray(
					['Hard', 'Hard', 'Gesture', 'Gesture', 'Gesture', 'Gesture', 'Tablet']))));
	var encTick1 = A2(
		$elm$core$Basics$composeL,
		$author$project$VegaLite$encoding,
		A2(
			$author$project$VegaLite$position,
			$author$project$VegaLite$X,
			_List_fromArray(
				[
					$author$project$VegaLite$pName('median'),
					$author$project$VegaLite$pQuant,
					$author$project$VegaLite$pScale(
					_List_fromArray(
						[
							$author$project$VegaLite$scDomain(
							$author$project$VegaLite$doNums(
								_List_fromArray(
									[0, 6])))
						])),
					$author$project$VegaLite$pTitle('')
				])));
	var specTick1 = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				encTick1(_List_Nil),
				$author$project$VegaLite$tick(
				_List_fromArray(
					[
						$author$project$VegaLite$maColor('black')
					]))
			]));
	var encTextLo = A2(
		$elm$core$Basics$composeL,
		$author$project$VegaLite$encoding,
		$author$project$VegaLite$text(
			_List_fromArray(
				[
					$author$project$VegaLite$tName('lo')
				])));
	var specTextLo = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				encTextLo(_List_Nil),
				$author$project$VegaLite$textMark(
				_List_fromArray(
					[
						$author$project$VegaLite$maX(-5),
						$author$project$VegaLite$maAlign($author$project$VegaLite$haRight)
					]))
			]));
	var encTextHi = A2(
		$elm$core$Basics$composeL,
		$author$project$VegaLite$encoding,
		$author$project$VegaLite$text(
			_List_fromArray(
				[
					$author$project$VegaLite$tName('hi')
				])));
	var specTextHi = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				encTextHi(_List_Nil),
				$author$project$VegaLite$textMark(
				_List_fromArray(
					[
						$author$project$VegaLite$maX(255),
						$author$project$VegaLite$maAlign($author$project$VegaLite$haLeft)
					]))
			]));
	var encCircle = A2(
		$elm$core$Basics$composeL,
		A2(
			$elm$core$Basics$composeL,
			$author$project$VegaLite$encoding,
			A2(
				$author$project$VegaLite$position,
				$author$project$VegaLite$X,
				_List_fromArray(
					[
						$author$project$VegaLite$pName('value'),
						$author$project$VegaLite$pQuant,
						$author$project$VegaLite$pScale(
						_List_fromArray(
							[
								$author$project$VegaLite$scDomain(
								$author$project$VegaLite$doNums(
									_List_fromArray(
										[0, 6])))
							])),
						$author$project$VegaLite$pAxis(
						_List_fromArray(
							[
								$author$project$VegaLite$axGrid(false),
								$author$project$VegaLite$axValues(
								$author$project$VegaLite$nums(
									_List_fromArray(
										[1, 2, 3, 4, 5])))
							]))
					]))),
		$author$project$VegaLite$size(
			_List_fromArray(
				[
					$author$project$VegaLite$mAggregate($author$project$VegaLite$opCount),
					$author$project$VegaLite$mLegend(
					_List_fromArray(
						[
							$author$project$VegaLite$leTitle('Number of Ratings'),
							$author$project$VegaLite$leOffset(75)
						]))
				])));
	var specCircle = $author$project$VegaLite$asSpec(
		_List_fromArray(
			[
				A2($author$project$VegaLite$dataFromSource, 'values', _List_Nil),
				trans(_List_Nil),
				encCircle(_List_Nil),
				$author$project$VegaLite$circle(
				_List_fromArray(
					[
						$author$project$VegaLite$maColor('#6eb4fd')
					]))
			]));
	var enc = A2(
		$elm$core$Basics$composeL,
		$author$project$VegaLite$encoding,
		A2(
			$author$project$VegaLite$position,
			$author$project$VegaLite$Y,
			_List_fromArray(
				[
					$author$project$VegaLite$pName('name'),
					$author$project$VegaLite$pSort(_List_Nil),
					$author$project$VegaLite$pAxis(
					_List_fromArray(
						[
							$author$project$VegaLite$axDomain(false),
							$author$project$VegaLite$axOffset(50),
							$author$project$VegaLite$axLabelFontWeight($author$project$VegaLite$fwBold),
							$author$project$VegaLite$axTicks(false),
							$author$project$VegaLite$axGrid(true),
							$author$project$VegaLite$axTitle('')
						]))
				])));
	var cfg = A2(
		$elm$core$Basics$composeL,
		$author$project$VegaLite$configure,
		$author$project$VegaLite$configuration(
			$author$project$VegaLite$coView(
				_List_fromArray(
					[
						$author$project$VegaLite$vicoStroke($elm$core$Maybe$Nothing)
					]))));
	return $author$project$VegaLite$toVegaLite(
		_List_fromArray(
			[
				cfg(_List_Nil),
				$author$project$VegaLite$datasets(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'medians',
						medians(_List_Nil)),
						_Utils_Tuple2(
						'values',
						values(_List_Nil))
					])),
				A2($author$project$VegaLite$dataFromSource, 'medians', _List_Nil),
				A2($author$project$VegaLite$title, 'Questionnaire Ratings', _List_Nil),
				$author$project$VegaLite$width(250),
				$author$project$VegaLite$height(175),
				enc(_List_Nil),
				$author$project$VegaLite$layer(
				_List_fromArray(
					[specCircle, specTick1, specTextLo, specTextHi]))
			]));
}();
var $author$project$GalleryLabel$mySpecs = $author$project$VegaLite$combineSpecs(
	_List_fromArray(
		[
			_Utils_Tuple2('label1', $author$project$GalleryLabel$label1),
			_Utils_Tuple2('label2', $author$project$GalleryLabel$label2),
			_Utils_Tuple2('label3', $author$project$GalleryLabel$label3),
			_Utils_Tuple2('label4', $author$project$GalleryLabel$label4),
			_Utils_Tuple2('label5', $author$project$GalleryLabel$label5),
			_Utils_Tuple2('label6', $author$project$GalleryLabel$label6),
			_Utils_Tuple2('label7', $author$project$GalleryLabel$label7),
			_Utils_Tuple2('label8', $author$project$GalleryLabel$label8),
			_Utils_Tuple2('label9', $author$project$GalleryLabel$label9),
			_Utils_Tuple2('label10', $author$project$GalleryLabel$label10)
		]));
var $elm$core$Platform$Cmd$batch = _Platform_batch;
var $elm$core$Platform$Cmd$none = $elm$core$Platform$Cmd$batch(_List_Nil);
var $elm$core$Platform$Sub$batch = _Platform_batch;
var $elm$core$Platform$Sub$none = $elm$core$Platform$Sub$batch(_List_Nil);
var $elm$json$Json$Decode$succeed = _Json_succeed;
var $elm$core$Platform$worker = _Platform_worker;
var $author$project$GalleryLabel$main = $elm$core$Platform$worker(
	{
		init: $elm$core$Basics$always(
			_Utils_Tuple2(
				$author$project$GalleryLabel$mySpecs,
				$author$project$GalleryLabel$elmToJS($author$project$GalleryLabel$mySpecs))),
		subscriptions: $elm$core$Basics$always($elm$core$Platform$Sub$none),
		update: F2(
			function (_v0, model) {
				return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
			})
	});
_Platform_export({'GalleryLabel':{'init':$author$project$GalleryLabel$main(
	$elm$json$Json$Decode$succeed(_Utils_Tuple0))(0)}});}(this));
+++
date = "2017-01-11T00:00:00-00:00"
description = "description"
draft = false
type = "notes"
title = "The power of JavaScript first-class functions"

+++

{{< load-runkit >}}

### Block scoping with functions:

Modern JavaScript has block scoping when using `let` and `const` binders:

{{< runkit scope-modern >}}
function hello(x) {
  console.log(`A: x = ${x}`); // ??
  {
    const x = 45;
    console.log(`B: x = ${x}`); // ??
  }
  {
    console.log(`C: x = ${x}`); // ??
  }
}
hello(42);
{{< /runkit >}}

This is not true for `var` binders, which are scoped to the nearest function scope (if one exists, otherwise, the global scope):

{{< runkit scope-var >}}
function hello(x) {
  console.log(`A: x = ${x}`); // ??
  {
    var x = 45;
    console.log(`B: x = ${x}`); // ??
  }
  {
    console.log(`C: x = ${x}`); // ??
  }
}

hello(42);
{{< /runkit >}}

We can, however, introduce block scoping to code that only uses `var`
declarations by using first-class functions to create a new function scope:

{{< runkit scope-modernize-var >}}
function hello(x) {
  console.log(`A: x = ${x}`); // ??
  (function () {
    var x = 45;
    console.log(`B: x = ${x}`); // ??
  })();
  (function () {
    console.log(`C: x = ${x}`); // ??
  })();
}

hello(42);
{{< /runkit >}}

Rather than use the verbose `function` declarations, we can also write anonymous functions using the fat arrow (`=>`), as such:

{{< runkit scope-modernize-var-pretty >}}
function hello(x) {
  console.log(`A: x = ${x}`); // ??
  (() => {
    var x = 45;
    console.log(`B: x = ${x}`); // ??
  })();
  (() => {
    console.log(`C: x = ${x}`); // ??
  })();
}

hello(42);
{{< /runkit >}}

Fat arrows or [arrow
functions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions)
can make our code much cleaner and using them will make the lambda calculus
lecture much easier too. Below is some code showing the use of fat arrows and
how more syntax goes away as our functions get simpler:

{{< runkit fat-arrows >}}
const f = (x) => { 
  console.log('hello!');
  return x;
};

f(34); // ??

// if your function is simple, and only has one expression, can write it as:
const g = (x) =>  x ;
// no more {}' and "return"!
console.log(g(33));

// In fact, if function only has 1 argument, you can even remove the ()'s:
const h = x =>  x+3;
console.log(h(33)); // ??

// We can also use it immediately, inline:
console.log(((x, y) => x + y) (4, 5)) ; // ??
{{< /runkit >}}


## Callbacks for performing concurrent, asynchronous filesystem reads:

Node.js ships with a code JavaScript library that can be used to read and write files.
Node.js exposes functions for reading (writing) files synchronously:

{{< runkit perf-sync >}}
const fs = require('fs');

prepFiles(); // ignore, this we're just calling this function to populate filesystem

const r1 = fs.readFileSync('./a.txt', 'utf8'); // blocks until read is done
processFile('a.txt', r1); //blocks until processing (write) is done
const r2 = fs.readFileSync('./b.txt', 'utf8'); // etc.
processFile('b.txt', r2);

// note that you can declare a function after the point it's used. Hoisting
// essentially moves it to the top.
function processFile(fname, str) {
  fs.writeFileSync(`/tmp/${fname}`, str);
  console.log(`DONE writing /tmp/${fname}`);
}

function prepFiles() {
	// our examples read these two files, let's make sure that they exist on the runkit machine
  fs.writeFileSync('./a.txt', 'alice!');
  fs.writeFileSync('./b.txt', 'bob!');
}
{{< /runkit >}}

Note that each of the reads and writes block, waiting for the files to be read and processed. But this need not be the case. We can leverage the fact that the underling runtime and OS have concurrency and we can read the files concurrently:
{{< runkit perf-async >}}
const fs = require('fs');

prepFiles(); // ignore, this we're just calling this function to populate filesystem

fs.readFile('./a.txt', 'utf8', cb1); // returns immediately, cb1 is queued on the event loop and called later when actual file read is done
fs.readFile('./b.txt', 'utf8', cb2); // returns immediately, " "

function processFile(fname, str) {
  fs.writeFileSync(`/tmp/${fname}`, str);
  console.log(`DONE writing /tmp/${fname}`);
}

function cb1(err, str) {
  processFile('a.txt', str);
}

function cb2(err, str) {
  processFile('b.txt', str);
}

function prepFiles() {
	// our examples read these two files, let's make sure that they exist on the runkit machine
  fs.writeFileSync('./a.txt', 'alice!');
  fs.writeFileSync('./b.txt', 'bob!');
}
{{< /runkit >}}

The above code tells the Node.js runtime to read the file `a,txt`, without
blocking, and call function `cb1` with the error condition and data once it
read the file (or failed). Note that JavaScript always runs code to completion for each _event loop_.
In the first event loop we tell the runtime to read files, and the runtime, in later event loops, will call our callback functions.

**Challenge:** further modify this code to eliminate the synchronous writes.

Since JavaScript has first-class functions, we can clean up the above code and move the repeated code into processFie (which now returns a function that is pased to `readFile`):
{{< runkit perf-async-2 >}}
const fs = require('fs');
prepFiles();

fs.readFile('./a.txt', 'utf8', processFile('a.txt'));
fs.readFile('./b.txt', 'utf8', processFile('b.txt'));


function processFile(fname) {
  return (err, str) => {
    fs.writeFileSync(`/tmp/${fname}`, str);
    console.log(`DONE writing /tmp/${fname}`);
  };
}

function prepFiles() {
	// our examples read these two files, let's make sure that they exist on the runkit machine
  fs.writeFileSync('./a.txt', 'alice!');
  fs.writeFileSync('./b.txt', 'bob!');
}
{{< /runkit >}}

Indeed, we can go a step further and remove other redudent code:

{{< runkit perf-async-3 >}}
const fs = require('fs');

prepFiles();

readAndProcessFile('a.txt');
readAndProcessFile('b.txt');

function readAndProcessFile(name) {
  return fs.readFile(`./${name}`, 'utf8', processFile(name));
}

function processFile(fname) {
  return (err, str) => {
    fs.writeFileSync(`/tmp/${fname}`, str);
    console.log(`DONE writing /tmp/${fname}`);
  };
}

function prepFiles() {
	// our examples read these two files, let's make sure that they exist on the runkit machine
  fs.writeFileSync('./a.txt', 'alice!');
  fs.writeFileSync('./b.txt', 'bob!');
}
{{< /runkit >}}

## High order functions and closures:

With first-class functions, we can write clean, declarative (functional) code.
We don't have to write code that tells the computer what to do, but rather have
the code more closely resemble what we mean (mathematically). For example, we
can process lists as such:

{{< runkit expressive >}}
const list = [1, 2, 3, 4];

console.log(filter(list, function (el) { 
  return el > 2;
})); // ??

console.log(map(list, el => { 
  return el + 42;
})); // ??


function filter(list, pred) {
  const dup = [];
  for (let i = 0; i < list.length; i++) {
    if (pred(list[i])) {
      dup.push(list[i]);
    }
  }
  return dup;
}

function map(list, f) {
  const dup = [];
  for (let i = list.length-1; i >= 0; i--) {
    dup.unshift(f(list[i]));
  }
  return dup;
}
{{< /runkit >}}

Since functions are first-class, we can even define function composition - a
high-order function that takes functions as arguments and returns their
composition. This is for example, useful if we want to apply several functions
over each element of a list:

{{< runkit hof >}}
const list = [1, 2, 3, 4];

const add42 = (el) => {
  return el + 42;
};

const mul1337 = (el) => {
  return el * 1337;
};

console.log(map(map(list, add42), mul1337));
console.log(map(list, compose(mul1337, add42)));

function compose(f, g) {
  return (x) => {
    return f(g(x));
  };
}

function map(list, f) {
  const dup = [];
  for (let i = list.length-1; i >= 0; i--) {
    dup.unshift(f(list[i]));
  }
  return dup;
}
{{< /runkit >}}

It's important to understand that JavaScript functions are **not** just function-pointers. They are closures. That is, a pair encoding the function code and the enclosing environment:

{{< runkit closure >}}
/* recall our definition:
const add42 = (el) => {
  return el + 42;
};
*/

function makeAddFunc(offset) {
  return (x) => {
    return offset + x; // note offset is captured here
  };
}

const add42 = makeAddFunc(42);
const sub42 = makeAddFunc(-42);

console.log(add42(1)); // ??
console.log(add42(42)); // ??

console.log(sub42(1)); // ??
console.log(sub42(42)); // ??


// Note the environment:

function f(x) {
  let y = x;
  return function (z) {
    y += z;
    return y;
  };
}

const h = f(5);
console.log(h(3)); // ??
{{< /runkit >}}

## Using functions to implement modules:

First-class functions are incredibly powerful. We can even use them to
implement modules. For example, below we define a simple module `myModule`, which like Node.js modules contains an `exports` object in scope that is, in turn, used to define the module interface.  This module is loaded by calling `requireMyModule`.

{{< runkit module >}}
// using our fake require:
{
  const mod = requireMyModule();

  console.log(mod.myVar); // ??
  mod.myFunc("what?"); // ??
  mod.myFunc("cse130 is fun!"); // ??
}

function myModule(exports) {
  const secret = "cse130 is fun!";
  exports.myVar = 42;
  exports.myFunc = function (x) {
    if (x === secret) {
      console.log('yes!');
    } else {
      console.log('guess again!');
    }
  };
}

function requireMyModule() {
  // create new object that will be populated by the module
  const exports = {};
  myModule(exports);
  return exports;
}
{{< /runkit >}}

Node modules are slightly more complicated, but not that much more! They
basically take the contents of a file, wrap it as if the module was a function
(with `"function (exports ) {"` et.c) and then `eval` it!

**[Continue with objects here](../intro-js-code-2)**.

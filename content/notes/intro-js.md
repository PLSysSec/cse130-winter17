+++
date = "2017-01-07T00:00:00-00:00"
description = "description"
draft = false
type = "notes"
title = "Intro and JavaScript"

+++

### Lecture slides and code

You can get the slides [here](../../slides/js-nutshell.pdf). The slides refer
to some JavaScript files, provided below. You can also play with this code in
your browser [here](../intro-js-code) and [here](../intro-js-code-2).

### Recommended reading

If you have not worked with JavaScript before, take some time to familiarize
yourself with the basics of the language, as most of the labs in this class
will be in JavaScript.

We recommend the [Mozilla Developer Network's JavaScript
Guide](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide), but
there are many other tutorials on the Internet.

Dave Herman's [Effective JavaScript](http://effectivejs.com/) is very good
reference that covers a lot of the JavaScript intricacies.  You will not this
for the class, but if you end up writing JavaScript code in the outside world,
this book is must-read.

### Additional resources/reading for the curious

- [Block
  bindings](https://leanpub.com/understandinges6/read#leanpub-auto-block-bindings)
  and the difference between `var`, `let`, and `const`.
- Why a language like JavaScript took over the world? Not that uncommon, see
  [The Rise of "Worse is
  Better"](https://www.jwz.org/doc/worse-is-better.html).
- [Closures](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Closures)
  explained; see, especially the creating closures in a loop section.
- [Private properties in (modern) JavaScript](https://curiosity-driven.org/private-properties-in-javascript); we will revisit the idea of private properties (encapsulation) later in the course.
- [Short intro to memory management for
  JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Memory_Management)
- [ES6 In Depth](https://hacks.mozilla.org/category/es6-in-depth/) contains
  more information on the more recent features introduced to JavaScript.
- [Arrow functions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions).

### Source files we used in class

Code illustrating how to implement block scoping with functions:

- <a href="../../code/intro-js/scope-modern.js">scope-modern.js</a>
- <a href="../../code/intro-js/scope-var.js">scope-var.js</a>
- <a href="../../code/intro-js/scope-modernize-var.js">scope-modernize-var.js</a>
- <a href="../../code/intro-js/scope-modernize-var-pretty.js">scope-modernize-var-pretty.js</a>

Code illustrating the use of callback to perform synchronous and asynchronous
filesystem reads:

- <a href="../../code/intro-js/perf-sync.js">perf-sync.js</a>
- <a href="../../code/intro-js/perf-async.js">perf-async.js</a>
- <a href="../../code/intro-js/perf-async-2.js">perf-async-2.js</a>
- <a href="../../code/intro-js/perf-async-3.js">perf-async-3.js</a>

Code illustrating the use of high order functions and closures:

- <a href="../../code/intro-js/expressive.js">expressive.js</a>
- <a href="../../code/intro-js/hof.js">hof.js</a>
- <a href="../../code/intro-js/closure.js">closure.js</a>

Code illustrating the use of functions to implement modules:

- <a href="../../code/intro-js/module-node.js">module-node.js</a>
- <a href="../../code/intro-js/module.js">module.js</a>

Code illustrating the use of arrow function syntax for function expressions:

- <a href="../../code/intro-js/fat-arrows.js">fat-arrows.js</a>

Code illustrating simple methods and constructors for JavaScript:

- <a href="../../code/intro-js/receiver.js">receiver.js</a>
- <a href="../../code/intro-js/class.js">class.js</a>

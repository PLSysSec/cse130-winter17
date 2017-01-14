+++
date = "2017-01-13T00:00:00-00:00"
description = "description"
draft = false
type = "notes"
title = "JavaScript Section Notes - Week 1, 1/13/2017"

+++


Part 1: Installing Node

First off, here's how to install Node.
On Windows or Mac you can just get the installer from the
Node site: http://nodejs.org
For this discussion I'm running 6.9.4, current LTS release
This is sufficient for what we want to do.

On linux, download the tar.xz file, go to its directory and then run e.g.
tar -xvJf node-*.xz

Move the resulting folder somewhere convenient; I have it at
/home/mario/cse130\_node
Then add it to your path: edit your ~/.bashrc, .zshrc, etc
export PATH=/home/mario/cse130_node/bin:$PATH

now when you run node you should get the node.js REPL. yay!

There's also NVM (Node Version Manager),
which unfortunately doesn't work on my machine.
There's a script on their site (nvm.sh) you can run to install it manually.
This is worth knowing about because it makes it easier to keep multiple
versions of NVM around.

Part 2: The JS Event Loop

This provides a relatively simple concurrency model, so the
programmer doesn't really have much to think about: run what you can;
wait when you need to. While it's not
perfect one can get a lot of mileage out of it, especially when one
is running many I/O intensive (or otherwise waiting-intensive)
tasks at the same time.

```js
let l = setInterval(function () {console.log("hello");}, 1000);
clearInterval(l);
```

A more motivated node example:

```js
fs.watch('.', function (eventType, filename)
 {if(filename) console.log(`change to ${filename}`);});
 ```
 
Now we can get notified every time our file changes! Sweet.

This is what "callbacks" are all about: rather than, for instance,
blocking execution when we read a large file, we can instead
call a (higher order)
function like fs.readFile, and you give it a function specifying
what should be done when the file is loaded.

Here's a fun example: run mkfifo pipe at the shell, then at node

```js
console.log(fs.readFileSync("./pipe").toString());
```

in another console say
cat pipe
type some stuff, then press control-D
notice what's going on in the other console while you're typing text

now change that line to

```js
fs.readFile("./pipe", (err, data) => console.log(data.toString()))
```

see what happens now! (note that the data now comes in a Buffer
data structure which is why we must convert to string)


Part 4: Lambda Calculus
"Dude, Where's My Data??"

We'll proceed in JavaScript, but imagine you're sitting down with the
raw lambda calculus and want to write a program. A natural first question
is the above. Namely, the lambda calculus doesn't seem to come with any
types for representing data, other than functions!

While we could add data types to the language (which is the approach
nearly all languages take, including Haskell) there is another approach
we can take: instead we can use what's called Church encoding,
essentially encoding data as control flow.

Let's start simple: booleans. How can we simulate their behavior? We
have nothing but functions.

This seems tricky, so let's try turning the problem on its head:
how can we _use_ booleans? Fundamentally they only contain one bit
of information; we can process that fully with a single if-else
statement: if(b) then c1 else c2

In fact, we can see this "if" behavior as completely characterizing booleans.
Suppose we had, for each boolean, a function ifb, that took two
functions c1 and c2, and ran the first one if true, second if false?

```js
ifb(true, c1, c2) = c1()
ifb(false, c1, c2) = c2()
```

equivalently we could see these as two functions:

```js
ifbtrue(c1, c2) = c1()
ifbfalse(c1, c2) = c2()
```

in fact, we can see ifbtrue as capturing a notion of
"true boolean value" and likewise ifbfalse. From now on we'll just
write true for ifbtrue, false for ifbfalse

```js
let mytrue = (c1, c2) => c1;
let myfalse = (c1, c2) => c2;

let myif = (b, c1, c2) => b(c1, c2);
```

Once we have booleans, we can construct pairs. Any ideas how?


OK, so a pair is really just two pieces of data, with projections
(think "field names") for the two elements. Building off our booleans,
we can say that "true" is the field name of the first element, and
false the second. Projection looks like:

projtrue((c1, c2)) = c1()
projfalse((c1, c2)) = c2()

more concisely,

proj(b, (c1, c2)) = if b then c1() else c2()

In fact, we can view pairs as precisely these projection functions:
proj(b, p) = b(p) = if b then p(true) else p(false)

```js
var mypaircon = (c1, c2) => ((b) => b(c1, c2));
var myproj1 = (p) => p(mytrue);
var myproj2 = (p) => p(myfalse);
```

What about numbers?
Well, with booleans and pairs, we have enough to represent fixed-width ints
(noting that we can make pairs of pairs, and pairs of pairs of pairs,
and so on, allowing us to represent arbitrary length bit vectors)

There's an encoding that can represent all numbers, called the "Church Numerals"
If you're curious, ask offline! They are complicated but similar in spirit to this.

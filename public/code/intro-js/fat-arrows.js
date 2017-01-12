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

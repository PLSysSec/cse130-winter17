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
  let y = x; // 5, 8
  return function (z) {
    y += z;
    return y;
  };
}

const h = f(5);
console.log(h(3)); // 8
console.log(h(4)); // 12
const j = f(5);
console.log(j(3)); // ?
console.log(j(4)); // ??

console.log(h === j); // ??

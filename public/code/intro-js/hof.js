const list = [1, 2, 3, 4];

const add42 = (el) => {
  return el + 42;
};

function mul1337 (el) {
  return el * 1337;
}

console.log(map(map(list, add42), mul1337));
console.log(map(list, compose(mul1337, add42)));

function compose (f, g) {
  return (x) => { 
    return f(g(x));
  }
}

function map(list, f) {
  const dup = [];
  for (let i = list.length-1; i >= 0; i--) {
    dup.unshift(f(list[i]));
  }
  return dup;
}

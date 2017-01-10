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

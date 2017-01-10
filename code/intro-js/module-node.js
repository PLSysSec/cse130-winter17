const secret = "cse130 is fun!";
exports.myVar = 42;
exports.myFunc = function (x) {
  if (x === secret) {
    console.log('yes!');
  } else {
    console.log('guess again!');
  }
};

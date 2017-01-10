const fs = require('fs');

const r1 = fs.readFileSync('./perf-sync.js', 'utf8'); // blocks until read is done
processFile('perf-sync.js', r1); //blocks until processing (write) is done
const r2 = fs.readFileSync('./perf-async.js', 'utf8'); // etc.
processFile('perf-async.js', r2);

// note that you can declare a function after the point it's used. Hoisting
// essentially moves it to the top.
function processFile(fname, str) {
  fs.writeFileSync(`/tmp/${fname}`, str);
  console.log(`DONE writing /tmp/${fname}`);
}

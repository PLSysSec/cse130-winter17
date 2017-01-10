const fs = require('fs');

fs.readFile('./perf-sync.js', 'utf8', processFile('perf-sync.js'));
fs.readFile('./perf-async.js', 'utf8', processFile('perf-async.js'));

function processFile(fname) {
  return (err, str) => {
    fs.writeFileSync(`/tmp/${fname}`, str);
    console.log(`DONE writing /tmp/${fname}`);
  };
}

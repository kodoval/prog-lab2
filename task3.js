const readline = require("readline");
const rl = readline.createInterface({ input: process.stdin });

function allSameDigits(n) {
    const first = n % 10;
    n = Math.floor(n / 10);
    while (n > 0) {
        if (n % 10 !== first) return false;
        n = Math.floor(n / 10);
    }
    return true;
}

let count = 0;
let current = 0;
let found = false;

rl.on("line", (line) => {
    const val = parseInt(line.trim());
    if (count === 0) {
        count = val;
    } else {
        if (allSameDigits(val)) {
            process.stdout.write(val + " ");
            found = true;
        }
        current++;
        if (current === count) {
            if (!found) console.log("не найдено");
            else console.log();
            rl.close();
        }
    }
});

console.log("Введите количество чисел N, затем сами числа:");

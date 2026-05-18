const readline = require("readline");
const rl = readline.createInterface({ input: process.stdin });
 
function compress(s) {
    let result = "";
    let i = 0;
    while (i < s.length) {
        const c = s[i];
        let count = 0;
        while (i < s.length && s[i] === c) {
            count++;
            i++;
        }
        result += c + count;
    }
    return result.length < s.length ? result : s;
}
 
rl.question("Введите строку: ", (s) => {
    console.log("Результат:", compress(s));
    rl.close();
});

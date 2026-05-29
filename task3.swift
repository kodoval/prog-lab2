import Foundation
 
func allSameDigits(_ n: Int) -> Bool {
    let first = n % 10
    var num = n / 10
    while num > 0 {
        if num % 10 != first { return false }
        num /= 10
    }
    return true
}
 
print("Enter N: ", terminator: "")
let count = Int(readLine()!)!
print("Enter numbers:")
var found = false
for _ in 0..<count {
    let x = Int(readLine()!)!
    if allSameDigits(x) {
        print(x, terminator: " ")
        found = true
    }
}
if !found { print("not found") } else { print() }

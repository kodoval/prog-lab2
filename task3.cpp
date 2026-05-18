#include <iostream>
using namespace std;
 
// Проверяет, что все цифры числа одинаковы (без массивов и строк)
bool allSameDigits(int n) {
    int firstDigit = n % 10;
    n /= 10;
    while (n > 0) {
        if (n % 10 != firstDigit) return false;
        n /= 10;
    }
    return true;
}
 
int main() {
    int count;
    cout << "Введите количество чисел N: ";
    cin >> count;
    cout << "Введите числа: ";
 
    bool found = false;
    for (int i = 0; i < count; i++) {
        int x;
        cin >> x;
        if (allSameDigits(x)) {
            cout << x << " ";
            found = true;
        }
    }
    if (!found) cout << "не найдено";
    cout << endl;
    return 0;
}

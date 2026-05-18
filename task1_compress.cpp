#include <iostream>
#include <string>
using namespace std;
 
string compress(const string& s) {
    string result = "";
    int i = 0;
    while (i < s.size()) {
        char c = s[i];
        int count = 0;
        while (i < s.size() && s[i] == c) {
            count++;
            i++;
        }
        result += c;
        result += to_string(count);
    }
    return result.size() < s.size() ? result : s;
}
 
int main() {
    string s;
    cout << "Введите строку: ";
    cin >> s;
    cout << "Результат: " << compress(s) << endl;
    return 0;
}

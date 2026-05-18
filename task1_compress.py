def compress(s):
    result = ""
    i = 0
    while i < len(s):
        c = s[i]
        count = 0
        while i < len(s) and s[i] == c:
            count += 1
            i += 1
        result += c + str(count)
    return result if len(result) < len(s) else s
 
s = input("Введите строку: ")
print("Результат:", compress(s))

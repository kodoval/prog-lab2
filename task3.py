def all_same_digits(n):
    first = n % 10
    n //= 10
    while n > 0:
        if n % 10 != first:
            return False
        n //= 10
    return True

count = int(input("Введите количество чисел N: "))
found = False
print("Введите числа:")
for _ in range(count):
    x = int(input())
    if all_same_digits(x):
        print(x, end=" ")
        found = True

if not found:
    print("не найдено")
else:
    print()

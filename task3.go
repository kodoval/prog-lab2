package main

import "fmt"

func allSameDigits(n int) bool {
	first := n % 10
	n /= 10
	for n > 0 {
		if n%10 != first {
			return false
		}
		n /= 10
	}
	return true
}

func main() {
	var count int
	fmt.Print("Введите количество чисел N: ")
	fmt.Scan(&count)
	fmt.Print("Введите числа: ")

	found := false
	for i := 0; i < count; i++ {
		var x int
		fmt.Scan(&x)
		if allSameDigits(x) {
			fmt.Print(x, " ")
			found = true
		}
	}
	if !found {
		fmt.Print("не найдено")
	}
	fmt.Println()
}

package main
 
import (
	"fmt"
	"strconv"
)
 
func compress(s string) string {
	result := ""
	i := 0
	for i < len(s) {
		c := s[i]
		count := 0
		for i < len(s) && s[i] == c {
			count++
			i++
		}
		result += string(c) + strconv.Itoa(count)
	}
	if len(result) < len(s) {
		return result
	}
	return s
}
 
func main() {
	var s string
	fmt.Print("Введите строку: ")
	fmt.Scan(&s)
	fmt.Println("Результат:", compress(s))
}

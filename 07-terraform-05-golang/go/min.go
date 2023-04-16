package main

import (
	"fmt"
)

func main() {
	x := []int{48, 96, 86, 68, 57, 82, 63, 70, 37, 34, 83, 27, 19, 97, 9, 17}

	min := x[0] // Инициализируем переменную min первым элементом списка
	for _, value := range x {
		if value < min {
			min = value // Обновляем min, если текущий элемент меньше предыдущего min
		}
	}

	fmt.Println("Наименьший элемент в списке:", min)
}


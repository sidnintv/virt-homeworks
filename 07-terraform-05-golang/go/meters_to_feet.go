package main

import (
	"fmt"
)

const (
	footToMeterRatio = 0.3048
)

func main() {
	var meters float64

	fmt.Print("Введите количество метров: ")
	_, err := fmt.Scanf("%f", &meters)
	if err != nil {
		fmt.Println("Ошибка ввода:", err)
		return
	}

	// Перевод метров в футы
	feet := meters / footToMeterRatio

	fmt.Printf("%.2f метров равно %.2f футов\n", meters, feet)
}


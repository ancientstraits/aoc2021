package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func main() {
	// Provide this file yourself from your
	// version of Advent of Coding.
	file, err := os.Open("day01/input")
	if err != nil {
		panic(err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)

	prev := 9999
	win := [3]int{999, 999, 999}
	ans := 0

	for scanner.Scan() {
		win[0] = win[1]
		win[1] = win[2]
		i, err := strconv.Atoi(scanner.Text())
		if err != nil {
			fmt.Println(err)
			continue
		}
		win[2] = i

		sum := win[0] + win[1] + win[2]
		if sum > prev {
			ans++
		}

		prev = sum
	}

	if err := scanner.Err(); err != nil {
		panic(err)
	}

	fmt.Println(ans)
}

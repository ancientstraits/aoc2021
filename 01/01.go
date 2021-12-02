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
	file, err := os.Open("01/input")
	if err != nil {
		panic(err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)

	ans := 0
	prev := 99999
	for scanner.Scan() {
		curr, err := strconv.Atoi(scanner.Text())
		if err != nil {
			fmt.Println(err)
			continue
		}

		if curr > prev {
			ans++
		}

		prev = curr
	}

	if err := scanner.Err(); err != nil {
		panic(err)
	}

	fmt.Println(ans)
}

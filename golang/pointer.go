package main

import "fmt"

func a(ival int) {
    ival = 0
}

func b(iptr *int) {
	another := 3
	*iptr = another
	iptr = &another
	fmt.Println(">>", *iptr)
}

func main() {
	i := 1
	
    a(i)
    fmt.Println("zeroval:", i)

    b(&i)
    fmt.Println("zeroptr:", i)

    fmt.Println("pointer:", &i)
}
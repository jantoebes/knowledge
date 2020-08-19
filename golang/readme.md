Links
- https://gobyexample.com/
- https://golang.org/doc/effective_go.html
- https://blog.golang.org/slices-intro

# Variables
- Variables declared without a corresponding initialization are zero-valued. For example, the zero value for an int is 0.
- Variables do have type inference
- The `:= syntax` is shorthand for declaring and initializing a variable

# Constants
- A numeric constant has no type until it’s given one, such as by an explicit conversion.
- A number can be given a type by using it in a context that requires one, such as a variable assignment or function call.

- For loop has break and continue

# Switch
- Switch without an expression is an alternate way to express if/else logic.
```    
switch {
case t.Hour() < 12:
    fmt.Println("It's before noon")
default:
    fmt.Println("It's after noon")
}
```

# Array
- Here we create an array a that will hold exactly 5 ints. The type of elements and length are both part of the array’s type. By default an array is zero-valued, which for ints means 0s.
- You can create multidimensional arrays `var twoD [2][3]int`
- You can declare and initialize arrays at once `b := [5]int{1, 2, 3, 4, 5}`

# Slice
- Has no predefined length
- Supports append, copy
- Supports range creation
- Slice operators slices part of array

# Range
- iterates over elements in a variety of data structures

# Functions
- When you have multiple consecutive parameters of the same type, you may omit the type name for the like-typed parameters
- Go requires explicit returns
- You can return multiple values `func vals() (int, int) `
- You can have variadic number of arguments `func sum(nums ...int)`
- A function can return another function

# Pointers vs references
- Go has pointers, not references
- Go passes a pointer to an object by value, not an object reference
- You can overwrite the pointer value which has no impact on the caller
- In a function specifiy a pointer by `*`
- `*iptr = 3` replace the value the pointer redirects to
- `iptr = &another` replace the pointer to another address
- `return &p` set return value to address
- `&` is to dereference value

The `&` operator generates a pointer to its operand.

```go
i := 42
p = &i
```

The `*` operator denotes the pointer's underlying value.
```go
fmt.Println(*p) // read i through the pointer p
*p = 21         // set i through the pointer p
```

# Structs
- structs are typed collections of fields

# Methods
- Sort of extension method

# Interfaces
- A map is a reference to the data structure created by make. When a map is passed to a function, the function receives a copy of the reference, so any changes the called function makes to the underlying data structure will be visible through the caller’s map reference too.
- Arguably renaming the type from *map[int]int to map[int]int, while confusing because the type does not look like a pointer, was less confusing than a pointer shaped value which cannot be dereferenced.

# Errors
- By convention, `func f1(arg int) (int, error)` errors are the last type
- It’s possible to use custom types as errors by implementing the Error() method on them

# Goroutines / channels
- Goroutine is lightweight thread of execution
- `go f("goroutine")`
- Send a value into a channel using the `channel <- syntax`
- Receive a value from a channel via `msg := <-messages`
- By default sends and receives block until both the sender and receiver are ready.
    - Buffered channels: accept a limited number of values without a corresponding receiver for those values
    - Channel synchronization: 
```go
func worker(done chan bool) {
    fmt.Print("working...")
    time.Sleep(time.Second)
    fmt.Println("done")
    done <- true
}
```
    - Direction `pings <-chan string` is receiving
    - Direction `pongs chan<- string` is sending

 # Timeouts
 ```go
select {
case res := <-c2:
    fmt.Println(res)
case <-time.After(3 * time.Second):
    fmt.Println("timeout 2")
}
```

# Other
- Ticker for repeatedly intervals
- Waitgroup to wait for multiple goroutines
- Use `atomic counters` to add numbers from differen goroutines
- Lock() the `mutex` to ensure exclusive access to the state, read the value at the chosen key, Unlock() the mutex
- 

# Effects vs side effects  <!-- omit in toc -->
- [Effects](#effects)
- [Effectful functions](#effectful-functions)
- [Example](#example)
- [Articles](#articles)

Summary
- “Effect” or “Effectful” had been widely said in the FP community when describing abstract things.
- Usually, what they meant for “Effect” or “Effectful” is no side effect (sometimes it does). It is Main Effect.

## Effects
Examples of effects:
- Option models the effect of optionality
- Future models latency as an effect
- Try abstracts the effect of failures (manages exceptions as effects)

Similarly:
- Reader is a monad that models the effect of composing operations that depend on some input
- Writer is a monad that models logging as an effect
- State is a monad that models the effect of state (composing a series of computations that maintain state)
- Sync is a monad that models the effects of synchronous lazy execution.

## Effectful functions
- Effectful function is a function that returns `F[A]` rather than `[A]`
- For instance a function returns Option[Int] rather than Int

## Example
```scala
def division(num1:Int, num2:Int): Either[Exception, Int] = if(num2 == 0) {
  Left(new IllegalStatement("num1 cannot divide by zero")) 
} else {
  Right(num1/num2)
}
```

By looking at the code above, we know that without diving through the code, the function can have an “effect” of returning some Exception or integers based on the input type. By explicitly declaring what effect your function can return, other tasks that call division will need to supply a mechanism to handle those "effect" types, making your program deterministic.

## Articles
- https://levelup.gitconnected.com/what-is-effect-or-effectful-mean-in-functional-programming-7fc7323b52b4
- https://alvinalexander.com/scala/what-effects-effectful-mean-in-functional-programming/

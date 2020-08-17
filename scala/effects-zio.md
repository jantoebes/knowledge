> https://aleksandarskrbic.github.io/functional-effects-with-zio/

- `Thunk` is a pointer to a function that executes some code, and it’s a way to make the execution of some code lazy. Fi. `sideEffect: => A`
- Functional programming is based on the simple premise that your functions should not have side effects; they are considered evil in this paradigm. If a function has side effects we call it a `procedure`, so functions do not have side effects.

## Effect
- An effect is a workflow that can represent a sequential, asynchronous, concurrent, or parallel computation that will allocate resources and safely free them after use. 
- Effects are purely descriptive and lazy. 
- They don’t do anything, just describing workflows.

## Side effect
```scala
def effect[A](sideEffect: => A): ZIO[Any, Throwable, A] =
    ZIO(_ => Try(sideEffect).toEither)
```
- The problem with side-effects is that they are doing, not describing,
- Want to defer interaction with the real world as long as possible
- This technique allows us to take some side-effectful code that is eager and turn it into a lazy description


## Access vs accessm
```scala
def access[R, A](f: R => A): ZIO[R, Nothing, A] = 
    ZIO(r => Right(f(r)))
```
- Effect cannot fail
- `M suffix` is used to identify effectful version of some method
```scala
def accessM[R, E, A](f: R => ZIO[R, E, A]): ZIO[R, E, A] = 
    ZIO(r => f(r).run(r))
```

# OrDie
```scala
def orDie(implicit ev: E <:< Throwable): ZIO[R, Nothing, A] =
    ZIO(r => self.run(r).fold(throw _, Right(_)))
```
- Effect is run with r and result will be Either[E, A]
- After that we are folding over Either
- If the effect failed it will throw an exception
- If not, we will wrap the success value into Right

This combinator is useful when there is a possibility of fatal errors that we are not able to recover from.

## UnsafeRun
```scala
def unsafeRun[A](zio: ZIO[Any, Throwable, A]): A =
    zio.run(()).fold(throw _, a => a)
```
- If we get an instance of Throwable we will just throw it
- If we get success value of type A we will return it.

Used for main functions
```scala
def main(args: Array[String]): Unit =
    unsafeRun(program)
```

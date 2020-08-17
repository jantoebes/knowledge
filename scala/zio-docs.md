> https://zio.dev/docs/overview/overview_index

# Type aliases

|Type|Alias|Description|
|-|-|-|
|`UIO[A]`|`ZIO[Any,Nothing,A]`|No requirements, cannot fail, succeed with A|
|`URIO[R,A]`|`ZIO[R,Nothing,A]`|Requires R, cannot fail, succeed with A|
|`Task[A]`|`ZIO[Any,Throwable,A]`|No requirement, may fail with throwable, succeed with A|
|`RIO[R,A]`|`ZIO[R,Throwable,A]`|Requires R, may fail with throwable, succeed with A|
|`IO[E,A]`|`ZIO[Any,E,A]`|No requirements, may fail with E, succeed with A|

- Direct use of the ZIO data type is possible, although you may find it useful to create your own family of type aliases in different parts of your application.

# Creating effects
- `succeed` is intended for values which do not have any side effects
- If you know that your value does have side effects consider using ZIO.`effectTotal` for clarity. The value inside a successful effect constructed with ZIO.effectTotal will only be constructed if absolutely required.

# OptionT equivalent

```scala
val maybeId: IO[Option[Nothing], String] = ZIO.fromOption(Some("abc123"))
def getUser(userId: String): IO[Throwable, Option[User]] = ???
def getTeam(teamId: String): IO[Throwable, Team] = ???


val result: IO[Throwable, Option[(User, Team)]] = (for {
  id   <- maybeId
  user <- getUser(id).some
  team <- getTeam(user.teamId).asSomeError 
} yield (user, team)).optional 
```

`.some` converts option of value to option of error 
`.asSomeError` maps error (throwable) to option (some)
`optional` converts option of error to option of value

# Function
A function A => B can be converted into a ZIO effect
```scala
val zfun: URIO[Int, Int] =
  ZIO.fromFunction((i: Int) => i * i)
```

# Side effects (not zio effects)

## Synchronous
- With `ZIO.effect` when throw exceptions
- With `ZIO.effectTotal` when not throw exceptions
- Prefer `effect` instead of `effectTotal` when in doubt
- You use `refineToOrDie` to treat the other errors as fatal

## Asynchronous
- Use `effectAsync`
```scala
val login: IO[AuthError, User] =
  IO.effectAsync[AuthError, User] { callback =>
    legacy.login(
      user => callback(IO.succeed(user)),
      err  => callback(IO.fail(err))
    )
  }
```

## Blocking Synchronous Side-Effects
- Use `zio.blocking` package with `effectBlocking` or `blocking`
- The resulting effect will be executed on a separate thread pool designed specifically for blocking effects.

```scala
val sleeping =
  effectBlocking(Thread.sleep(Long.MaxValue))
```

or

```scala
def download(url: String) =
  Task.effect {
    Source.fromURL(url)(Codec.UTF8).mkString
  }

def safeDownload(url: String) =
  blocking(download(url))
```
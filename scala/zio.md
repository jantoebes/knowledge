# ZIO  <!-- omit in toc -->
- [Type aliases](#type-aliases)
- [Creating effects](#creating-effects)
- [OptionT equivalent](#optiont-equivalent)
- [Function](#function)
- [Side effects (not zio effects)](#side-effects-not-zio-effects)
- [Basic operations](#basic-operations)
- [Handling errors](#handling-errors)
- [Retry](#retry)
- [Resource handling](#resource-handling)
- [Concurrency](#concurrency)
- [Testing effects](#testing-effects)
- [Effect pattern](#effect-pattern)
## Type aliases

|Type|Alias|Description|
|-|-|-|
|`UIO[A]`|`ZIO[Any,Nothing,A]`|No requirements, cannot fail, succeed with A|
|`URIO[R,A]`|`ZIO[R,Nothing,A]`|Requires R, cannot fail, succeed with A|
|`Task[A]`|`ZIO[Any,Throwable,A]`|No requirement, may fail with throwable, succeed with A|
|`RIO[R,A]`|`ZIO[R,Throwable,A]`|Requires R, may fail with throwable, succeed with A|
|`IO[E,A]`|`ZIO[Any,E,A]`|No requirements, may fail with E, succeed with A|

- Direct use of the ZIO data type is possible, although you may find it useful to create your own family of type aliases in different parts of your application.

## Creating effects
- `succeed` is intended for values which do not have any side effects
- If you know that your value does have side effects consider using ZIO.`effectTotal` for clarity. The value inside a successful effect constructed with ZIO.effectTotal will only be constructed if absolutely required.

## OptionT equivalent

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

- `.some` converts option of value to option of error 
- `.asSomeError` maps error (throwable) to option (some)
- `optional` converts option of error to option of value

## Function
A function A => B can be converted into a ZIO effect
```scala
val zfun: URIO[Int, Int] =
  ZIO.fromFunction((i: Int) => i * i)
```

## Side effects (not zio effects)

### Synchronous
- With `ZIO.effect` when throw exceptions
- With `ZIO.effectTotal` when not throw exceptions
- Prefer `effect` instead of `effectTotal` when in doubt
- You use `refineToOrDie` to treat the other errors as fatal

### Asynchronous
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

### Blocking Synchronous Side-Effects
- Use `zio.blocking` package with `effectBlocking` or `blocking`
- The resulting effect will be executed on a separate thread pool designed specifically for blocking effects.
- With `blocking` the zio side effect will be executed on a different thread pool
  
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

## Basic operations
- Zipping: the effect on the left side is executed before the effect on the right side
- Symbolic alias `*>` and `<*` for zipLeft/zipRight

## Handling errors
- `ZIO.absolve` turns `ZIO[R, Nothing, Either[E, A]]` into a `ZIO[R, E, A]`
- `catchAll` vs `orElse`: with catchAll you get the error
- `fold` handles you succes and/or error

## Retry
- `.retry(Schedule...)` when failed
- `retryOrElse` retry and if that is not successful do something else
  
## Resource handling
- `ensuring` guarantees that an effects uses a finalizer
- `bracket` acquire effect; a release effect, and a use effect

## Concurrency

|Type|Description|Comment|
|-|-|-|
|Thread|Preemptive. Threads do not decide when to run and are forced to share the CPU. Scheduler (OS components) decides at any moment which thread can run and which has to sleep|Data integrity is a big issue because one thread may be stopped in the middle of updating a chunk of data. Operating system can take advantage of multiple CPUs and CPU cores by running more than one thread at the same time and leaving it up to the developer to guard data access|
|Fiber|Cooperative. Each thread, once running decides for how long to keep the CPU, and (crucially) when it is time to give it up so that another thread can use it|Fibers always start and stop in well-defined places, so data integrity is much less of an issue.Expensive context switches and CPU state changes need not be made.Will not take advantage of multiple CPUs or multiple CPU cores (nodejs)|
|Green thread|Scheduled by a virtual machine(VM) instead of natively. Enables multithreaded environemnts without relying on native OS||

![picture 1](../images/8e0e095aba7142a00f9904695407f4e936fb07ac8f2f3de0b49b5dfe2f1ee008.png)  

### ZIO fiber
- Consume almost no memory, have growable and shrinkable stacks, don't waste resources blocking, and will be garbage collected automatically
- Enables multitasking, even when operating in a single-threaded environment 

Actions
- `fork` executing on new fiber
- `join` get return value of the fiber
- `await` get information how the fiber completed
- `interrupt` kill fiber. you can fork interruption to continu without getting outcome
- `race` get first value
- `timout` option to return 
![picture 2](../images/ac6421695395d190ede4c9ce0c68d8763afc2748e78b586a675d996a78fa32b5.png)  

## Testing effects

- ZIO effects can access the environment using `ZIO.environment`, which provides direct access to the environment, as a value of `type R`
- Get a part of the environment via `ZIO.access[Config](_.server)`
- Get part of the environment via effect `ZIO.accessM[DatabaseOps](_.getTableNames)`
- Provide environment via `provide` 


```scala
val square: URIO[Int, Int] = 
  for {
    env <- ZIO.environment[Int]
  } yield env * env

val result: UIO[Int] = square.provide(42)
```

## Effect pattern
### Create service
```scala
object Database {
  trait Service {
    def lookup(id: UserID): Task[UserProfile]
    def update(id: UserID, profile: UserProfile): Task[Unit]
  }
}
trait Database {
  def database: Database.Service
}
```

### Provide helpers
```scala
object db {
  def lookup(id: UserID): RIO[Database, UserProfile] =
    ZIO.accessM(_.database.lookup(id))

  def update(id: UserID, profile: UserProfile): RIO[Database, Unit] =
    ZIO.accessM(_.database.update(id, profile))
}
```

### Use the service
```scala
val lookedupProfile: RIO[Database, UserProfile] = 
  for {
    profile <- db.lookup(userId)
} yield profile
```

### Implement service
```scala
val lookedupProfile: RIO[Database, UserProfile] = 
  for {
    profile <- db.lookup(userId)
  } yield profile
```

### Resources
- https://zio.dev/docs/overview/overview_index

# ZLayer <!-- omit in toc -->

ZLayer => Module principe
ZManaged => Resource acquisition


- https://blog.softwaremill.com/zio-environment-meets-constructor-based-dependency-injection-6a13de6e000
- https://zio.dev/docs/howto/howto_use_layers

- Individual instances of the dependencies can be accessed through the `ZIO.access(f: R => A): ZIO[R, Nothing, A]` method
- Either making dependencies explicit or keeping them hidden, is what differentiates the two approaches

- A module (zlayer) is a group of functions that deals with only one concern

- What's the use of Has if the resulting type is just a mix of two traits? Why aren't we just relying on trait mixins?

- it is extremely convenient to define a type alias for Has[Service]



# Resources
- https://scala.monster/
- https://github.com/wix/greyhound
- https://zio.dev/docs/howto/howto_use_layers
- https://blog.softwaremill.com/managing-dependencies-using-zio-8acc1539e276
- https://medium.com/@wiemzin/zio-with-http4s-and-doobie-952fba51d089

![picture 1](../images/e139410361e314a9e980f4a3f942441ab5706a4f30fe1ea92f1c38dfc7e96c3a.png)  

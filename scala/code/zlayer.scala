import $ivy.{
  `dev.zio::zio:1.0.1`
}


type UserId = String
case class User(id: UserId, name: String)

def getUser(userId: UserId): ZIO[DBConnection, Nothing, Option[User]] = UIO(???)

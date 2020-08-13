https://medium.com/swlh/combining-purely-functional-property-based-and-docker-integration-tests-in-zio-6a826c5e7e19

krijg van meerdere mensen de vraag hoe je de applicatie moe structeren met zlayers. Ik zelf vond mijn service laag schrijven met behulp van RIO  wel erg nuttig. Je praat niet direct met een database of een api, maar je omschrijft eigenlijk met welke systemen je interacteert en hoe je omgaat met input van die systemen (orchestratie). Dat kan je makkelijk testen door er gemockte varianten in te stoppen. Daarmee test je business logic. Elke dependency is een soort van taal die je spreekt over een bepaald sub systeem. Dus het aanspreken van een adresss api, aanspreken van een users database, business entiteit opzoeken, etc. Wat daar precies onderzit intresseert je eigenlijk niet zoveel op dat moment. Het testen van dat doe je in aparte tests. Daarmee los je dus kleine deel problemen op. Zelf heb ik het in modules gestopt en daarmee ook de tests van die subsystemen, zodat je dat parallel kan testen.
Een andere aanpak omschrijft Pavel hier in zijn blog https://www.scala.monster
Tweede artikel gaat in op zio-test
Derde artikel gaat in op het structeren van de applicatie met zlayer en rio.
Goed om dat derde artikel even te lezen en de bijbehorende bron code is te bestuderen https://github.com/psisoyev/release-pager

https://github.com/wix/greyhound
https://zio.dev/docs/howto/howto_use_layers
https://blog.softwaremill.com/managing-dependencies-using-zio-8acc1539e276
![picture 1](../images/952d63a4330fb26d9724a2d021570596b981428331a75943e3ffc881085d7952.png)  
https://medium.com/@wiemzin/zio-with-http4s-and-doobie-952fba51d089
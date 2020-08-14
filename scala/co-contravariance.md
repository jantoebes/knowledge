# Covariance
- Allow lower types. Simple.
  
# Contravariance
- Serialization function. Allows serializers for higher types, but then not all properties will be serialized
- Sorting function. 
- Pattern is that it is never on case classes, but most of time on functions that work with case classes

```csharp
// the Set<T> constructor uses a contravariant interface, IComparer<in T>,
// we can use a more generic type than required.
var teacherSet = new SortedSet<Teachers>(teachers, new PersonNameComparer());
```
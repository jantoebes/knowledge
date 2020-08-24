# Table of contents
This readme contains a summary of interesting blogs about architecture
- [Table of contents](#table-of-contents)
- [Resilence in deep systems](#resilence-in-deep-systems)

---

# Resilence in deep systems
> https://www.infoq.com/articles/resilience-deep-systems

- The `depth of a system` can be considered as the number of microservices layers in the application stack.

3 ingredients that can help you nourish resilience in deep systems
- Service granularity - Go for a real business capability
- Sharing data - safe and consistent -  The worst monolith you can have is a distributed monolith
  - When using synchronous communicatie, like REST, result in tightly coupling and increased dependency on network. Such deep system is more like a monolith (distributed monolith)
  - When using asynchronous communication, adding more subscribers to the data is easy and will not hammer the publisher service with more traffic. Are eventual consistent. Doesnt require complex cache management systems.
- Distributed storytelling
  - Don’t lose sight of the flow of events; increase observability.
  - Correlation ID/Trace ID
  - Distributed tracing
  - Monitor workflow automation (like zeebe)

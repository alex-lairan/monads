---
layout: home

hero:
  name: monads
  text: Monads for Crystal
  tagline: Composable Maybe, Either, List, Try and Task — chain instructions, tame nil, and handle errors without exceptions.
  actions:
    - theme: brand
      text: Get Started
      link: /guide/getting-started
    - theme: alt
      text: What is monads?
      link: /guide/
    - theme: alt
      text: View on GitHub
      link: https://github.com/alex-lairan/monads

features:
  - title: Avoid nil
    details: The Maybe monad replaces nil checks with Just and Nothing, so absent values can never slip through unhandled.
  - title: Errors without exceptions
    details: The Either monad carries a success or an error value through a chain, deferring failure handling to the end.
  - title: Bridge OO and FP
    details: Try and Task wrap exception-throwing code into monads, with Task running the work on a fiber.
  - title: One consistent interface
    details: fmap, bind, and fold work the same way across every monad, plus the | and >> operators for chaining.
---

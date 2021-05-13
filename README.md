# Property-Based Testing
## Notes
Example-based unit tests made it easy to lock down bugs we could see coming, but those we couldn’t see coming at all were left in place and would probably have made it to production. With properties (and a framework to execute them), we can instead explore the problem space more in depth, and find bugs and design issues much earlier. The math is simple: bugs that make it to production are by definition bugs that we couldn’t see coming. If a tool lets us find them earlier, then production will see fewer bugs.

When we test with properties, the design and growth of tests requires an equal part of growth and design of the program itself. A common pattern when a property fails will be to figure out if it’s the system that is wrong or if it’s our idea of what it should do that needs to change. We’ll fix bugs, but we’ll also fix our understanding of the problem space. We’ll be surprised by how things we thought we knew are far more complex and tricky than we thought, and how often it happens.

## Elixir Notes
* A piece of data of any data type is called a *term*.

## Setup
Download dependencies
```
mix deps.get
```

Run tests
```
mix test
```

Start console
```
MIX_ENV="test" iex -S mix
```


## Upto
Page 218
Testing a Basic Concurrent Cache

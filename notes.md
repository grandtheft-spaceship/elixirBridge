# Elixir Bridge
## Why Elixir?

* Scalable
  * Refers to vertical or horizontal scalability
  * uses the network as a local resource
* Fault-tolerant
  * Refers to the action when something fails
  * When something crashes, Elixir will handle the crash and try to keep the application running
* Functional
* Very extensible
* Built off erlang
  * Elixir compiles down to erlang. Erlang compiles down to EVM
* Erlang is a highly scalable language
* Telco-strong
  * Built by *telephone companies*
* Hot-reload friendly
  * Application can continue to run while uploading new code
* Soft real-time
   * not *immediate real-time*

## Functional Language

* Everything is immutable
  * Cannot change variables
* Composable
* 1 input / 1 output
* Nothing is manipulated **outside** of the function

## iex

* Elixir interactive console
* **help function**
  * `$ h *functionName`
* To load a file, you need to **compile** it, `$ c(fileName)`

## Data Types

* To check the data type of a value:
  * `i value`
* **Integers**
  * Can represent large numbers with *underscores*
    * `$ 100_000_000`
  * Can also represent using `e`
    * `$ 1.0e6 == 1_000_000`
* **Floats**
  * Can also use Hex, Octal, and Binary
* **Booleans**
* **Strings**
  * By default, Erlang does not contain the concept of strings, Elixir brings in strings
  * Elixir has *character arrays*
  * Can do *interpolation* and *concatenation*
    * `"Hello "<>"world"` - concatenation
  * Generally **use double quotes**
* **Atoms**
  * Similar to *symbols* in Ruby
  * There is only ever one instance of an atom
    * It will always point to the same position in memory
  * `:hello`

## Comparison
```
1 + 1 == 2
1 > 2
1 <= 4
1 != 2
```
### Strict Comparison

```
2 == 2.0 # true // value checking
2 === 2.0 # false // type checking
```

## Lists

* Collection of objects in a *linked list* (O(n))
  * All lists are *doubly linked lists*
  ```
  [1, "2", 'c']
  ```
* Head/Tail
* `[h|t] = [1, 2, 3] # h = 1 / t = [2, 3]`
  * **Destructuring**
* List concatenation
  `[1, 2] ++ [3,4]`
* List subtraction
  `[1,2,2,3,4,2,5] -- [2,3] # => [1,2,3,4,2,5]`

## Tuples

* Similar to lists, but a different data structure
  * Fixed-size data structure // *cannot change the size it was when created*
  * Similar to an index
* Can create multiple-return values
* Great for pattern-matching
```
{:hello, "world"}
{99, :bottles, "ok"}
```
* **Tuples or lists?**
  * Lists are slow to modify/read, but fast creation. Tuples are expensive to modify, but usually good for handling pattern matching and returning additional information

## Keyword lists

* Keyword lists are a special kind of list
* Similar to *hashes* in Ruby
* **Keys**
  * Atoms
  * Ordered
  * Not unique
```
[greeting: "Hello", receiver: "world"]
[{:greeting, "Hello"}, {:receiver, "world"}]
```
`[a: 1, a: 2][:a] # => 1`
`[h|t] = [a: 1, a: 2] # => t = 2`

## Maps

* Keys can be *strings*
  * Keys are unordered
* Similar to keyword lists
```
map = %{:msg => "Hello", "receiver" => :world}
%{map | msg: "goodbye"}
map.msg
```

## Enumerables

* Functions to iterate over lists
`Enum.map([1,2,3], fn(x) -> x*2 end) # => [2,4,6]`
```
all?
any?
chunk
map
reduce
...
```

## Pipe Operators

* Takes a return value of a pervious function and passes it as the first argument for another function
* NOT similar to a callback because they are *synchronous*
  * `|>`
`[1,2,3] |> Enum.map(fn(x) -> x*2 end) # => [2,4,6]`

## Lazy vs Eager *(In Enumerables)*

* **Eager** - all operations need to execute before completion
* **Lazy** - Operations are only performed when necessary
  * **Stream** modules are built into Elixir
    * *Streams* are endless
    * **Unfold operator** - turns the stream output to a *list*; ends the cycle

## Pattern Matching

* Under the hood, *everything is pattern matching*
```
a = 1
1 = a # => 1
```
  *Pattern match the right side against the left side and return the value if matched*
```
$ (1)> list = [1,2,3]
=> [1, 2, 3]
$ [1,2,3] = list
=> [1, 2, 3]
$ [] = list
=> ** (MatchError) no match of right hand side value: [1, 2, 3]
```
```
$ list = [1,2,3]
$ [1|tail] = list
=> [1, 2, 3]
$ tail
=> [2, 3]
$ [2|tail] = list
=> ** (MatchError) no match of right hand side value: [1, 2, 3]
```
```
$ [1,2,c] = [1,2,4]
$ c
=> 4
```
```
$ {:ok, return} = {:ok, "world"}
=> {:ok, "world"}
$ return
=> "world"
```

## Pin Operator

* `^x = 1`
  * DOES NOT *rebind* the variable
```
$ x = 1
=> 1
$ {x, ^x} = {2, 1}
=> {2, 1}
$ x
=> 2
```
```
$ x = 2
=> 2
$ {x, ^x} = {4, 3}
=> ** (MatchError) no match of right hand side value: {4, 3}

$ x
=> 2
$ {x, ^x} = {4, 2}
=> {4, 2}
$ x
=> 4
```

## Modules

* Everything in Elixir are defined within *modules*
  * Group together functionality
* In **iex**
`$ c("fileName.ex")`
`moduleName.function(*args)`
`$ moduleName. + tab` -> outputs all functions the module contains
* You can use *optional arguments* - `\\`
`def methodName(a, b \\ 1)`
```
$ Calc.
=> add/1         add/2         subtract/2`
```
* **import**
  * You can import modules directly into your namespace
```
$ import Calc
$ add(1, 2)
```
* **require**
  * Tells compiler to make sure a module is available before compilation;
* **use**
  * Can *decorate* a module with additional functionality

## Functions

* Private functions `defp name(args*), do: *logic*` (single line functions)
* Can use `?` and `!` characters in function names
* **Pattern matching** with functions
```
defmodule Calc do
  def zero?(0), do: true
  def zero?(x) when is_integer(x), do: false # guard statement
end
```
* Checking types // guard statements
  * is_integer(1)
  * is_atom(:atom)
  * is_float(1.0)
  * is_list([1,2,3])
  * is_tuple({:a, 2})
  * is_binary(<<"hello">>)
  *can also include `not` keyword to check the inverse of statement*
* `def zero?(_x)` - The underscore tells compiler to NOT store the value

## Mix

* Build tool for elixir
* `$ mix new appname`

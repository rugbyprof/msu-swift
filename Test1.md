-----

Whats the difference between a `tuple` and an `array` or `dictionary` type?

-----

Given:
```swift
var surveyAnswer: String?
```

What would the following output?
```swift
println(surveyAnswer) 
```
-----

##### Assertions

>Optionals enable you to check for values that may or may not exist, and to write code that copes gracefully with the absence of a value. In some cases, however, it is simply not possible for your code to continue execution if a value does not exist, or if a provided value does not satisfy certain conditions. In these situations, you can trigger an assertion in your code to end code execution and to provide an opportunity to debug the cause of the absent or invalid value.

##### When to Use Assertions

- Use an assertion whenever a condition has the potential to be false, but must definitely be true in order for your code to continue execution. Suitable scenarios for an assertion check include:

- An integer subscript index is passed to a custom subscript implementation, but the subscript index value could be too low or too high.
- A value is passed to a function, but an invalid value means that the function cannot fulfill its task.
An optional value is currently nil, but a non-nil value is essential for subsequent code to execute successfully.

-----

```swift
let b = 10
var a = 5
a = b
```

What is the value of `a`?

-----

let (x, y) = (1, 2)
// x is equal to 1, and y is equal to 2

-----



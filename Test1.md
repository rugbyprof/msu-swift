- Syntax errors, if found, are **not** intentional and should not be taken into account when answering questions (unless specifically instructed to do so).

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

```swift
let (x, y) = (1, 2)
// x is equal to 1, and y is equal to 2
```
-----

```swift
var a = 0
let b = ++a
// a and b are now both equal to 1
let c = a++
// a is now equal to 2, but c has been set to the pre-increment value of 1
```

-----

What are the differences between the code snippets below?

```swift
let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)
// rowHeight is equal to ?
```

```swift
let contentHeight = 40
let hasHeader = true
var rowHeight = contentHeight
if hasHeader {
    rowHeight = rowHeight + 50
} else {
    rowHeight = rowHeight + 20
}
// rowHeight is equal to ?
```

-----

Range Operators:

```swift
for index in 1...5 {
    println("\(index) times 5 is \(index * 5)")
}
```
```swift
for index in 1..<5 {
    println("\(index) times 5 is \(index * 5)")
}
```

-----

Valid Syntax?

```swift
if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
    println("Welcome!")
} else {
    println("ACCESS DENIED")
}
```

-----

##### NOTE

>It is good practice to create immutable collections in all cases where the collection does not need to change. Doing so enables the Swift compiler to optimize the performance of the collections you create.

-----

```swift
for (index, value) in enumerate(shoppingList) {
    println("Item \(index + 1): \(value)")
}
```

----- 

Initialize an empty array:

```swift
var someInts = [Int]()
```

-----

```swift
var address = ("Number":3410, "Line 1":Taft Blvd", "Line 2":"Computer Science","City":"Wichita Falls","State":"Tx", "Zipcode":78245)
```
Write out the `City` portion of the `Tuple`:
A: `println(address.City)`
B: `println(address["City"])`
C: `println(address.3)`
D: `A & C`
E: `A & B`

-----

```swift
var dictionary = ["Bobs": "Dog", "Billys": "Cat", "Suzies": "Cow", "Beths": "Snake"]
```

Remove the entry "Billys":"Cat".
-----

enum CompassPoint {
    case North
    case South
    case East
    case West
}

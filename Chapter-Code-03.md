## Classes and Structs

#### Create file: Treasure.swift

```swift
class Treasure {
  let what: String
  let latitude: Double
  let longitude: Double
}
```
####  Add to above class

```swift
init(what: String, latitude: Double, longitude: Double) {
  self.what = what
  self.latitude = latitude
  self.longitude = longitude
}
```
#### Create file: GeoLocation

```swift
struct GeoLocation {
  var latitude: Double
  var longitude: Double
}
```

### Treasure.swift

- Replace lat lon with:

```swift
let location: GeoLocation
```
## Reference types vs. value types

#### Playground

```swift
import UIKit

var str = "Hello, playground"

struct MyStruct{
    var foo: Double = 0.0
}

class MyClass {
    var foo: Double = 0.0
}

var structA = MyStruct()
var structB = MyStruct()
//structB.foo = 1.0
//structA.foo
//structB.foo

structA.foo = 1.0
structB.foo = 2.0
structB = structA

structB.foo
structA.foo


var classA = MyClass()
var classB = classA

//classB.foo = 1.0
//classA.foo
//classB.foo

//classA.foo = 1.0
//classB.foo = 1.0
//classB = classB
```
## Convenience initializers

#### Treasure.swift
```swift
    convenience init(what: String,latitude: Double, longitude: Double){
        let location = GeoLocation(
                latitude: latitude,
                longitude: longitude
        )
        self.init(what: what, location: location)
    }
```

## Class inheritance
#### Treasure.swift
```swift
class HistoryTreasure: Treasure {
        
        let year: Int
        
        init(what: String, year: Int,latitude: Double, longitude: Double){
            self.year = year
            let location = GeoLocation(latitude: latitude,longitude: longitude)
            super.init(what: what, location: location)
        }
}

class FactTreasure: Treasure {
        
        let fact: String
        
        init(what: String, fact: String,latitude: Double, longitude: Double){
            self.fact = fact
            let location = GeoLocation(latitude: latitude,longitude: longitude)
            super.init(what: what, location: location)
        }
}

class HQTreasure: Treasure {
            
        let company: String
        
        init(company: String, latitude: Double, longitude: Double) {
            self.company = company
            let location = GeoLocation(latitude: latitude,longitude: longitude)
            super.init(what: company + " headquarters",location: location)
        }
}
```

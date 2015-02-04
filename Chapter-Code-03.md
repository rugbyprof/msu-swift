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
## Swift and MapKit

#### ViewController.swift

```swift
    override func viewDidLoad() {
        super.viewDidLoad()
    }
```

#### Add below `@IBOutlet`

```swift
        self.treasures = [
            HistoryTreasure(
                what: "Google's first office",
                year: 1999,
                latitude: 37.44451,
                longitude: -122.163369
            ),
            HistoryTreasure(
                what: "Facebook's first office",
                year: 2005,
                latitude: 37.444268,
                longitude: -122.163271
            ),
            FactTreasure(
                what: "Stanford University",
                fact: "Founded in 1885 by Leland Stanford.",
                latitude: 37.427474,
                longitude: -122.169719
            ),
            FactTreasure(
                what: "Moscone West",
                fact: "Host to WWDC since 2003.",
                latitude: 37.783083,
                longitude: -122.404025
            ),
            FactTreasure(
                what: "Computer History Museum",
                fact: "Home to a working Babbage Difference Engine.",
                latitude: 37.414371,
                longitude: -122.076817
            ),
            HQTreasure(
                company: "Apple",
                latitude: 37.331741,
                longitude: -122.030333
            ),
            HQTreasure(
                company: "Facebook",
                latitude: 37.485955,
                longitude: -122.148555
            ),
            HQTreasure(
                company: "Google",
                latitude: 37.422,
                longitude: -122.084
            ),
        ]
```

## Class extensions and computed properties

#### Treasure.swift

```swift
import MapKit
```

#### Underneath `class Treasure`

```swift
extension Treasure: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        return self.location.coordinate
    }
    var title: String {
        return self.what
    }
}
```

#### Geolocation.swift

```swift
import MapKit
```

```swift
extension GeoLocation {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(self.latitude, self.longitude)
    }
    var mapPoint: MKMapPoint {
        return MKMapPointForCoordinate(self.coordinate)
    }
}
```

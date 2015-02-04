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

##### Underneath `class Treasure`

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
##### Underneath `struct GeoLocation`

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

## Inheriting from NSObject

#### Add `NSObject` after `class Treasure` like so: `class Treasure: NSObject`

## Pinning the map

##### `ViewController.swift` (end of `viewDidLoad()`)

```swift
self.mapView.delegate = self
self.mapView.addAnnotations(self.treasures)
```

#### End of `ViewController.swift`

```swift
extension ViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView!,viewForAnnotation annotation: MKAnnotation!)-> MKAnnotationView!{
        // 1
        if let treasure = annotation as? Treasure {
            // 2
            var view = mapView.dequeueReusableAnnotationViewWithIdentifier("pin") as MKPinAnnotationView!
                
            if view == nil {
            // 3
                view = MKPinAnnotationView(annotation: annotation,reuseIdentifier: "pin")
                view.canShowCallout = true
                view.animatesDrop = false
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as UIView} else {
                // 4
                view.annotation = annotation
            }
            // 5
            return view
        }
        return nil
    }
}
```

## The reduce algorithm

##### End of viewDidLoad()

```swift
        let rectToDisplay = self.treasures.reduce(MKMapRectNull) {
            (mapRect: MKMapRect, treasure: Treasure) -> MKMapRect in
            let treasurePointRect = MKMapRect(origin: treasure.location.mapPoint, size: MKMapSize(width: 0, height: 0))
            return MKMapRectUnion(mapRect, treasurePointRect)
        }
        self.mapView.setVisibleMapRect(rectToDisplay, edgePadding: UIEdgeInsetsMake(74, 10, 10, 10), animated: false)
```

## Polymorphism

##### End of `Treasure.swift` / `class Treasure`

```swift
func pinColor() -> MKPinAnnotationColor {
  return MKPinAnnotationColor.Red
}
```

#### Add the override to History and HQTreasure

```swift
func pinColor() -> MKPinAnnotationColor {
  return MKPinAnnotationColor.Green
}

func pinColor() -> MKPinAnnotationColor {
  return MKPinAnnotationColor.Purple
}
```
##### At the end of `extension ViewController: MKMapViewDelegate` before the return

```swift
view.pinColor = treasure.pinColor()
```

## Dynamic dispatch and final classes

```swift

final class HistoryTresure: Treasure
final class FactTreasure: Treasure
final class HQTreasure: Treasure
```

## Adding annotations

```swift
@objc protocol Alertable {
   func alert() -> UIAlertController
}
```

##### Add to bottom of Treasure.swift

```swift
extension HistoryTreasure: Alertable {
    func alert() -> UIAlertController {
        let alert = UIAlertController(title: "History",
                                      message: "From \(self.year):\n\(self.what)",
                                      preferredStyle: UIAlertControllerStyle.Alert)
        return alert
    }
}
extension FactTreasure: Alertable {
    func alert() -> UIAlertController {
        let alert = UIAlertController(title: "Fact",
                                      message: "From \(self.what):\n\(self.fact)",
                                      preferredStyle: UIAlertControllerStyle.Alert)
        return alert
    }
}
extension HQTreasure: Alertable {
    func alert() -> UIAlertController {
        let alert = UIAlertController(title: "Headquarters",
                                      message: "The headquarters of \(self.company)",
                                      preferredStyle: UIAlertControllerStyle.Alert)
        return alert
    }
}
```

### Create file: Treasure.swift

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
### Create file: GeoLocation

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


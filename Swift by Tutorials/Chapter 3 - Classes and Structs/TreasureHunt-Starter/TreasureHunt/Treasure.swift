//
//  Treasure.swift
//  TreasureHunt
//
//  Created by Terry Griffin on 1/28/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import Foundation
import MapKit

class Treasure: NSObject {
    let what: String
    let location: GeoLocation
    
    init(what: String, location: GeoLocation){
        self.what = what
        self.location = location
    }
    
    convenience init(what: String, latitude: Double, longitude: Double)
    {
        let location = GeoLocation(latitude: latitude, longitude: longitude)
        self.init(what: what, location: location)
    }
    
}

extension Treasure: MKAnnotation {
        var coordinate: CLLocationCoordinate2D {
            return self.location.coordinate
        }
        var title: String {
            return self.what
        }
}

// 1
class HistoryTreasure: Treasure {
        let year: Int
        // 2
        init(what: String, year: Int,latitude: Double, longitude: Double){
        self.year = year
        let location = GeoLocation(latitude: latitude,longitude: longitude)
        super.init(what: what, location: location)
        }
}
// 3
class FactTreasure: Treasure {
        let fact: String
        init(what: String, fact: String,latitude: Double, longitude: Double){
        self.fact = fact
        let location = GeoLocation(latitude: latitude,longitude: longitude)
        super.init(what: what, location: location)
        }
}
// 4
class HQTreasure: Treasure {
        let company: String
        init(company: String, latitude: Double, longitude: Double) {
        self.company = company
        let location = GeoLocation(latitude: latitude,longitude: longitude)
        super.init(what: company + " headquarters",location: location)
        }
}



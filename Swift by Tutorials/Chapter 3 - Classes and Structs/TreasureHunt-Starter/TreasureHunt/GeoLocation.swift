//
//  GeoLocation.swift
//  TreasureHunt
//
//  Created by Terry Griffin on 1/28/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import Foundation
import MapKit

struct GeoLocation{
    var latitude: Double
    var longitude: Double
}

extension GeoLocation {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(
        self.latitude, self.longitude)
    }
    var mapPoint: MKMapPoint {
        return MKMapPointForCoordinate(self.coordinate)
    }
}

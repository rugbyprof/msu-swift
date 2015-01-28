//
//  Bowtie.swift
//  Bow Ties
//
//  Created by Pietro Rea on 10/26/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import Foundation
import CoreData

class Bowtie: NSManagedObject {

    @NSManaged var timesWorn: NSNumber
    @NSManaged var searchKey: String
    @NSManaged var rating: NSNumber
    @NSManaged var name: String
    @NSManaged var lastWorn: NSDate
    @NSManaged var isFavorite: NSNumber
    @NSManaged var photoData: NSData
    @NSManaged var tintColor: AnyObject

}

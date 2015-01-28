//
//  Dog.swift
//  Dog Walk
//
//  Created by Pietro Rea on 10/28/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import Foundation
import CoreData

class Dog: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var walks: NSOrderedSet

}

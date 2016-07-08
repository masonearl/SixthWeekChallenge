//
//  Pair+CoreDataProperties.swift
//  SixWeekTechnicalChallenge
//
//  Created by Mason Earl on 7/8/16.
//  Copyright © 2016 trianglez. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Pair {

    @NSManaged var name: String?
    @NSManaged var group: String?

}

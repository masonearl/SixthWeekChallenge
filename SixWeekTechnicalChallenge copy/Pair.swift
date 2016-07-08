//
//  Pair.swift
//  SixWeekTechnicalChallenge
//
//  Created by Mason Earl on 7/8/16.
//  Copyright © 2016 trianglez. All rights reserved.
//

import Foundation
import CoreData

@objc(Pair)
class Pair: NSManagedObject {
    
    convenience init(group: String?, name: String?, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
    let entity = NSEntityDescription.entityForName("Pair", inManagedObjectContext: context)!
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
    self.group = group
    self.name = name
        
    }
}

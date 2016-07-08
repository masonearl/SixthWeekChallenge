//
//  PairController.swift
//  SixWeekTechnicalChallenge
//
//  Created by Mason Earl on 7/8/16.
//  Copyright © 2016 trianglez. All rights reserved.
//

import Foundation
import CoreData

class PairController {
    
    // MARK: Properties & Initialization
    static var sharedInstance = PairController()
    let fetchedResultsController: NSFetchedResultsController
    
    init() {
        let moc = Stack.sharedStack.managedObjectContext
        let request = NSFetchRequest(entityName: "Pair")
        let groupDescriptor1 = NSSortDescriptor(key: "Group1", ascending: false)
        let groupDescriptor2 = NSSortDescriptor(key: "Group2", ascending: true)
        let groupDescriptor3 = NSSortDescriptor(key: "Group3", ascending: true)
        let groupDescriptor4 = NSSortDescriptor(key: "Group4", ascending: true)
        
        request.sortDescriptors = [groupDescriptor1, groupDescriptor2, groupDescriptor3, groupDescriptor4]
        
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: "Pair", cacheName: nil)
        _ = try? fetchedResultsController.performFetch()
        
    }
    
    func addPerson(name: String, group: String) {
        _ = Pair(group: group, name: name)
        saveToPersistentStorage()
        
    }
    
    func removePerson(pair: Pair) {
        pair.managedObjectContext?.deleteObject(pair)
        saveToPersistentStorage()
    }
    
    func updatePair(pair: Pair, name: String, group: String) {
        pair.name = name
        pair.group = group
        
        saveToPersistentStorage()
    
    }
    
    func saveToPersistentStorage() {
        let _ = try? Stack.sharedStack.managedObjectContext.save()
    }
    
}

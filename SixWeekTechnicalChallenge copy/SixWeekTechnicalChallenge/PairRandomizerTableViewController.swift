//
//  PairRandomizerTableViewController.swift
//  SixWeekTechnicalChallenge
//
//  Created by Mason Earl on 7/8/16.
//  Copyright © 2016 trianglez. All rights reserved.
//

import UIKit
import CoreData

class PairRandomizerTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    // MARK: Properties

    var pair: Pair?
    var nameText: String!
    var groupText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PairController.sharedInstance.fetchedResultsController.delegate = self
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sections = PairController.sharedInstance.fetchedResultsController.sections,
            index = Int(sections[section].name) else { return nil }
        if index == 0 {
            return "Group 1"
        } else {
            return "Group 2"
        if index == 2 {
            return "Group 3"
        } else {
            return "Group 4"
        }
    }
}

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return PairController.sharedInstance.fetchedResultsController.sections?.count ?? 0
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = PairController.sharedInstance.fetchedResultsController.sections?[section]
        return section!.numberOfObjects ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("pairCell", forIndexPath: indexPath) as? PairTableViewCell,
            let pair = PairController.sharedInstance.fetchedResultsController.objectAtIndexPath(indexPath) as? Pair else { return UITableViewCell() }
        cell.updateWithPair(pair)
//        cell.delegate = self
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            guard let pair = PairController.sharedInstance.fetchedResultsController.objectAtIndexPath(indexPath) as? Pair
                else { return }
            PairController.sharedInstance.removePerson(pair)
        }
    }
    
    func cellButtonTapped(sender: PairTableViewCell) {
        guard let indexPath = tableView.indexPathForCell(sender),
            pair = PairController.sharedInstance.fetchedResultsController.objectAtIndexPath(indexPath) as? Pair
            else { return}
        sender.updateWithPair(pair)
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.pair = (PairController.sharedInstance.fetchedResultsController.objectAtIndexPath(indexPath) as! Pair)
        self.nameText = pair?.name
        self.groupText = pair?.group
        //editPairAlert()
    }
    
    func updateWithPair() {
        let name = pair?.name
        let group = pair?.group
        self.nameText = name
        self.groupText = group
    }
    
    @IBAction func addPersonTapped() {
        //addPairAlert()
    }
    
    
    func addPairAlert() {
        let alertController = UIAlertController(title: "Add Person", message: "Anyone...", preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler { (nameTextField) in
            nameTextField.placeholder = "Name..."
        }
        
        alertController.addTextFieldWithConfigurationHandler { (groupTextField) in
            groupTextField.placeholder = "Group..."
        }
        let addAction = UIAlertAction(title: "Add", style: .Default) { (_) in
            guard let textFields = alertController.textFields,
                pairNameTextFieldText = textFields.first!.text else { return }
            let pairGroupTextFieldText = textFields[2].text
            
            PairController.sharedInstance.addPerson(pairNameTextFieldText, group: pairGroupTextFieldText!)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func editPairAlert() {
        let alertController = UIAlertController(title: "Edit Task", message: "Edit your task's details", preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler { (nameTextField) in
            nameTextField.text = self.nameText
        }
      
        alertController.addTextFieldWithConfigurationHandler { (groupTextField) in
            groupTextField.text = self.groupText
        }
        let saveAction = UIAlertAction(title: "Save", style: .Default) { (_) in
            guard let textFields = alertController.textFields,
                pairNameTextFieldText = textFields.first!.text else { return }
            let pairGroupTextFieldText = textFields[2].text
            self.nameText = pairNameTextFieldText
            self.groupText = pairGroupTextFieldText
            PairController.sharedInstance.updatePair(self.pair!, name: pairNameTextFieldText, group: pairGroupTextFieldText!)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        presentViewController(alertController, animated: true, completion: nil)
        updateWithPair()
    }
    
    // MARK: NSFetchedResultsControllerDelegate
    
    func controllerWithChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()  }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
        case .Insert:
            guard let indexPath = newIndexPath else { return }
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Right)
        case .Move:
            guard let indexPath = indexPath,
                newIndexPath = newIndexPath else { return }
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Right)
        case .Update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
        }
    }
    
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .Delete:
            tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Left)
        case .Insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Right)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
}




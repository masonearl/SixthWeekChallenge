//
//  PairTableViewCell.swift
//  SixWeekTechnicalChallenge
//
//  Created by Mason Earl on 7/8/16.
//  Copyright © 2016 trianglez. All rights reserved.
//

import UIKit

class PairTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    var delegate: PairTableViewCellDelegate?
    
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    // MARK: Cell Functions
    
    @IBAction func buttonTapped(sender: AnyObject) {
        delegate?.cellTapped(self)
        
    }
    
    func randomizeButton() {
        
    }
    
    
}

extension PairTableViewCell {
    
    func updateWithPair(pair: Pair) {
        self.primaryLabel.text = pair.name
        
    }
}

protocol PairTableViewCellDelegate {
    
    func cellTapped(sender: PairTableViewCell)
}

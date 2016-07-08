//
//  DateHelper.swift
//  SixWeekTechnicalChallenge
//
//  Created by Mason Earl on 7/8/16.
//  Copyright © 2016 trianglez. All rights reserved.
//

import Foundation

extension NSDate {
    
    func stringValue() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .ShortStyle
        return dateFormatter.stringFromDate(self)
    }
}

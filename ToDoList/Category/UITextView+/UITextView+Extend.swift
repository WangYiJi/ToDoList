//
//  UITextView+Extend.swift
//  ToDoList
//
//  Created by Alex on 26/03/2018.
//  Copyright © 2018 company. All rights reserved.
//

import Foundation

extension UITextView {
    
    func addMiddleLine() -> Void {
        let middleLine = NSMutableAttributedString.init(string: self.text!)
        
        middleLine.addAttribute(NSStrikethroughStyleAttributeName, value: NSNumber.init(value: 1), range: NSRange(location: 0, length: middleLine.length))
        
        self.attributedText = middleLine
    }
    
    func removeMiddleLine() -> Void {
        let textAtt = NSMutableAttributedString.init(string: self.text!)
        
        self.attributedText = textAtt;
    }
    
    
}

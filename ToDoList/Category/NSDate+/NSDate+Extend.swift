//
//  NSDate+Extend.swift
//  ToDoList
//
//  Created by Alex on 15/03/2018.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit
import Foundation


extension NSDate {
    func toString(forMatter:String) -> String {
        let df = DateFormatter();
        df.dateFormat = forMatter;
        
        let sDate = df.string(from: self as Date);
        return sDate;
    }
}

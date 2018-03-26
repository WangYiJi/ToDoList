//
//  Date+Extend.swift
//  ToDoList
//
//  Created by Alex on 22/03/2018.
//  Copyright © 2018 company. All rights reserved.
//

import Foundation


extension Date {
    //get Zero AM
    func getBeginDate() -> Date {
        let calendar:Calendar = Calendar.current;
        let com = calendar.dateComponents([.year,.month,.day], from: self);
        let dateZeroAM = calendar.date(from: com);
        return dateZeroAM!;
    }
    
    func getTomorrow() -> Date {
        let calendar:Calendar = Calendar.current
        let dateTomorrow = calendar.date(byAdding: .day, value: 1, to: self);
        return dateTomorrow!;
    }
}

//
//  NSString+Extend.swift
//  ToDoList
//
//  Created by Alex on 26/03/2018.
//  Copyright © 2018 company. All rights reserved.
//

import Foundation


extension NSString {
    
    func getHeightByWightAndFont(fWight:CGFloat,font:UIFont) -> CGFloat {
        let rect = CGRect(origin: .zero,size:CGSize(width:fWight ,height:CGFloat.greatestFiniteMagnitude));
        let finalRect = self.boundingRect(with: rect.size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName:font], context: nil);
        return finalRect.size.height;
    }
}

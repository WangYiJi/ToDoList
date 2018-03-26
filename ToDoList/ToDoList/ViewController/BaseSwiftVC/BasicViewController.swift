//
//  BasicViewController.swift
//  ToDoList
//
//  Created by Alex on 26/03/2018.
//  Copyright © 2018 company. All rights reserved.
//

import Foundation

class BasicViewController: UIViewController {
    
    //first
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init() {
        
        let nibNameOrNil = String(describing: type(of: self))
        
        //考虑到xib文件可能不存在或被删，故加入判断
        if Bundle.main.path(forResource: nibNameOrNil, ofType: "nib") == nil {
            self.init(nibName: nil, bundle: nil)
        } else {
            self.init(nibName: nibNameOrNil, bundle: nil)
        }
    }
}

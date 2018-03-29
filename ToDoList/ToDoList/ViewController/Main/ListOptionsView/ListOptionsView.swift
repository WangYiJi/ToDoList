//
//  ListOptionsView.swift
//  ToDoList
//
//  Created by Alex on 29/03/2018.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit

class ListOptionsView: UIView,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var mainTableView: UITableView!
    
    @IBOutlet weak var renameCell: UITableViewCell!
    @IBOutlet weak var editCell: UITableViewCell!
    @IBOutlet weak var sortCell: UITableViewCell!
    @IBOutlet weak var changeIcon: UITableViewCell!
    @IBOutlet weak var hideCompleteCell: UITableViewCell!
    @IBOutlet weak var deletecell: UITableViewCell!
    
    @IBOutlet var view: UIView!
    
    //加载xib
    func initViewFromNib() -> Void {
        
        let className = type(of: self)
        let bundle = Bundle(for: className)
        let name = NSStringFromClass(className).components(separatedBy: ".").last
        let nib = UINib(nibName: name!, bundle: bundle)
        self.view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        self.view.frame = bounds
        self.addSubview(view)
    }

    
    //初始化时将xib中的view添加进来
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewFromNib()
    }
    
    convenience init () {
        self.init(frame: CGRect.zero)
    }
    
    //初始化时将xib中的view添加进来
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViewFromNib()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return self.renameCell;
            
        case 1:
            return self.editCell;
            
        case 2:
            return self.sortCell;
            
        case 3:
            return self.changeIcon;
            
        case 4:
            return self.hideCompleteCell;
            
        case 5:
            return self.deletecell;
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        case 5:
            
            break;
        default:
            
            break;
        }
    }
    
    @IBAction func didPressedDone(_ sender: Any) {
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

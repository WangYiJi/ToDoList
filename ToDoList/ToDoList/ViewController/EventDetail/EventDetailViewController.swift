//
//  EventDetailViewController.swift
//  ToDoList
//
//  Created by Alex on 16/03/2018.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var mainTableview: UITableView!
    
    @IBOutlet var cellAlerm: UITableViewCell!
    @IBOutlet weak var lblAlermMe: UILabel!
    
    @IBOutlet var cellMark: UITableViewCell!
    @IBOutlet weak var lblMark: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Tableview delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            return self.cellAlerm;
        }
        else if (indexPath.row == 1) {
            return self.cellMark;
        }
        return UITableViewCell();
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            
        }
        else if (indexPath.row == 1) {
            
        }
    }
    
    func presentMarkNote() -> Void {
        let markNoteVC:MarkNoteViewController = MarkNoteViewController(nibName:"MarkNoteViewController", bundle:nil);
        self.present(markNoteVC, animated: true, completion: nil);
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  EventDetailViewController.swift
//  ToDoList
//
//  Created by Alex on 16/03/2018.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit
import AudioToolbox
import CoreData

let FINISHIMAGENAME = "iconFinishGreen"
let UNFINISHIMAGENAME = "iconFinishGray"

class EventDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var mainTableview: UITableView!
    
    @IBOutlet var cellEventName: UITableViewCell!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var btnFinishEvent: UIButton!
    
    @IBOutlet var cellAlerm: UITableViewCell!
    @IBOutlet weak var lblAlermMe: UILabel!
    
    @IBOutlet var cellDate: UITableViewCell!
    @IBOutlet weak var lblData: UILabel!
    
    @IBOutlet var cellCalendar: UITableViewCell!
    @IBOutlet weak var calendarView: DAYCalendarView!
    
    
    @IBOutlet var cellTime: UITableViewCell!
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet var cellTimePicker: UITableViewCell!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    @IBOutlet var cellMark: UITableViewCell!
    @IBOutlet weak var lblMark: UILabel!
    
    @IBOutlet var cellDelete: UITableViewCell!
    @IBOutlet weak var lblCreateTime: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    
    var bFinish:Bool = false;
    var bAlertMode:Bool = false;
    var bShowCalendar:Bool = false;
    var bShowDatePicker:Bool = false;
    
    var event:Event?
    
    
    
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
        return 8;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return cellEventName;
        case 1:
            return cellAlerm;
        case 2:
            return cellDate;
        case 3:
            return cellCalendar;
        case 4:
            return cellTime;
        case 5:
            return cellTimePicker;
        case 6:
            return cellMark;
        case 7:
            return cellDelete;
            
        default:
            return UITableViewCell();
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 44;
        case 1:
            return 44;
        case 2:
            if (self.bAlertMode) {
                return 44;
            } else {
                return 0;
            }
        case 3:
            if (self.bShowCalendar) {
                return 260;
            } else {
                return 0;
            }
        case 4:
            if (self.bAlertMode) {
                return 44;
            } else {
                return 0;
            }
        case 5:
            if (self.bShowDatePicker) {
                return 216;
            } else {
                return 0;
            }
        case 6:
            return 216;
        case 7:
            return 44;
            
        default:
            return 44;
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            break;
        case 1:
            break;
        case 2:
            self.bShowCalendar = !self.bShowCalendar;
            let indexPathArray: [IndexPath] = [IndexPath(row:3,section:0)]
            tableView.reloadRows(at: indexPathArray, with: .none);
            //tableView.reloadData();
            break;
        case 3:
            
            break;
        case 4:
            self.bShowDatePicker = !self.bShowDatePicker;
            let indexPathArray: [IndexPath] = [IndexPath(row:5,section:0)]
            tableView.reloadRows(at: indexPathArray, with: .none);
            break;
        case 5:
            break;
        case 6:
            break;
        case 7:
            break;
            
        default:
            break;
        }
    }
    
    func presentMarkNote() -> Void {
        let markNoteVC:MarkNoteViewController = MarkNoteViewController(nibName:"MarkNoteViewController", bundle:nil);
        self.present(markNoteVC, animated: true, completion: nil);
    }
    
    
    // MARK: - IBAction
    
    @IBAction func didPressedFinish(_ sender:Any){
        self.bFinish = !self.bFinish;
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        let sImageName = self.bFinish ? FINISHIMAGENAME:UNFINISHIMAGENAME
        self.btnFinishEvent.setImage(UIImage(named:sImageName), for: .normal);
    }
    
    @IBAction func didPressedDelete(_ sender: Any) {
        UIAlertController.alertInstanceWithTitle(sTitle: "Are you sure delete this event?",
                                                 sMessage: "",
                                                 confrim: "YES",
                                                 cancel: "NO",
                                                 vc: self,
                                                 okSel: {
                                                    //delete
                                                }, cancelSel: {
                                                    //nothing to do
                                                });
    }
    
    
    
    @IBAction func datePickerChange(_ sender: Any) {
        
    }
    
    @IBAction func didAlertChange(_ sender: Any) {
        self.bAlertMode = !self.bAlertMode;
        self.mainTableview.reloadData();
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

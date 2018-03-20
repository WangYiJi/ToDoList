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

typealias deleteEventBlock = (Event) -> ()

class EventDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var mainTableview: UITableView!
    
    @IBOutlet var cellEventName: UITableViewCell!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var eventNameLaycontent: NSLayoutConstraint!
    @IBOutlet weak var btnFinishEvent: UIButton!
    
    @IBOutlet var cellAlerm: UITableViewCell!
    @IBOutlet weak var lblAlermMe: UILabel!
    @IBOutlet weak var swiAlertMe: UISwitch!
    
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
    @IBOutlet weak var markLayconstantHeight: NSLayoutConstraint!
    
    @IBOutlet weak var lblCreateTime: UILabel!
    
    var bAlertMode:Bool = false;
    var bShowCalendar:Bool = false;
    var bShowDatePicker:Bool = false;
    
    var event:Event!
    
    var delBlock:deleteEventBlock!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDefaultData();
        // Do any additional setup after loading the view.
    }
    
    func loadDefaultData() -> Void {
        //isfinish
        self.btnFinishEvent.setImage(UIImage(named:self.event!.isFinish ? FINISHIMAGENAME:UNFINISHIMAGENAME), for: .normal);
        //title
        self.lblEventName.text = self.event!.title;
        
        //title frame
        let rect = CGRect(origin: .zero,size:CGSize(width:self.lblEventName.frame.size.width,height:CGFloat.greatestFiniteMagnitude));
        let finalRect = (self.event!.title! as NSString).boundingRect(with: rect.size, options: .usesLineFragmentOrigin, attributes: nil, context: nil);
        self.eventNameLaycontent.constant = finalRect.size.height;
        
        //note
        self.lblMark.text = self.event!.remark;
        let markRect = CGRect(origin: .zero,size:CGSize(width:self.lblMark.frame.size.width,height:CGFloat.greatestFiniteMagnitude));
        let lblMarkRect = (self.event.remark! as NSString).boundingRect(with: markRect.size, options: .usesLineFragmentOrigin, attributes: nil, context: nil);
        self.markLayconstantHeight.constant = lblMarkRect.size.height;
        
        //needAlerm
        self.swiAlertMe.setOn(self.event!.needAlerm ? true:false, animated: true);
        
        //createTime
        let dateFormatter = DateFormatter();
        
        // Aug 19, 2016
        dateFormatter.dateStyle = DateFormatter.Style.medium;
        self.lblCreateTime.text = "Created on " + dateFormatter.string(from: self.event!.createDate!);
        
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
        return 7;
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
            tableView.beginUpdates();
            tableView.endUpdates();
            //let indexPathArray: [IndexPath] = [IndexPath(row:3,section:0)]
            //tableView.reloadRows(at: indexPathArray, with: .none);
            break;
        case 3:
            
            break;
        case 4:
            self.bShowDatePicker = !self.bShowDatePicker;
            tableView.beginUpdates();
            tableView.endUpdates();
            //let indexPathArray: [IndexPath] = [IndexPath(row:5,section:0)]
            //tableView.reloadRows(at: indexPathArray, with: .none);
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
        
        self.event!.isFinish = !self.event!.isFinish;
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        let sImageName = self.event!.isFinish ? FINISHIMAGENAME:UNFINISHIMAGENAME
        self.btnFinishEvent.setImage(UIImage(named:sImageName), for: .normal);
    }
    
    @IBAction func didPressedDelete(_ sender: Any) {
        UIAlertController.alertInstanceWithTitle(sTitle: "Are you sure want to delete this event forever?",
                                                 sMessage: "",
                                                 confrim: "Delete",
                                                 cancel: "Cancel",
                                                 vc: self,
                                                 okSel: { [weak self] in
                                                    //delete
                                                    self!.delBlock(self!.event);
                                                    self?.navigationController?.popViewController(animated: true);
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

}

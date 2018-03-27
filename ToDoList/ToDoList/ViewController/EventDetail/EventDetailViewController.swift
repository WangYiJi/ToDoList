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

//Event name label width
let DEF_EVENT_NAME_WIDTH = SWIFT_SCREEN_WIDTH - 50 - 15
//Event note label width
let DEF_EVENT_NOTE_WIDTH = SWIFT_SCREEN_WIDTH - 20

typealias deleteEventBlock = (Event) -> ()

class EventDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate {

    @IBOutlet weak var mainTableview: UITableView!
    
    @IBOutlet var cellEventName: UITableViewCell!
    @IBOutlet weak var txtEventName: UITextView!
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
    var fNameHeightBefore:CGFloat = 0.0;
    
    
    var dateFormatter:DateFormatter!
    var timeFormatter:DateFormatter!
    
    var event:Event!
    
    var delBlock:deleteEventBlock!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createBaseView();
        loadDefaultData();
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DBhelper.save()
    }
    
    func createBaseView() ->Void {
        self.title = "Detail";
        let rightBar:UIBarButtonItem = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(EventDetailViewController.didPressedDone(_:)));
        self.navigationItem.rightBarButtonItem = rightBar;
        
        self.calendarView.addTarget(self, action: #selector(EventDetailViewController.calendarDidSelect(_:)), for: .valueChanged);
        
        self.dateFormatter = DateFormatter();
        self.dateFormatter.dateFormat = "MM dd,yyyy";
        
        self.timeFormatter = DateFormatter();
        self.timeFormatter.dateFormat = "HH:mm";
        
        //Minus textView top space
        self.txtEventName.textContainerInset = UIEdgeInsets.zero;
        self.txtEventName.textContainer.lineFragmentPadding = 0;
    }
    
    func loadDefaultData() -> Void {
        //isfinish & title
        eventFinishDisplay(isFinish: self.event.isFinish)
        
        //note
        if self.event.note != nil {
            self.lblMark.text = self.event!.note;

            self.markLayconstantHeight.constant = getNoteHeight();
        } else {
            self.lblMark.text = "Add a note";
        }
        
        self.lblCreateTime.text = "Created on " + self.dateFormatter.string(from: self.event!.createDate!);
        
        //Alerm display
        if self.event.needAlerm {
            self.swiAlertMe.setOn(true, animated: true);
            self.bAlertMode = true;
            self.lblData.text = self.dateFormatter.string(from: self.event.alermDate!);
            self.lblTime.text = self.timeFormatter.string(from: self.event.alermTime!);
            self.calendarView.selectedDate = self.event.alermDate;
        } else {
            self.swiAlertMe.setOn(false, animated: false);
            self.bAlertMode = false;
        }
    }
    
    @objc func calendarDidSelect(_ sender:Any) -> Void {
        let selectDate:Date = self.calendarView.selectedDate;
        
        self.lblData.text = self.dateFormatter.string(from: selectDate);
        
        self.event.alermDate = selectDate
    }
    
    @objc func didPressedDone(_ sender:Any) -> Void {
        self.navigationController?.popViewController(animated: true);
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
            return getEventNameHeight()+20;
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
            break;
        case 3:
            
            break;
        case 4:
            self.bShowDatePicker = !self.bShowDatePicker;
            tableView.beginUpdates();
            tableView.endUpdates();
            break;
        case 5:
            break;
        case 6:
            pushToNoteVC()
            break;
        case 7:
            break;
            
        default:
            break;
        }
    }
    
    
    // MARK: - Custom func
    // Finish icon display
    func eventFinishDisplay(isFinish:Bool) -> Void {
        self.btnFinishEvent.setImage(UIImage(named:isFinish ? FINISHIMAGENAME:UNFINISHIMAGENAME), for: .normal);
        
        self.txtEventName.text = self.event!.title;
        
        eventNameLabelDisplay(isFinish: isFinish);
    }
    
    // Event name label display
    func eventNameLabelDisplay(isFinish:Bool) -> Void {
        if isFinish {
            self.txtEventName.addMiddleLine()
            self.txtEventName.textColor = SWIFT_GRAY_COLOR
        } else {
            self.txtEventName.removeMiddleLine()
            self.txtEventName.textColor = SWIFT_BLACK_COLOR
        }
    }
    
    func pushToNoteVC() -> Void {
        
        let noteVC:MarkNoteViewController = MarkNoteViewController(nibName:nil,bundle:nil)
        noteVC.event = self.event
        noteVC.noteEditDoneBlock = {[weak self](noteEvent:Event) -> () in
            self?.event = noteEvent
            self?.lblMark.text = self?.event.note
        }
        self.navigationController?.pushViewController(noteVC, animated: true);
    }
    
    func initTempAlertDate() -> Void {
        if self.event.alermDate == nil && self.event.alermTime == nil {
            //Get tommorrow date & time
            let tempAlertDate:Date = Date().getTomorrow()
        
            //today zero AM
            self.lblData.text = self.dateFormatter.string(from: tempAlertDate);
            self.calendarView.selectedDate = tempAlertDate;
            self.event.alermDate = self.calendarView.selectedDate;
            //after 1 hour
            self.lblTime.text = self.timeFormatter.string(from: tempAlertDate);
            self.datePicker.setDate(tempAlertDate, animated: false);
            self.event.alermTime = self.datePicker.date;
        }
    }
    
    func getEventNameHeight() -> CGFloat {
        let fHeight:CGFloat = (self.event.title! as NSString).getHeightByWightAndFont(fWight: DEF_EVENT_NAME_WIDTH, font: UIFont.systemFont(ofSize: 17))
        return fHeight;
    }
    
    func getNoteHeight() -> CGFloat {
        let fHeight:CGFloat = (self.event.note! as NSString).getHeightByWightAndFont(fWight: DEF_EVENT_NOTE_WIDTH, font: UIFont.systemFont(ofSize: 17));
        return fHeight;
    }
    
    
    // MARK: - UITextView
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            //space
            textView.resignFirstResponder()
            self.event.title = textView.text
            DBhelper.save()
            
            return false;
        } else if text == "" {
            //back
            if textView.text.count > 1 {
                //Mesure event name lenght
                let index = textView.text.index(textView.text.startIndex, offsetBy: textView.text.count - 1)
                let sTempName:String = textView.text.substring(to: index)
                let fHeight:CGFloat = (sTempName as NSString).getHeightByWightAndFont(fWight: DEF_EVENT_NAME_WIDTH, font: UIFont.systemFont(ofSize: 17))
                
                self.event.title = sTempName
                if fHeight < self.fNameHeightBefore {
                    //Need shrink
                    self.mainTableview.beginUpdates()
                    self.mainTableview.endUpdates()
                    self.fNameHeightBefore = fHeight
                }
            }
            return true;
        } else {
            let sTitle:String = textView.text + text
            self.event.title = sTitle;
            let fHeight:CGFloat = (sTitle as NSString).getHeightByWightAndFont(fWight: DEF_EVENT_NAME_WIDTH, font: UIFont.systemFont(ofSize: 17));
            
            if fHeight > self.fNameHeightBefore {
                //Need spread
                self.mainTableview.beginUpdates()
                self.mainTableview.endUpdates()
                self.fNameHeightBefore = fHeight
            }
            eventNameLabelDisplay(isFinish: self.event.isFinish)
            return true;
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        let fHeight:CGFloat = (self.event.title! as NSString).getHeightByWightAndFont(fWight: DEF_EVENT_NAME_WIDTH, font: UIFont.systemFont(ofSize: 17));
        self.fNameHeightBefore = fHeight;
    }

    // MARK: - IBAction
    @IBAction func didPressedFinish(_ sender:Any){
        self.event!.isFinish = !self.event!.isFinish;
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        
        eventFinishDisplay(isFinish: self.event.isFinish)
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
        let tempData:Date = self.datePicker.date;
        self.lblTime.text = self.timeFormatter.string(from: tempData)
        self.event.alermTime = tempData
    }
    
    @IBAction func didAlertChange(_ sender: Any) {
        self.bAlertMode = !self.bAlertMode;
        
        if self.bAlertMode {
            initTempAlertDate();
        } else {
            self.bShowCalendar = self.bAlertMode
            self.bShowDatePicker = self.bAlertMode
        }
        self.event.needAlerm = self.bAlertMode
        self.mainTableview.reloadData();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

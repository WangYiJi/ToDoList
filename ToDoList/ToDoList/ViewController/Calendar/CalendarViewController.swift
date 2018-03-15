//
//  CalendarViewController.swift
//  ToDoList
//
//  Created by Alex on 14/03/2018.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var calendarView: DAYCalendarView!
    
    var eventArray:NSMutableArray!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.calendarView.addTarget(self, action: #selector(CalendarViewController.calendarViewDidChange), for: UIControlEvents.valueChanged);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calendarViewDidChange() -> Void {
        //let data = self.calendarView.selectedDate;
        
        //print("%@",data ?? <#default value#>);
    }
    
    // MARK: - TableviewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainEventCell", for: indexPath) as UITableViewCell;
        return cell;
    }

}

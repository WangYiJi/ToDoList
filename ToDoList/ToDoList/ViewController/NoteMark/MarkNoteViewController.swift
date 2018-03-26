//
//  MarkNoteViewController.swift
//  ToDoList
//
//  Created by Alex on 16/03/2018.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit

typealias noteEditDone = (Event) -> ()

class MarkNoteViewController: BasicViewController,UITextViewDelegate {

    @IBOutlet weak var txtNote: UITextView!
    var event:Event!
    var noteEditDoneBlock:noteEditDone!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createBaseView()
        // Do any additional setup after loading the view.
    }
    
    func createBaseView() -> Void {
        self.title = "Note";
        let leftBar:UIBarButtonItem = UIBarButtonItem.init(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(didPressedCancel));
        let rightBar:UIBarButtonItem = UIBarButtonItem.init(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(didPressdeDone));
        self.navigationItem.leftBarButtonItem = leftBar;
        self.navigationItem.rightBarButtonItem = rightBar;
        
        self.txtNote.text = self.event.note
        
        self.txtNote.becomeFirstResponder();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didPressedCancel() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    func didPressdeDone() -> Void {
        self.event.note = self.txtNote.text
        DBhelper.save()
        if self.noteEditDoneBlock != nil {
            self.noteEditDoneBlock(self.event)
        }
        self.navigationController?.popViewController(animated: true)
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

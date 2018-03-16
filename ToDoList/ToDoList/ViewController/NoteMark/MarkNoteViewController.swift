//
//  MarkNoteViewController.swift
//  ToDoList
//
//  Created by Alex on 16/03/2018.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit

class MarkNoteViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var txtNote: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func createBaseView() -> Void {
        self.title = "Note";
        let leftBar:UIBarButtonItem = UIBarButtonItem.init(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(didPressedCancel));
        let rightBar:UIBarButtonItem = UIBarButtonItem.init(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(didPressdeDone));
        self.navigationItem.leftBarButtonItem = leftBar;
        self.navigationItem.rightBarButtonItem = rightBar;
        
        self.txtNote.becomeFirstResponder();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didPressedCancel() -> Void {
        self.dismiss(animated: true, completion: nil);
    }
    
    func didPressdeDone() -> Void {
        self.dismiss(animated: true, completion: nil);
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

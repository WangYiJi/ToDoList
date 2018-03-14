//
//  UIAlertController+swift.swift
//  Province
//
//  Created by Alex on 07/11/2017.
//  Copyright © 2017 company. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    //视图中添加简易alert
    public static func alertSimpleMsg(sTitle:String,vc:UIViewController) -> () {
        let alert = UIAlertController(title:sTitle, message:nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("确定", comment: "Default action"), style: .`default`, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        vc.present(alert, animated: true, completion: nil)
    }
    
    //视图中添加定制alert
    public static func alertInstanceWithTitle(sTitle:String,sMessage:String?,confrim:String?,cancel:String?,vc:UIViewController,okSel: @escaping ()->Void,cancelSel: @escaping ()->Void) -> () {
        
        let alert = UIAlertController(title:sTitle,message:sMessage,preferredStyle:.alert);

        //确定
        if (confrim != nil) {
            let okAction = UIAlertAction(title:confrim, style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
                okSel();
            }
            alert.addAction(okAction);
        }
        
        //取消
        if(cancel != nil) {
            let cancelAction = UIAlertAction(title:cancel, style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
                cancelSel();
            }
            alert.addAction(cancelAction)
        }
        
        vc.present(alert, animated: true) {
            //完成
        }
    }
    
    //视图中添加ActionSheet
    public static func alertActionSheet(sTitle:String?,sMessage:String?,vc:UIViewController,actions:Array<String>,click:@escaping (_ clickIndex:Int) -> ()) -> () {
        let sheet = UIAlertController(title:sTitle,message:sMessage,preferredStyle:.actionSheet);
        for i in 0..<actions.count {
            let item = actions[i];
            let action = UIAlertAction(title:item, style: .`default`, handler: { _ in
                click(i);
            });
            sheet.addAction(action);
        }
        vc.present(sheet, animated: true) {
            
        };
    }
    
    public static func loadData(success : @escaping(_ : [String]) -> ()) -> () {
        let json = ["新闻", "图片", "热点"]
        success(json)
    }

    //测试
    public static func testAlert(v:UIViewController) -> (){
        UIAlertController.alertActionSheet(sTitle: "1", sMessage: "2", vc: v, actions: ["111","222","333"]) { (index) in
            print(index);
        }
    }
}

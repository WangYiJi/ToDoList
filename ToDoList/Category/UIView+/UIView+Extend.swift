//
//  UIView+Extend.swift
//  ToDoList
//
//  Created by Alex on 30/03/2018.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit

extension UIView {
    func addBackMaskView() -> Void {
        //let selBack:Selector = Selector(("didPressedMaskBack:"))
        let maskView:UIControl = UIControl.init(frame: CGRect.init(x: 0, y: 0, width: SWIFT_SCREEN_WIDTH, height: SWIFT_SCREEN_HEIGHT));
        
        maskView.backgroundColor = UIColor.black;
        maskView.alpha = 0;

        maskView.addTarget(self, action: #selector(self.didPressedMaskBack()), for: .touchDown);
        addSubview(maskView);
        //设置动画效果，动画时间长度 1 秒。
        UIView.animate(withDuration: 0.3, delay:0.01, options:[.curveEaseInOut],
                       animations: {
                        ()-> Void in
        },
                       completion:{
                        (finished:Bool) -> Void in
                        UIView.animate(withDuration: 1, animations:{
                            ()-> Void in
                            maskView.alpha = 0.3
                        })
        })
    }
    
    @objc func didPressedMaskBack() ->Void {
        print("ahaha")
    }


//    @objc func didPressedMaskBack(selfview:UIControl) ->Void {
//        selfview.removeFromSuperview()
//    }
}

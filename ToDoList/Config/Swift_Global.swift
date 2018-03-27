//
//  Swift_Global.swift
//  ToDoList
//
//  Created by Alex on 27/03/2018.
//  Copyright © 2018 company. All rights reserved.
//

let FINISHIMAGENAME = "iconFinishGreen"
let UNFINISHIMAGENAME = "iconFinishGray"
let sDateFormatter = "MM dd yyyy"

func RGBColor(r :CGFloat ,g:CGFloat,b:CGFloat) -> UIColor{
    return UIColor.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
}

let SWIFT_GRAY_COLOR  =  RGBColor(r: 23.0, g: 146.0, b: 137.0)
let SWIFT_BLACK_COLOR =  RGBColor(r: 0.0, g: 0.0, b: 0.0)

// 屏幕的宽
let SWIFT_SCREEN_WIDTH = UIScreen.main.bounds.size.width

// 屏幕的高
let SWIFT_SCREEN_HEIGHT = UIScreen.main.bounds.size.height


//
//  CalendarViewController.h
//  ToDoList
//
//  Created by Alex on 13/03/2018.
//  Copyright © 2018 company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAYCalendarView.h"

@interface CalendarViewController : UIViewController

@property (nonatomic,weak) IBOutlet DAYCalendarView *calendarView;
@property (nonatomic,weak) IBOutlet UIDatePicker *datePicker;

@end

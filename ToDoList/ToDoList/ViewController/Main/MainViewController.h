//
//  MainViewController.h
//  ToDoList
//
//  Created by Alex on 13/03/2018.
//  Copyright © 2018 company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event+CoreDataClass.h"
#import "EventList+CoreDataClass.h"
#import "ToDoList-Swift.h"

//typedef void(^deleteEventBlock)(Event *delEvent);

@interface MainViewController : UIViewController

@property (nonatomic,strong) IBOutlet UIButton *btnCalendar;

@property (nonatomic,weak) IBOutlet UITableView *mainTableview;
@property (nonatomic,weak) IBOutlet UIImageView *imgAdd;
@property (nonatomic,weak) IBOutlet UIView *buttonView;
@property (nonatomic,weak) IBOutlet UITextField *txtEventTitle;

@property (nonatomic,weak) IBOutlet UILabel *lblAddEventTopic;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttomSpan;

@property (strong,nonatomic) IBOutlet UIControl *optionsContentView;
@property (weak,nonatomic) IBOutlet ListOptionsView *optionsView;

@property (nonatomic,strong) EventList *currentEventList;

-(IBAction)didPressedCalendar:(id)sender;

@end


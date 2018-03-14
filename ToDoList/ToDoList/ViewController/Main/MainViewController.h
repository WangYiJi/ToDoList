//
//  MainViewController.h
//  ToDoList
//
//  Created by Alex on 13/03/2018.
//  Copyright © 2018 company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController 
@property (nonatomic,weak) IBOutlet UITableView *mainTableview;
@property (nonatomic,weak) IBOutlet UIImageView *imgAdd;
@property (nonatomic,weak) IBOutlet UIView *buttonView;
@property (nonatomic,weak) IBOutlet UITextField *txtEventTitle;
@property (nonatomic,weak) IBOutlet UILabel *lblAddEventTopic;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttomSpan;

-(IBAction)didPressedDone:(id)sender;

@end

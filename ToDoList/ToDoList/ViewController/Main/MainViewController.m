//
//  MainViewController.m
//  ToDoList
//
//  Created by Alex on 13/03/2018.
//  Copyright © 2018 company. All rights reserved.
//

#import "MainViewController.h"
#import "MainCellAdapt.h"
#import "DBhelper.h"
#import "MainEventCell.h"
#import "Event+CoreDataClass.h"
#import "UITableView+Extend.h"
#import "CalendarViewController.h"

static NSString * const MainEventCellIdentifier = @"MainEventCellIdentifier";

@interface MainViewController () <UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray *sourceArray;
@property (nonatomic,strong) MainCellAdapt *cellAdapt;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBaseView];
    [self loadDefaultData];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)createBaseView
{
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pushToCalendarViewController)];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    [self initKeyBoardEvent];
}

-(void)pushToCalendarViewController
{
    CalendarViewController *calednarVC = [[CalendarViewController alloc] initWithNibName:@"CalendarViewController"
                                                                                  bundle:nil];
    [self.navigationController pushViewController:calednarVC animated:YES];
}

-(void)loadDefaultData
{
    self.sourceArray = [DBhelper searchBy:@"Event"];
    
    self.cellAdapt = [[MainCellAdapt alloc] initWithDataSource:self.sourceArray
                                                              identifier:MainEventCellIdentifier
                                                             cellDisplay:^(MainEventCell *cell, Event *item) {
                                                                 cell.lblName.text = item.title;
                                                             } viewController:self];
    self.mainTableview.dataSource = self.cellAdapt;

    [self.mainTableview registerNib:[MainEventCell nib] forCellReuseIdentifier:MainEventCellIdentifier];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)addEvent:(NSString*)sEventTitle
{
    Event *e = [DBhelper insertWithEntity:@"Event"];
    e.title = sEventTitle;
    [DBhelper Save];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)didPressedDone:(id)sender
{
    [sender resignFirstResponder];
}

-(void)initKeyBoardEvent
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

}

-(void)removeKeyboardEvent
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyBoardWillShow:(NSNotification *)aNotification
{
//走多次可解决
//    CGFloat keyBoardHeight = 0.0;
//    CGRect begin = [[[aNotification userInfo] objectForKey:@"UIKeyboardFrameBeginUserInfoKey"] CGRectValue];
//    CGRect end = [[[aNotification userInfo] objectForKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];

//    // 第三方键盘回调三次问题，监听仅执行最后一次
//    if(begin.size.height>0 && (begin.origin.y-end.origin.y>0)){
//        keyBoardHeight = fBoardHeight;
//
//    }
    CGFloat fBoardHeight = [[[aNotification userInfo] objectForKey:@"UIKeyboardBoundsUserInfoKey"] CGRectValue].size.height;

    
    [UIView animateWithDuration:0.3f animations:^{
        self.buttomSpan.constant = fBoardHeight;
    }];
    [self.view layoutIfNeeded];
}

-(void)keyBoardWillHide:(NSNotification *)aNotification
{
    [UIView animateWithDuration:0.3f animations:^{
        self.buttomSpan.constant = 0;
    }];
    [self.view layoutIfNeeded];
}

-(void)keyBoardWillChangeFrame:(NSNotification *)aNotification
{
    
}




@end

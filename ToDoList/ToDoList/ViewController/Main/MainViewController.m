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
#import "MenuView.h"
#import "LeftMenuViewDemo.h"
#import "ToDoList-Swift.h"
#import "Global.h"
#import <UIKit/NSIndexPath+UIKitAdditions.h>

static NSString * const MainEventCellIdentifier = @"MainEventCellIdentifier";

@interface MainViewController () <UITableViewDelegate,HomeMenuViewDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong) MainCellAdapt *cellAdapt;
@property (nonatomic,strong) MenuView *menu;
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
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(showLeftMenu)];
    self.navigationItem.leftBarButtonItem = leftBar;
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:self.btnCalendar];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    //mainview gestureRecognizer
    UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    touch.delegate = self;
    [self.mainTableview addGestureRecognizer:touch];
    
    [self initKeyBoardEvent];
    [self initLeftMenu];
}

#pragma mark-手势代理，解决和tableview点击发生的冲突
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {//判断如果点击的是tableView的cell，就把手势给关闭了
        return NO;//关闭手势
    }//否则手势存在
    return YES;
}

-(IBAction)didPressedCalendar:(id)sender
{
    CalendarViewController *calednarVC = [[CalendarViewController alloc] initWithNibName:@"CalendarViewController"
                                                                                  bundle:nil];
    [self.navigationController pushViewController:calednarVC animated:YES];
}

-(void)loadDefaultData
{
    NSMutableArray *sourceArray = [DBhelper searchBy:@"Event"];
    
    __weak typeof(self) weakSelf = self;
    cellDelete deleteBlock = ^(NSInteger iIndex){
        [weakSelf deleteEvent:iIndex];
    };
    
    cellDisplay displayBlock = ^(MainEventCell *cell,Event *item){
        cell.lblName.text = item.title;
    };
    
    self.cellAdapt = [[MainCellAdapt alloc] initWithDataSource:sourceArray
                                                    identifier:MainEventCellIdentifier
                                                   cellDisplay:displayBlock
                                                    cellDelete:deleteBlock
                                                viewController:self];
    
    self.mainTableview.dataSource = self.cellAdapt;
    self.mainTableview.delegate = self;

    [self.mainTableview registerNib:[MainEventCell nib] forCellReuseIdentifier:MainEventCellIdentifier];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Event *tempEvent = [self.cellAdapt.dataResource objectAtIndex:indexPath.row];
    EventDetailViewController *eventDetailVC = [[EventDetailViewController alloc] initWithNibName:@"EventDetailViewController" bundle:nil];
    eventDetailVC.event = tempEvent;
    [self.navigationController pushViewController:eventDetailVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(void)addEvent:(NSString*)sEventTitle
{
    Event *e = [DBhelper insertWithEntity:@"Event"];
    e.title = sEventTitle;
    e.createDate = [NSDate date];
    [DBhelper Save];
    
    [self.cellAdapt addEvent:e];
}

-(void)deleteEvent:(NSInteger)iIndex
{
    Event *e = [self.cellAdapt.dataResource objectAtIndex:iIndex];
    
    [DBhelper deleteBy:e];
    
    [self.cellAdapt.dataResource removeObject:e];
    
}

-(IBAction)didPressedDone:(id)sender
{

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.txtEventTitle.text.length > 0) {
        [self addEvent:self.txtEventTitle.text];
        self.txtEventTitle.text = @"";
        [self fadeInTableview];
        return NO;
    } else {
        [textField resignFirstResponder];
        return YES;
    }
}

//touch background to hide keyboard
- (void)keyboardHide {
    // 发送resignFirstResponder.
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

-(void)fadeInTableview {
    [self.mainTableview beginUpdates];
    NSArray *insertArray = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.cellAdapt.dataResource.count - 1 inSection:0]];
    [self.mainTableview insertRowsAtIndexPaths:insertArray withRowAnimation:UITableViewRowAnimationBottom];
    [self.mainTableview endUpdates];
}

#pragma mark - Menu
-(void)initLeftMenu
{
    LeftMenuViewDemo *demo = [[LeftMenuViewDemo alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.8, SCREEN_HEIGHT)];
    demo.customDelegate = self;
    
    MenuView *menu = [MenuView MenuViewWithDependencyView:self.view MenuView:demo isShowCoverView:YES];
    self.menu = menu;
}

-(void)LeftMenuViewClick:(NSInteger)tag
{
    [self.menu hidenWithAnimation];
    NSLog(@"%ld",tag);
}

-(void)showLeftMenu
{
    [self.menu show];
}

#pragma mark - Keyboard event
-(void)initKeyBoardEvent
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)removeKeyboardEvent
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyBoardWillShow:(NSNotification *)aNotification
{
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

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


-(void)refreshButtomStyle:(BOOL)bInput;

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
    //Go to Calendar
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(showLeftMenu)];
    self.navigationItem.leftBarButtonItem = leftBar;
    
    //[self.btnCalendar setFrame:CGRectMake(0, 0, 30, 30)];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:self.btnCalendar];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    //add mainview gestureRecognizer
    UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    touch.delegate = self;
    [self.mainTableview addGestureRecognizer:touch];
     
    //init buttom textfield & label
    [self refreshButtomStyle:NO];
    UITapGestureRecognizer *lblTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addTextFieldBecomeResponder)];
    [self.lblAddEventTopic addGestureRecognizer:lblTouch];
    
    UITapGestureRecognizer *imgTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addTextFieldBecomeResponder)];
    [self.imgAdd addGestureRecognizer:imgTouch];
    
    [self initKeyBoardEvent];
    [self initLeftMenu];    
}

-(void)swipeAction:(UISwipeGestureRecognizer*)swipe
{
    [self.txtEventTitle resignFirstResponder];
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
    cellDelete deleteBlock = ^(NSIndexPath *delIndexPath){
        [weakSelf deleteEvent:delIndexPath.row];
    };
    
    //Main Cell Display
    cellDisplay displayBlock = ^(MainEventCell *cell,NSInteger index){
        Event *event = [weakSelf.cellAdapt.dataResource objectAtIndex:index];
        cell.lblName.text = event.title;
        
        //mark isFinish
        if (event.isFinish) {
            [cell.lblName addMiddleLine];
            cell.lblName.textColor = RGBA(100, 100, 100, 1);
            [cell.btnFinish setImage:[UIImage imageNamed:@"iconFinishGreen"] forState:UIControlStateNormal];
        } else {
            [cell.lblName removeMiddleLine];
            cell.lblName.textColor = [UIColor blackColor];
            [cell.btnFinish setImage:[UIImage imageNamed:@"iconFinishGray"] forState:UIControlStateNormal];
        }
        
        cell.btnFinish.tag = index;
        [cell.btnFinish addTarget:weakSelf action:@selector(didPressedFinish:) forControlEvents:UIControlEventTouchUpInside];
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

-(void)didPressedFinish:(UIButton*)sender
{
    Event *event = [self.cellAdapt.dataResource objectAtIndex:sender.tag];
    if (event.isFinish) {
        event.isFinish = NO;
    } else {
        event.isFinish = YES;
    }
    [DBhelper Save];
    
    [self.mainTableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - tableview Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    Event *tempEvent = [self.cellAdapt.dataResource objectAtIndex:indexPath.row];
    EventDetailViewController *eventDetailVC = [[EventDetailViewController alloc] initWithNibName:@"EventDetailViewController" bundle:nil];
    eventDetailVC.event = tempEvent;
    eventDetailVC.delBlock = ^(Event * _Nonnull delEvent) {
        [weakSelf deleteEvent:[self.cellAdapt.dataResource indexOfObject:delEvent]];
    };
    [self.navigationController pushViewController:eventDetailVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Event *event = [self.cellAdapt.dataResource objectAtIndex:indexPath.row];
    CGFloat fHeight = [event.title getHeightByWightAndFontWithFWight:SCREEN_WIDTH-60-15 font:[UIFont systemFontOfSize:18]];
    return fHeight+20;
}

-(void)fadeInTableview {
    [self.mainTableview beginUpdates];
    NSArray *insertArray = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.cellAdapt.dataResource.count - 1 inSection:0]];
    [self.mainTableview insertRowsAtIndexPaths:insertArray withRowAnimation:UITableViewRowAnimationBottom];
    [self.mainTableview endUpdates];
}

#pragma mark - Textfield func

-(void)addTextFieldBecomeResponder
{
    [self refreshButtomStyle:YES];
    [self.txtEventTitle becomeFirstResponder];
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
        [self refreshButtomStyle:NO];
        return YES;
    }
}

-(void)refreshButtomStyle:(BOOL)bInput
{
    self.lblAddEventTopic.hidden = bInput;
    self.txtEventTitle.hidden = !bInput;
}

#pragma mark - CoreData func
-(void)addEvent:(NSString*)sEventTitle
{
    Event *e = [DBhelper insertWithEntity:@"Event"];
    e.title = sEventTitle;
    e.createDate = [NSDate date];
    e.isDelete = NO;
    e.isFinish = NO;
    e.needAlerm = NO;
    
    [DBhelper Save];
    
    [self.cellAdapt addEvent:e];
}

-(void)deleteEvent:(NSInteger)delIndex
{
    Event *event = [self.cellAdapt.dataResource objectAtIndex:delIndex];
    [self.cellAdapt.dataResource removeObject:event];
    [self.mainTableview beginUpdates];
    [self.mainTableview deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:delIndex inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
    [self.mainTableview endUpdates];
    [DBhelper deleteBy:event];
}

#pragma mark - Menu func
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
//Use Gesture to solve the conflict between tableviewcell & keyboard hide
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([gestureRecognizer isKindOfClass:[UISwipeGestureRecognizer class]]) {
        return YES;
    } else if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {//touch cell
            return NO;//Close gesture
        } else {
            return YES;//Open gesture
        }
    } else {
        return YES;
    }
}

//touch background to hide keyboard
- (void)keyboardHide {
    // Send resignFirstResponder.
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

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

    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3f animations:^{
        weakSelf.buttomSpan.constant = fBoardHeight;
    }];
    [self.view layoutIfNeeded];
    [self refreshButtomStyle:YES];
}

-(void)keyBoardWillHide:(NSNotification *)aNotification
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3f animations:^{
        weakSelf.buttomSpan.constant = 0;
    }];
    [self.view layoutIfNeeded];
    [self refreshButtomStyle:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

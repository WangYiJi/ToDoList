//
//  MainOfMenuViewController.m
//  ToDoList
//
//  Created by Alex on 28/03/2018.
//  Copyright © 2018 company. All rights reserved.
//

#import "MainOfMenuViewController.h"

#import "LeftMenuTVC.h"
#import "RightMenuTVC.h"
#import "ToDoList-Swift.h"
#import "LeftMenuTableViewController.h"

@interface MainOfMenuViewController ()

@end

@implementation MainOfMenuViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    /*******************************
     *     Initializing menus
     *******************************/
    self.leftMenu = [[LeftMenuTVC alloc] initWithNibName:@"LeftMenuTVC" bundle:nil];
    //self.leftMenu = [[LeftMenuTableViewController alloc] initWithNibName:@"LeftMenuTableViewController" bundle:nil];
    self.rightMenu = [[RightMenuTVC alloc] initWithNibName:@"RightMenuTVC" bundle:nil];
    /*******************************
     *     End Initializing menus
     *******************************/
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Overriding methods
- (void)configureLeftMenuButton:(UIButton *)button
{
    CGRect frame = button.frame;
    frame.origin = (CGPoint){0,0};
    frame.size = (CGSize){40,40};
    button.frame = frame;
    
    [button setImage:[UIImage imageNamed:@"switch"] forState:UIControlStateNormal];
}

- (void)configureRightMenuButton:(UIButton *)button
{
    CGRect frame = button.frame;
    frame.origin = (CGPoint){0,0};
    frame.size = (CGSize){40,40};
    button.frame = frame;
    
    [button setImage:[UIImage imageNamed:@"switch"] forState:UIControlStateNormal];
}

- (BOOL)deepnessForLeftMenu
{
    return YES;
}

- (CGFloat)maxDarknessWhileRightMenu
{
    return 0.5f;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

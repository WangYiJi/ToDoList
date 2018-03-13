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
}

-(void)pushToCalendarViewController
{
    CalendarViewController *calednarVC = [[CalendarViewController alloc] initWithNibName:@"CalendarViewController"
                                                                                  bundle:nil];
    [self.navigationController pushViewController:calednarVC animated:YES];
}

-(void)initDataSource
{
    NSMutableArray *sourceArray = [DBhelper searchBy:@"Event"];
    if (sourceArray.count <= 0) {
        for (int i = 0; i<6; i++) {
            NSString *sTitle = [NSString stringWithFormat:@"Event %d",i];
            Event *e = [DBhelper insertWithEntity:@"Event"];
            e.title = sTitle;
        }
        [DBhelper Save];
    }
}

-(void)loadDefaultData
{
    [self initDataSource];
    self.sourceArray = [DBhelper searchBy:@"Event"];
    
    self.cellAdapt = [[MainCellAdapt alloc] initWithDataSource:self.sourceArray
                                                              identifier:MainEventCellIdentifier
                                                             cellDisplay:^(MainEventCell *cell, Event *item) {
                                                                 cell.lblName.text = item.title;
                                                             }];
    self.mainTableview.dataSource = self.cellAdapt;

    [self.mainTableview registerNib:[MainEventCell nib] forCellReuseIdentifier:MainEventCellIdentifier];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

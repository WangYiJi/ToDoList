//
//  LeftMenuTVC.m
//  testProject
//
//  Created by artur on 2/14/14.
//  Copyright (c) 2014 artur. All rights reserved.
//

#import "LeftMenuTVC.h"
#import "SecondVC.h"
#import "ThirdVC.h"
#import "MainViewController.h"
#import "DBhelper.h"
#import "EventList+CoreDataClass.h"

@interface LeftMenuTVC ()

@end

@implementation LeftMenuTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Initilizing data souce
    self.tableData = [DBhelper searchBy:@"EventList"];
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
}

#pragma mark - TableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventList *listItem = [self.tableData objectAtIndex:indexPath.row];
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = listItem.listName;
    
    return cell;
}
#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
#warning waitfor push
    UINavigationController *nvc;
    UIViewController *rootVC;
    switch (indexPath.row) {
        case 0:
        {
            //Main
            rootVC = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
        }
            break;
        case 1:
        {
            rootVC = [[SecondVC alloc] initWithNibName:@"SecondVC" bundle:nil];
        }
            break;
        case 2:
        {
            rootVC = [[ThirdVC alloc] initWithNibName:@"ThirdVC" bundle:nil];
        }
            break;

        default:
            break;
    }
    nvc = [[UINavigationController alloc] initWithRootViewController:rootVC];
    
    [self openContentNavigationController:nvc];
}

@end

//
//  MainCellAdapt.m
//  ToDoList
//
//  Created by Alex on 13/03/2018.
//  Copyright © 2018 company. All rights reserved.
//

#import "MainCellAdapt.h"
#import "UITableView+Extend.h"
#import "ToDoList-Swift.h"
#import "Global.h"

@interface MainCellAdapt ()

@end

@implementation MainCellAdapt

-(instancetype)initWithDataSource:(NSMutableArray*)source
                       identifier:(NSString*)sIdentifier
                      cellDisplay:(cellDisplay)displayBlock
                       cellDelete:(cellDelete)deleteBlock
                   viewController:(id)viewController

{
    self = [super init];
    if (self) {
        self.sIdentifier = sIdentifier;
        self.dataResource = [[NSMutableArray alloc] initWithArray:source];
        self.cellDisplayBlock = [displayBlock copy];
        self.cellDeleteBlock = [deleteBlock copy];
        self.vc = viewController;
    }
    return self;
}

-(void)addEvent:(Event*)event
{
    [self.dataResource addObject:event];
}

-(void)deleteEvent:(Event *)event
{
    [self.dataResource removeObject:event];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataResource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainEventCell *cell = (MainEventCell*)[tableView customdq:self.sIdentifier];
    Event *item = [self.dataResource objectAtIndex:indexPath.row];
    
    [cell autoresizingNameLabel:[item.title getHeightByWightAndFontWithFWight:SCREEN_WIDTH - 60 - 15 font:[UIFont systemFontOfSize:18]]];
    
    if (self.cellDisplayBlock) {
        self.cellDisplayBlock(cell, indexPath.row);
    }
    return cell;
}

#pragma mark - Edit

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//return YES show editing mode
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//Delete action
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView setEditing:NO animated:YES];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //insure delete
        __weak typeof(self) weakSelf = self;
        [UIAlertController alertInstanceWithTitleWithSTitle:@"Delete?" sMessage:@""
                                                    confrim:@"OK" cancel:@"Cancel"
                                                         vc:self.vc okSel:^{
                                                             if (weakSelf.cellDeleteBlock) {
                                                                 weakSelf.cellDeleteBlock(indexPath);
                                                             }
                                                         } cancelSel:^{
                                                             
                                                         }];
    }
}




@end

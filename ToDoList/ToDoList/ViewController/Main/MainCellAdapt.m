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

@interface MainCellAdapt ()
@property (nonatomic,copy) NSString *sIdentifier;
@property (nonatomic,copy) NSMutableArray *dataResource;
@property (nonatomic,copy) cellDisplay cellDisplayBlock;
@property (nonatomic,weak) id vc;
@end

@implementation MainCellAdapt

-(instancetype)initWithDataSource:(NSMutableArray*)source
                       identifier:(NSString*)sIdentifier
                      cellDisplay:(cellDisplay)displayBlock
                   viewController:(id)viewController

{
    self = [super init];
    if (self) {
        self.sIdentifier = sIdentifier;
        self.dataResource = [[NSMutableArray alloc] initWithArray:source];
        self.cellDisplayBlock = [displayBlock copy];
        self.vc = viewController;
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataResource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainEventCell *cell = (MainEventCell*)[tableView customdq:@"MainEventCell"];
    id item = [self.dataResource objectAtIndex:indexPath.row];
    if (self.cellDisplayBlock) {
        self.cellDisplayBlock(cell, item);
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
        [UIAlertController alertInstanceWithTitleWithSTitle:@"Delete?" sMessage:@""
                                                    confrim:@"OK" cancel:@"Cancel"
                                                         vc:self.vc okSel:^{
                                                             
                                                         } cancelSel:^{
                                                             
                                                         }];
    }
}




@end

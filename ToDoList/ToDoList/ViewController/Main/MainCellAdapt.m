//
//  MainCellAdapt.m
//  ToDoList
//
//  Created by Alex on 13/03/2018.
//  Copyright © 2018 company. All rights reserved.
//

#import "MainCellAdapt.h"
#import "UITableView+Extend.h"

@interface MainCellAdapt ()
@property (nonatomic,copy) NSString *sIdentifier;
@property (nonatomic,copy) NSMutableArray *dataResource;
@property (nonatomic,copy) cellDisplay cellDisplayBlock;
@end

@implementation MainCellAdapt

-(instancetype)initWithDataSource:(NSMutableArray*)source
                       identifier:(NSString*)sIdentifier
                      cellDisplay:(cellDisplay)displayBlock
{
    self = [super init];
    if (self) {
        self.sIdentifier = sIdentifier;
        self.dataResource = [[NSMutableArray alloc] initWithArray:source];
        self.cellDisplayBlock = [displayBlock copy];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end

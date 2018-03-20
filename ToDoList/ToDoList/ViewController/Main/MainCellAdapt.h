//
//  MainCellAdapt.h
//  ToDoList
//
//  Created by Alex on 13/03/2018.
//  Copyright © 2018 company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MainEventCell.h"
#import "Event+CoreDataClass.h"

typedef void (^cellDisplay)(MainEventCell *cell,Event *item);
typedef void (^cellDelete)(NSInteger iIndex);

@interface MainCellAdapt : NSObject <UITableViewDataSource>

@property (nonatomic,copy) NSString *sIdentifier;
@property (nonatomic,strong) NSMutableArray *dataResource;
@property (nonatomic,copy) cellDisplay cellDisplayBlock;
@property (nonatomic,copy) cellDelete cellDeleteBlock;
@property (nonatomic,weak) id vc;

-(instancetype)initWithDataSource:(NSMutableArray*)source
                       identifier:(NSString*)sIdentifier
                      cellDisplay:(cellDisplay)displayBlock
                       cellDelete:(cellDelete)deleteBlock
                   viewController:(id)viewController;

-(void)addEvent:(Event*)event;
-(void)deleteEvent:(Event*)event;

@end

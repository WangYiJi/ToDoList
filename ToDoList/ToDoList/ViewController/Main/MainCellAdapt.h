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

@interface MainCellAdapt : NSObject <UITableViewDataSource,UITableViewDelegate>

-(instancetype)initWithDataSource:(NSMutableArray*)source
                       identifier:(NSString*)sIdentifier
                      cellDisplay:(cellDisplay)displayBlock;

@end

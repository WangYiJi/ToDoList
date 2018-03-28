//
//  NSMutableArray+Extend.h
//  ToDoList
//
//  Created by Alex on 28/03/2018.
//  Copyright © 2018 company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Extend)

-(NSMutableArray*)sortWithKey:(NSString*)sKeyName isAsc:(BOOL)bIsAsc;

@end

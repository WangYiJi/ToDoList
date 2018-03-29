//
//  NSMutableArray+Extend.m
//  ToDoList
//
//  Created by Alex on 28/03/2018.
//  Copyright © 2018 company. All rights reserved.
//

#import "NSMutableArray+Extend.h"

@implementation NSMutableArray (Extend)

-(NSMutableArray*)sortWithKey:(NSString*)sKeyName isAsc:(BOOL)bIsAsc
{
    NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:@"displayName" ascending:YES];
    NSArray *sortArray = [NSArray arrayWithObject:sd];
    NSMutableArray *result = [[NSMutableArray alloc] initWithArray:[self sortedArrayUsingDescriptors:sortArray]];
    return result;
}

@end

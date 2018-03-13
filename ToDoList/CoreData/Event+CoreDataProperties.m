//
//  Event+CoreDataProperties.m
//  
//
//  Created by Alex on 13/03/2018.
//
//

#import "Event+CoreDataProperties.h"

@implementation Event (CoreDataProperties)

+ (NSFetchRequest<Event *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Event"];
}

@dynamic createTime;
@dynamic isDelete;
@dynamic isFinish;
@dynamic title;

@end

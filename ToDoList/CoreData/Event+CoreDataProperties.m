//
//  Event+CoreDataProperties.m
//  
//
//  Created by Alex on 26/03/2018.
//
//

#import "Event+CoreDataProperties.h"

@implementation Event (CoreDataProperties)

+ (NSFetchRequest<Event *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Event"];
}

@dynamic createDate;
@dynamic alermDate;
@dynamic isDelete;
@dynamic isFinish;
@dynamic needAlerm;
@dynamic priorityLevel;
@dynamic note;
@dynamic title;
@dynamic alermTime;
@dynamic listship;

@end

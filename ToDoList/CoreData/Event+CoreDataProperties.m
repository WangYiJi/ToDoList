//
//  Event+CoreDataProperties.m
//  
//
//  Created by Alex on 15/03/2018.
//
//

#import "Event+CoreDataProperties.h"

@implementation Event (CoreDataProperties)

+ (NSFetchRequest<Event *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Event"];
}

@dynamic createDate;
@dynamic endDate;
@dynamic isDelete;
@dynamic isFinish;
@dynamic needAlerm;
@dynamic priorityLevel;
@dynamic remark;
@dynamic title;
@dynamic listship;

@end

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

@dynamic createTime;
@dynamic isDelete;
@dynamic isFinish;
@dynamic title;
@dynamic createDate;
@dynamic priorityLevel;
@dynamic needAlerm;
@dynamic remark;
@dynamic listship;

@end

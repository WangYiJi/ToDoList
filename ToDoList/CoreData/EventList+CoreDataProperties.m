//
//  EventList+CoreDataProperties.m
//  
//
//  Created by Alex on 15/03/2018.
//
//

#import "EventList+CoreDataProperties.h"

@implementation EventList (CoreDataProperties)

+ (NSFetchRequest<EventList *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"EventList"];
}

@dynamic isEnable;
@dynamic listName;
@dynamic markIcon;
@dynamic eventShip;

@end

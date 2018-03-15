//
//  EventList+CoreDataProperties.h
//  
//
//  Created by Alex on 15/03/2018.
//
//

#import "EventList+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface EventList (CoreDataProperties)

+ (NSFetchRequest<EventList *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *listName;
@property (nonatomic) BOOL isEnable;
@property (nullable, nonatomic, copy) NSString *markIcon;
@property (nullable, nonatomic, retain) NSSet<Event *> *eventShip;

@end

@interface EventList (CoreDataGeneratedAccessors)

- (void)addEventShipObject:(Event *)value;
- (void)removeEventShipObject:(Event *)value;
- (void)addEventShip:(NSSet<Event *> *)values;
- (void)removeEventShip:(NSSet<Event *> *)values;

@end

NS_ASSUME_NONNULL_END

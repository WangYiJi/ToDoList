//
//  Event+CoreDataProperties.h
//  
//
//  Created by Alex on 15/03/2018.
//
//

#import "Event+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Event (CoreDataProperties)

+ (NSFetchRequest<Event *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *createDate;
@property (nullable, nonatomic, copy) NSDate *endDate;
@property (nonatomic) BOOL isDelete;
@property (nonatomic) BOOL isFinish;
@property (nonatomic) BOOL needAlerm;
@property (nonatomic) int32_t priorityLevel;
@property (nullable, nonatomic, copy) NSString *remark;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, retain) EventList *listship;

@end

NS_ASSUME_NONNULL_END

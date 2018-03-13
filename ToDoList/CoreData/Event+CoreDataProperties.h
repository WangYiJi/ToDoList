//
//  Event+CoreDataProperties.h
//  
//
//  Created by Alex on 13/03/2018.
//
//

#import "Event+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Event (CoreDataProperties)

+ (NSFetchRequest<Event *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *createTime;
@property (nonatomic) BOOL isDelete;
@property (nonatomic) BOOL isFinish;
@property (nullable, nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END

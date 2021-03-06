//
//  AppDelegate.h
//  ToDoList
//
//  Created by Alex on 12/03/2018.
//  Copyright © 2018 company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (NSManagedObjectContext*)managedObjectContext;
- (NSManagedObjectModel*)managedObjectModel;
- (void)saveContext;


@end


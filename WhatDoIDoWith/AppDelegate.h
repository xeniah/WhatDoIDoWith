//
//  AppDelegate.h
//  WhatDoIDoWith
//
//  Created by XeniaH on 11/2/14.
//  Copyright (c) 2014 xeniah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#define WDIDCATEGORY_TYPE   @"WDIDCategory"
#define WDIDPROVIDER_TYPE   @"WDIDProvider"

@class WDIDCategory;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (id)fetch:(NSString *)type orCreate:(BOOL)create withEntityId:(NSString *)entityId;
- (void)remove:(NSManagedObject *)entity;

- (NSArray *)fetchMultiple:(NSString *)type withPredicate:(NSPredicate *)pred sort:(NSSortDescriptor *)sort;


@end


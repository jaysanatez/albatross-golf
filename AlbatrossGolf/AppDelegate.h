//
//  AppDelegate.h
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 11/26/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "User.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, strong) User *activeUser;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *baseUrl;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (User *)getActiveUser;
- (void)setActiveUser:(User *)activeUser;
- (void)removeActiveUser;

- (NSString *)getToken;
- (void)setToken:(NSString *)token;

@end


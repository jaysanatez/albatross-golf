//
//  UserDAO.m
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/26/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import <CoreData/CoreData.h>
#import "UserDAO.h"
#import "User.h"
#import "AppDelegate.h"

@implementation UserDAO

- (User *)createUser:(User *)newUser
{
    newUser.id_num = 2;
    return newUser;
}

- (BOOL)attemptLoginWithUsername:(NSString *)username AndPassword:(NSString *)password
{
    return YES;
}

- (void)fetchAndStoreUserAsActiveUser:(NSString *)username
{
    User *jay = [[User alloc] init];
    
    jay.email = @"jay@sanatez.com";
    jay.id_num = 2;
    jay.username = @"Sanatez";
    jay.password = @"password";
    
    [self storeUserAsActiveUser:jay];
}

- (void)storeUserAsActiveUser:(User *)user
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    // store in CoreData
    NSManagedObjectContext *ctx = [delegate managedObjectContext];
    NSManagedObject *userObj = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:ctx];
    NSError *error;
    
    [userObj setValue:[NSNumber numberWithLong:user.id_num] forKey:@"id"];
    [userObj setValue:user.username forKey:@"name"];
    [userObj setValue:user.email forKey:@"email"];
    [userObj setValue:user.password forKey:@"password"];
    [ctx save:&error];
    
    if(error)
    {
        NSLog(@"ERROR");
    }
    else
    {
        user.cdObject = userObj;
    }
    
    [delegate setActiveUser:user];
}

@end

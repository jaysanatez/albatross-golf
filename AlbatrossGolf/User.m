//
//  User.m
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/18/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import "User.h"
#import <CoreData/CoreData.h>

@implementation User

+ (instancetype) instanceFromManagedObject:(NSManagedObject *)object
{
    User *user = [[User alloc] init];
    
    user.id_num = [[object valueForKey:@"id"] longValue];
    user.userName = (NSString *)[object valueForKey:@"username"];
    user.firstName = (NSString *)[object valueForKey:@"fname"];
    user.lastName = (NSString *)[object valueForKey:@"lname"];
    user.email = (NSString *)[object valueForKey:@"email"];
    user.password = (NSString *)[object valueForKey:@"password"];
    user.cdObject = object;
    
    return user;
}

+ (instancetype) instanceFromDictionary:(NSDictionary *)dict
{
    User *user = [[User alloc] init];
    
    user.id_num = [[dict valueForKey:@"id"] longValue];
    user.userName = (NSString *)[dict valueForKey:@"username"];
    user.firstName = (NSString *)[dict valueForKey:@"first_name"];
    user.lastName = (NSString *)[dict valueForKey:@"last_name"];
    user.email = (NSString *)[dict valueForKey:@"email"];
    
    return user;
}

@end

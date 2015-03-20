//
//  USe.m
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
    user.username = (NSString *)[object valueForKey:@"name"];
    user.email = (NSString *)[object valueForKey:@"email"];
    user.password = (NSString *)[object valueForKey:@"password"];
    user.cdObject = object;
    
    return user;
}

@end

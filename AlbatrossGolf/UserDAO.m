//
//  UserDAO.m
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/26/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import "UserDAO.h"
#import "User.h"
#import "AppDelegate.h"

@implementation UserDAO

- (BOOL)attemptLoginWithUsername:(NSString *)username AndPassword:(NSString *)password
{
    return YES;
}

- (void)storeUserAsActiveUer:(NSString *)username
{
    User *jay = [[User alloc] init];
    
    jay.email = @"jay@sanatez.com";
    jay.id_num = 2;
    jay.username = @"Jay Sanatez";
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate setActiveUser:jay];
}

@end

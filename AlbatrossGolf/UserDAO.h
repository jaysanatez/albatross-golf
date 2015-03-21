//
//  UserDAO.h
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/26/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserDAO : NSObject

- (User *)createUser:(User *)newUser;
- (void)fetchAndStoreUserAsActiveUser:(NSString *)username;
- (void)storeUserAsActiveUser:(User *)user;
- (BOOL)attemptLoginWithUsername:(NSString *)username AndPassword:(NSString *)password;

@end

//
//  UserDAO.h
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/26/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import <Foundation/Foundation.h>

@interface UserDAO : NSObject

- (void)storeUserAsActiveUer:(NSString *)username;
- (BOOL)attemptLoginWithUsername:(NSString *)username AndPassword:(NSString *)password;

@end

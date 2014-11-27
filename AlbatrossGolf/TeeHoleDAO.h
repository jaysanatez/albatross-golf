//
//  TeeHoleDAO.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 10/19/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeeHoleDAO : NSObject

- (void)fetchTeeHolesForTee:(NSNumber *)teeId withDelegate:(NSObject *)delegate;

@end

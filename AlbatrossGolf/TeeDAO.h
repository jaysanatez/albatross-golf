//
//  TeeDAO.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 10/19/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeeDAO : NSObject

- (void)fetchTeesForCourse:(NSNumber *)courseId withDelegate:(NSObject *)delegate;
- (void)fetchTeesForUser:(NSNumber *)userId withDelegate:(NSObject *)delegate;

@end

//
//  TeeDAO.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 10/19/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import <Foundation/Foundation.h>
#import "Tee.h"
#import "TeeHole.h"
#import "Hole.h"

@interface TeeDAO : NSObject

- (NSMutableArray *)fetchTeesForCourse:(long)courseId;
- (NSMutableArray *)fetchTeesForUser:(long)userId;
- (Tee *)fetchTeeWithTeeId:(long)teeId;

@end

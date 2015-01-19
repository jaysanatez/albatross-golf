//
//  TeeDAO.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 10/19/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import <Foundation/Foundation.h>

@protocol TeeFetchDelegate

- (void)refreshTeeList:(NSMutableArray *)tees;
- (void)alertNoTeesFetched;

@end

@interface TeeDAO : NSObject

@property (nonatomic, weak) id <TeeFetchDelegate> delegate;

- (void)fetchTeesForCourse:(long)courseId;
- (void)fetchTeesForUser:(long)userId;

@end

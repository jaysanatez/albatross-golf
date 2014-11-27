//
//  CourseDAO.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 9/3/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import "Course.h"
#import <Foundation/Foundation.h>

@interface CourseDAO : NSObject

- (void)fetchFirstPaginatedCourses:(NSObject *)delegate;
- (void)fetchNextPaginatedBatch:(NSObject *)delegate;
- (void)fetchPreviousPaginatedBatch:(NSObject *)delegate;
- (void)fetchCoursesSearchByKeyword:(NSObject *)delegate search:(NSString *)keyword;
- (void)fetchCoursesSearchByCity:(NSObject *)delegate search:(NSString *)city;
- (void)fetchCoursesSearchByState:(NSObject *)delegate search:(NSString *)state;

@end

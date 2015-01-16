//
//  CourseDAO.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 9/3/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import "Course.h"
#import <Foundation/Foundation.h>

@protocol CourseFetchDelegate

- (void)refreshCourseList:(NSMutableArray *)array;
- (void)alertNoCoursesFetched;

@optional

- (void)setPrevButton:(BOOL)prev andNext:(BOOL)next;

@end

@interface CourseDAO : NSObject

@property (nonatomic, weak) id <CourseFetchDelegate> delegate;

- (void)fetchFirstPaginatedCourses;
- (void)fetchNextPaginatedBatch;
- (void)fetchPreviousPaginatedBatch;
- (void)fetchCoursesSearchByKeyword:(NSString *)keyword;
- (void)fetchCoursesSearchByCity:(NSString *)city;
- (void)fetchCoursesSearchByState:(NSString *)state;

@end

//
//  CourseDAO.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 9/3/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import <Foundation/Foundation.h>
#import "Course.h"
#import "CourseChoiceVC.h"
#import "Delegates.h"

@interface CourseDAO : NSObject

@property (nonatomic, weak) id <CourseFetchDelegate> delegate;

- (void)fetchFirstPaginatedCourses;
- (void)fetchNextPaginatedBatch;
- (void)fetchPreviousPaginatedBatch;
- (void)fetchCoursesSearchByKeyword:(NSString *)keyword;
- (void)fetchCoursesSearchByCity:(NSString *)city;
- (void)fetchCoursesSearchByState:(NSString *)state;

@end

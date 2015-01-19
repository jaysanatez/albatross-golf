//
//  Tee.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 10/19/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import <Foundation/Foundation.h>

@interface Tee : NSObject

@property NSString *name, *course_name;
@property long slope, id_num, course_id;
@property double rating;
@property BOOL isMale;
@property NSMutableArray *tee_holes;

@end

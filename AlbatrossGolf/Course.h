//
//  Course.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/31/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import <Foundation/Foundation.h>

@interface Course : NSObject

// keep name -> zip, id_num
@property (nonatomic, strong) NSString *courseName, *courseLocation, *name, *address, *city, *state, *zip;
@property (nonatomic, strong) NSNumber *coursePar, *courseRating, *courseSlope, *id_num;
@property (nonatomic, strong) NSMutableArray *parSequence;

@end

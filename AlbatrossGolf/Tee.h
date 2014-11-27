//
//  Tee.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 10/19/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tee : NSObject

@property (nonatomic, strong) NSString *name, *course_name;
@property (nonatomic, strong) NSNumber *rating, *slope, *id_num, *course_id;
@property BOOL isMale;

@end

//
//  Course.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/31/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import <Foundation/Foundation.h>

@interface Course : NSObject

// keep name -> zip, id_num
@property NSString *name, *address, *city, *state, *zip;
@property long id_num;

@end

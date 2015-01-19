//
//  TeeHole.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 10/19/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import <Foundation/Foundation.h>
#import "Hole.h"

@interface TeeHole : NSObject

@property long id_num, yardage, par, handicap, hole_id, tee_id;
@property Hole *hole;

@end

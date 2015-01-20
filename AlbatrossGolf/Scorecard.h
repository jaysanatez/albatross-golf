//
//  Scorecard.h
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/18/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import <Foundation/Foundation.h>
#import "User.h"
#import "Course.h"
#import "Tee.h"
#import "TeeHole.h"
#import "Round.h"

@interface Scorecard : NSObject

@property User *user;
@property Course *course;
@property Tee *tee;
@property Round *round;

@end

//
//  Hole.h
//  SmartShot_2.1
//
//  Created by Jacob Sanchez on 6/7/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"

@interface Hole : NSObject

@property (nonatomic, strong) Game *game;
@property BOOL hitFairway,gir,fairBunk,greenBunk;
@property (nonatomic, strong) NSNumber *penalties, *putts, *holeNumber;

@end

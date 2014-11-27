//
//  Game.h
//  SmartShot
//
//  Created by Jacob Sanchez on 5/31/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Course.h"

@interface Game : NSObject

@property (nonatomic, strong) Course *coursePlayed;
@property (nonatomic, strong) NSDate *datePlayed;
@property (nonatomic, strong) NSMutableArray *holeScores;
@property BOOL completed;

-(NSString *)toString;

@end

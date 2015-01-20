//
//  HoleScore.h
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/16/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import <Foundation/Foundation.h>

@interface HoleScore : NSObject

@property long hole_number, hole_par, score;

- (long)getDifference;
- (NSString *)getScoreName;
- (NSString *)getScorecardSymbol;

@end

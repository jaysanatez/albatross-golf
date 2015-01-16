//
//  HoleScore.h
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/16/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import <Foundation/Foundation.h>

@interface HoleScore : NSObject

@property (nonatomic, strong) NSNumber *hole_number, *hole_par, *score;

- (int)getDifference;
- (NSString *)getScoreName;
- (NSString *)getScorecardSymbol;

@end

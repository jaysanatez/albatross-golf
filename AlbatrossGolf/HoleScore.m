//
//  HoleScore.m
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/16/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import "HoleScore.h"

@implementation HoleScore

@synthesize hole_par, score;

- (int)getDifference
{
    return score.integerValue - hole_par.integerValue;
}

- (NSString *)getScoreName
{
    switch ([self getDifference])
    {
        case -4:
            return @"Condor";
        case -3:
            return @"Albatross";
        case -2:
            return @"Eagle";
        case -1:
            return @"Birdie";
        case 0:
            return @"Par";
        case 1:
            return @"Bogey";
        case 2:
            return @"Double Bogey";
        default:
            return @"Double Bogey+";
    }
}

@end

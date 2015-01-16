//
//  RoundStats.m
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/16/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import "RoundStats.h"

@implementation RoundStats

@synthesize num_greens_hit, num_greens_possible, num_fairways_hit, num_fairways_possible, num_par_saves, num_par_saves_possible, num_sand_saves, num_sand_saves_possible;

- (NSString *)getGIRFrac
{
    return [NSString stringWithFormat:@"%@/%@", num_greens_hit, num_greens_possible];
}

- (NSString *)getGIRPerc
{
    double perc = [num_greens_hit doubleValue] / [num_greens_possible doubleValue] * 100;
    return [NSString stringWithFormat:@"%.2f%%",perc];
}

- (NSString *)getFairwayFrac
{
    return [NSString stringWithFormat:@"%@/%@", num_fairways_hit, num_fairways_possible];
}

- (NSString *)getFairwayPerc
{
    double perc = [num_fairways_hit doubleValue] / [num_fairways_possible doubleValue] * 100;
    return [NSString stringWithFormat:@"%.2f%%",perc];
}

- (NSString *)getParSaveFrac
{
    return [NSString stringWithFormat:@"%@/%@", num_par_saves, num_par_saves_possible];
}

- (NSString *)getParSavePerc
{
    double perc = [num_par_saves doubleValue] / [num_par_saves_possible doubleValue] * 100;
    return [NSString stringWithFormat:@"%.2f%%",perc];
}

- (NSString *)getSandSaveFrac
{
    return [NSString stringWithFormat:@"%@/%@", num_sand_saves, num_sand_saves_possible];
}

- (NSString *)getSandSavePerc
{
    double perc = [num_sand_saves doubleValue] / [num_sand_saves_possible doubleValue] * 100;
    return [NSString stringWithFormat:@"%.2f%%",perc];
}

@end

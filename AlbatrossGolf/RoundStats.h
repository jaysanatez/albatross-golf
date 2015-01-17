//
//  RoundStats.h
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/16/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import <Foundation/Foundation.h>

@interface RoundStats : NSObject

@property double par_3_avg, par_4_avg, par_5_avg;
@property long total_score, num_eagles, num_birdies, num_pars, num_bogeys, num_double_bogeys, num_doubles_plus, num_greens_hit, num_greens_possible, num_fairways_hit, num_fairways_possible, num_par_saves, num_par_saves_possible, num_sand_saves, num_sand_saves_possible, num_putts, num_penalty_strokes, num_one_putts, num_three_putts, num_bunkers_hit;

- (NSString *)getGIRFrac;
- (NSString *)getGIRPerc;
- (NSString *)getFairwayFrac;
- (NSString *)getFairwayPerc;
- (NSString *)getParSaveFrac;
- (NSString *)getParSavePerc;
- (NSString *)getSandSaveFrac;
- (NSString *)getSandSavePerc;

@end

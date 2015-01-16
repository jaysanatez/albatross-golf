//
//  Round.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 10/19/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import <Foundation/Foundation.h>
@class RoundStats;

@interface Round : NSObject

@property (nonatomic, strong) NSNumber *id_num, *tee_id, *user_id, *course_id;
@property (nonatomic, strong) NSDate *date_played;
@property (nonatomic, strong) NSString *course_name;
@property BOOL is_complete;
@property NSMutableArray *round_holes, *round_scores;
@property RoundStats *round_stats;

- (BOOL)frontNineIsCompleted;
- (BOOL)backNineIsComplete;
- (int)getFrontNineTotal;
- (int)getBackNineTotal;
- (int)getFrontNinePar;
- (int)getBackNinePar;

@end

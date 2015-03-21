//
//  RoundDAO.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 11/5/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import <Foundation/Foundation.h>
#import "RoundStats.h"
#import "RoundHole.h"
#import "Round.h"
#import "HoleScore.h"
#import "Protocols.h"

@interface RoundDAO : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, weak) id <RoundFetchDelegate> fetch_delegate;
@property (nonatomic, weak) id <RoundPostDelegate> post_delegate;

- (void)fetchAllRoundsForUser:(long)user_id;
- (void)fetchRoundHolesWithRound:(long)round_id;
- (void)fetchStatsForRound:(long)round_id;
- (void)fetchHoleScoresForRoundId:(long)round_id;

- (long)postRound:(Round *)round forUser:(long)user_id;
- (long)postRoundHole:(RoundHole *)round_hole forUser:(long)user_id;

- (void)updateRound:(Round *)round forUser:(long)user_id;
- (void)updateRoundHole:(RoundHole *)round_hole forUser:(long)user_id;

@end




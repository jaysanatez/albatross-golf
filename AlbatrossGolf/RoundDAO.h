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

@protocol RoundFetchDelegate

- (void)refreshRoundList:(NSMutableArray *)rounds;
- (void)roundHolesFetched:(NSMutableArray *)roundHoles forRoundId:(long)round_id;
- (void)roundStatsFetched:(RoundStats *)roundStats forRoundId:(long)round_id;
- (void)holeScoresFetched:(NSMutableArray *)holeScores forRoundId:(long)round_id;

@end

@interface RoundDAO : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, weak) id <RoundFetchDelegate> delegate;

- (void)fetchAllRoundsForUser:(long)user_id;
- (void)fetchRoundHolesWithRound:(long)round_id;
- (void)fetchStatsForRound:(long)round_id;
- (void)fetchHoleScoresForRoundId:(long)round_id;

- (void)postRound:(Round *)round forUser:(long)user_id;

@end




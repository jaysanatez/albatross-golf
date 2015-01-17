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
- (void)roundHolesFetched:(NSMutableArray *)roundHoles forRoundId:(NSNumber *)round_id;
- (void)roundStatsFetched:(RoundStats *)roundStats forRoundId:(NSNumber *)round_id;
- (void)holeScoresFetched:(NSMutableArray *)holeScores forRoundId:(NSNumber *)round_id;

@end

@interface RoundDAO : NSObject

@property (nonatomic, weak) id <RoundFetchDelegate> delegate;

- (void)fetchAllRoundsForUser:(NSNumber *)user_id;
- (void)fetchRoundHolesWithRound:(NSNumber *)round_id;
- (void)fetchStatsForRound:(NSNumber *)round_id;
- (void)fetchHoleScoresForRoundId:(NSNumber *)round_id;

@end




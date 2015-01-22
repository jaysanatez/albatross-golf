//
//  Delegates.h
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/20/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import "RoundHole.h"
#import "RoundStats.h"
#import "HoleScore.h"

@protocol CourseFetchDelegate

- (void)refreshCourseList:(NSMutableArray *)array;
- (void)alertNoCoursesFetched;

@optional

- (void)setPrevButton:(BOOL)prev andNext:(BOOL)next;

@end


@protocol RoundFetchDelegate

- (void)refreshRoundList:(NSMutableArray *)rounds;
- (void)roundHolesFetched:(NSMutableArray *)roundHoles forRoundId:(long)round_id;
- (void)roundStatsFetched:(RoundStats *)roundStats forRoundId:(long)round_id;
- (void)holeScoresFetched:(NSMutableArray *)holeScores forRoundId:(long)round_id;

@end


@protocol RoundPostDelegate

- (void)roundPostTimedOut;
- (void)roundPostThrewError:(NSError *)error;
- (void)roundPostSucceeded;
- (void)roundholePostSucceeded;

@end

@protocol RoundUpdateDelegate

- (void)updateRound:(Round *)round;

@end


@protocol RoundDataPostable

- (void)postRoundHole:(RoundHole *)roundHole;
- (void)postHoleScore:(HoleScore *)holeScore;

@end


@protocol HoleDataViewDelegate

- (void)finishedWithHole:(RoundHole *)rh;

@end
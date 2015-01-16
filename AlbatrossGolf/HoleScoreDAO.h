//
//  HoleScoreDAO.h
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/16/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import <Foundation/Foundation.h>

@protocol HoleScoreFetchDelegate

- (void)holeScoresFetched:(NSMutableArray *)holeScores forRoundId:(NSNumber *)round_id;

@end

@interface HoleScoreDAO : NSObject

@property (nonatomic, weak) id <HoleScoreFetchDelegate> delegate;

- (void)fetchHoleScoresForRoundId:(NSNumber *)round_id;

@end

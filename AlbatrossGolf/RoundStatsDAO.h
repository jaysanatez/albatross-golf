//
//  RoundStatsDAO.h
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/16/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RoundStats.h"

@protocol RoundStatsFetchDelegate

-(void)roundStatsForRound:(NSNumber *)roundId roundStats:(RoundStats *)roundStats;

@end

@interface RoundStatsDAO : NSObject

@property (nonatomic, weak) id <RoundStatsFetchDelegate> delegate;

-(void)fetchStatsForRound:(NSNumber *)round_id;

@end

//
//  RoundHoleDAO.h
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/14/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import <Foundation/Foundation.h>

@protocol RoundHoleFetchDelegate

- (void)roundHolesForRound:(NSMutableArray *)roundHoles roundId:(NSNumber *)roundId;

@end

@interface RoundHoleDAO : NSObject

@property (nonatomic, weak) id <RoundHoleFetchDelegate> delegate;

- (void)fetchRoundHolesWithRound:(NSNumber *)round_id;

@end

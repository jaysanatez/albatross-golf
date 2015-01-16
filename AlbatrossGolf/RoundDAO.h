//
//  RoundDAO.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 11/5/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import <Foundation/Foundation.h>

@protocol RoundFetchDelegate

-(void)refreshRoundList:(NSMutableArray *)rounds;

@end

@interface RoundDAO : NSObject

@property (nonatomic, weak) id <RoundFetchDelegate> delegate;

- (void)fetchAllRoundsForUser:(NSNumber *)user_id;

@end

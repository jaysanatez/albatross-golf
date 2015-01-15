//
//  TeeHoleDAO.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 10/19/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import <Foundation/Foundation.h>

@protocol TeeHoleFetchDelegate

- (void)refreshTeeHoles:(NSMutableArray *)teeHoles;

@end

@interface TeeHoleDAO : NSObject

@property (nonatomic, weak) id <TeeHoleFetchDelegate> delegate;

- (void)fetchTeeHolesForTee:(NSNumber *)teeId;

@end

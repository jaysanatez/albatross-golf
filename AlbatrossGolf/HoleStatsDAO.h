//
//  HoleStatsDAO.h
//  SmartShot_2.1
//
//  Created by Jacob Sanchez on 9/3/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Game.h"
#import "Hole.h"

@interface HoleStatsDAO : NSObject

- (NSMutableArray *)getHoleStatsForGame:(Game *)game;
- (NSMutableArray *)getHoleStatsFromDBForGame:(Game *)game;
- (void)addHoleStats:(Hole *)hole forGame:(Game *)game;

@end

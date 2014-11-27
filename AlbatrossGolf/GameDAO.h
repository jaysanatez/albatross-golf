//
//  GameDAO.h
//  SmartShot_2.1
//
//  Created by Jacob Sanchez on 9/3/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"

@interface GameDAO : NSObject

- (NSMutableArray *)getAllGames;
- (NSMutableArray *)getCompletedGames;
- (NSMutableArray *)getGamesFromDB;
- (void)addGame:(Game *)game;

@end

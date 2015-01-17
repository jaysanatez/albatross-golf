//
//  RoundHole.h
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 11/27/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import <Foundation/Foundation.h>

@interface RoundHole : NSObject

@property BOOL hitFairway, hitGir, hitFairwayBunker, hitGreensideBunker;
@property long hole_id, round_id, putts, penalties, score, id_num;

@end

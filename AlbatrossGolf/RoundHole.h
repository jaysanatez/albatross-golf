//
//  RoundHole.h
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 11/27/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoundHole : NSObject

@property BOOL hitFairway, hitGir, hitFairwayBunker, hitGreensideBunker;
@property int round_id, hole_id, putts, penalties;

@end

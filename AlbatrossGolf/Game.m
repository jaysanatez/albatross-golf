//
//  Game.m
//  SmartShot
//
//  Created by Jacob Sanchez on 5/31/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import "Game.h"
#import "Course.h"

@implementation Game

@synthesize coursePlayed;
@synthesize datePlayed;

-(NSString *)toString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    return [NSString stringWithFormat:@"%@ - %@",coursePlayed.courseName,[formatter stringFromDate:datePlayed]];
}

@end

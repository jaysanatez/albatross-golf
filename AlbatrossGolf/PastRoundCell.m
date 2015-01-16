//
//  PastRoundCell.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/31/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import "PastRoundCell.h"
#import "RoundHole.h"

@implementation PastRoundCell

@synthesize courseName, datePlayed, totalScore, round;

- (void)reloadLabels
{
    courseName.text = round.course_name;
    courseName.adjustsFontSizeToFitWidth = YES;
    
    totalScore.text = round.is_complete ? [NSString stringWithFormat:@"%i",[self totalRoundScore]] : @"Unfinished";
    
    NSDateFormatter *newDateFormatter = [[NSDateFormatter alloc]init];
    [newDateFormatter setDateFormat:@"MM/dd/yyyy"];
    datePlayed.text = [newDateFormatter stringFromDate:round.date_played];
}

-(int)totalRoundScore
{
    int score = 0;
    
    for (RoundHole *rh in round.roundHoles)
    {
        score += [rh.score intValue];
    }
    
    return score;
}

@end

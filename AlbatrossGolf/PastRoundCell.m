//
//  PastRoundCell.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/31/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import "PastRoundCell.h"

@implementation PastRoundCell

@synthesize courseName, datePlayed, totalScore, round;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)reloadLabels
{
    courseName.text = round.course_name;
    totalScore.text = @"69";
    
    NSDateFormatter *newDateFormatter = [[NSDateFormatter alloc]init];
    [newDateFormatter setDateFormat:@"MM/dd/yyyy"];
    datePlayed.text = [newDateFormatter stringFromDate:round.date_played];
}

@end

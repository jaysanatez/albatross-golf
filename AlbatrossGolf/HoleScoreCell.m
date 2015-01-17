//
//  HoleScoreCell.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/26/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import "HoleScoreCell.h"

@implementation HoleScoreCell

@synthesize teeHole, holeNumber, holePar, holeYardage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}

-(void)reloadLabels
{
    holeNumber.text = [NSString stringWithFormat:@"%@",teeHole.hole_id]; // MURDER
    holePar.text = [NSString stringWithFormat:@"Par %@",teeHole.par];
    holeYardage.text = [NSString stringWithFormat:@"%@ yds",teeHole.yardage];
}

@end

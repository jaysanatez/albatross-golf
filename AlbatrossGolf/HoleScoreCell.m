//
//  HoleScoreCell.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/26/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import "HoleScoreCell.h"

@implementation HoleScoreCell

@synthesize teeHole, holeNumber, holePar, holeYardage, checkImage, showImage;

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
    holeNumber.text = [NSString stringWithFormat:@"%li",teeHole.hole.number];
    holePar.text = [NSString stringWithFormat:@"Par %li",teeHole.par];
    holeYardage.text = [NSString stringWithFormat:@"%li yds",teeHole.yardage];
    checkImage.image = showImage ? [UIImage imageNamed:@"whitecheck"] : nil;
}

@end

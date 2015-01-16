//
//  HoleLookupCollectionViewCell.m
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/15/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import "HoleLookupCollectionViewCell.h"

@implementation HoleLookupCollectionViewCell

@synthesize hole_score, holeNo, holePar, holeScore, image;

- (void)loadDisplay
{
    if(hole_score != nil)
    {
        holeNo.text = [NSString stringWithFormat:@"%i",hole_score.hole_number.integerValue];
        holePar.text = [NSString stringWithFormat:@"%i",hole_score.hole_par.integerValue];
        holeScore.text = [NSString stringWithFormat:@"%i",hole_score.score.integerValue];
        image.image = [UIImage imageNamed:[hole_score getScorecardSymbol]];
    }
    else
    {
        holeNo.text = @"-";
        holePar.text = @"-";
        holeScore.text = @"-";
    }
}

@end

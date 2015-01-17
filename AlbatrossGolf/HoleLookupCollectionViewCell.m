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
    if(hole_score != nil && hole_score.score != -1)
    {
        holeNo.text = [NSString stringWithFormat:@"%li",hole_score.hole_number];
        holePar.text = [NSString stringWithFormat:@"%li",hole_score.hole_par];
        holeScore.text = [NSString stringWithFormat:@"%li",hole_score.score];
        image.image = [UIImage imageNamed:[hole_score getScorecardSymbol]];
    }
    else if (hole_score != nil)
    {
        holeNo.text = [NSString stringWithFormat:@"%li",hole_score.hole_number];
        holePar.text = [NSString stringWithFormat:@"%li",hole_score.hole_par];
        holeScore.text = @"-";
    }
    else
    {
        holeNo.text = @"-";
        holePar.text = @"-";
        holeScore.text = @"-";
    }
}

@end

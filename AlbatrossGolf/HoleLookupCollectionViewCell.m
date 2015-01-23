//
//  HoleLookupCollectionViewCell.m
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/15/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import "HoleLookupCollectionViewCell.h"

@implementation HoleLookupCollectionViewCell

@synthesize hole_score, holeNo, holePar, holeScoreWord, holeScore;

- (void)loadDisplay
{
    holeScoreWord.adjustsFontSizeToFitWidth = YES;
    
    if(hole_score != nil && hole_score.score != -1)
    {
        holeNo.text = [NSString stringWithFormat:@"Hole %li",hole_score.hole_number];
        holePar.text = [NSString stringWithFormat:@"%li",hole_score.hole_par];
        holeScore.text = [NSString stringWithFormat:@"%li",hole_score.score];
        holeScoreWord.text = hole_score.getScoreName;
    }
    else if (hole_score != nil)
    {
        holeNo.text = [NSString stringWithFormat:@"Hole %li",hole_score.hole_number];
        holePar.text = [NSString stringWithFormat:@"%li",hole_score.hole_par];
        holeScore.text = @"-";
        holeScoreWord.text = @"";
    }
    else
    {
        holeNo.text = @"-";
        holePar.text = @"-";
        holeScore.text = @"-";
        holeScoreWord.text = @"-";
    }
}

@end

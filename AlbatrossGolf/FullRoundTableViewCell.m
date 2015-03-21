//
//  FullRoundTableViewCell.m
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 3/21/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import "FullRoundTableViewCell.h"

@implementation FullRoundTableViewCell

- (void)configureDisplay
{
    NSMutableArray *frcArray = [[NSMutableArray alloc] initWithObjects:_frc1, _frc2, _frc3, _frc4, _frc5, _frc6, _frc7, _frc8, _frc9, nil];
    
    int parTotal = 0;
    int scoreTotal = 0;
    
    for(int i = 0; i < frcArray.count; i++)
    {
        FullRoundCellContainer *f = [frcArray objectAtIndex:i];
        
        if(i < _holes.count)
        {
            f.hs = [_holes objectAtIndex:i];
            parTotal += f.hs.hole_par;
            
            if(f.hs.score != -1)
            {
                scoreTotal += f.hs.score;
            }
        }
        [f refreshDisplay];
    }
    
    _frcTotal.numberLabel.text = @"TOT";
    _frcTotal.parLabel.text = [NSString stringWithFormat:@"%i",parTotal];
    _frcTotal.scoreLabel.text = scoreTotal == 0 ? @"0" : [NSString stringWithFormat:@"%i",scoreTotal];
}

@end

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
    NSMutableArray *frcArray = [[NSMutableArray alloc] initWithObjects:_frc1, _frc2, _frc3, nil];
    for(int i = 0; i < frcArray.count; i++)
    {
        FullRoundCellContainer *f = [frcArray objectAtIndex:i];
        
        if(i < _holes.count)
        {
            f.hs = [_holes objectAtIndex:i];
        }
        [f refreshDisplay];
    }
}

@end

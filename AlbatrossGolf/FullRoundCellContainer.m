//
//  FullRoundCellContainer.m
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 3/21/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.
//

#import "FullRoundCellContainer.h"

@implementation FullRoundCellContainer

- (void)refreshDisplay
{
    if (_hs)
    {
        _numberLabel.text = [NSString stringWithFormat:@"%li", _hs.hole_number];
        _parLabel.text = [NSString stringWithFormat:@"%li", _hs.hole_par];
        _scoreLabel.text = [NSString stringWithFormat:@"%li", _hs.score];
    }
    else
    {
        _numberLabel.text = @"-";
        _parLabel.text = @"-";
        _scoreLabel.text = @"-";
    }
}

@end

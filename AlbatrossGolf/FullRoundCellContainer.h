//
//  FullRoundCellContainer.h
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 3/21/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HoleScore.h"

@interface FullRoundCellContainer : UIView

@property (nonatomic, strong) HoleScore *hs;
@property (nonatomic, strong) IBOutlet UIImageView *scorecardSymbol;
@property (nonatomic, strong) IBOutlet UILabel *numberLabel, *parLabel, *scoreLabel;

- (void)refreshDisplay;

@end

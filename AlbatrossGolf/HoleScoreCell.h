//
//  HoleScoreCell.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/26/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeeHole.h"

@interface HoleScoreCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UILabel *holeNumber, *holePar, *holeYardage;
@property (nonatomic, weak) IBOutlet UIImageView *checkImage;
@property (nonatomic, weak) TeeHole *teeHole;

- (void)reloadLabels;

@end

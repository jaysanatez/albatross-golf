//
//  HoleLookupCell.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 6/1/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import <UIKit/UIKit.h>

@interface HoleLookupCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UILabel *holePar, *holeScore, *holeNo;
@property (nonatomic, strong) IBOutlet UIImageView *image;

@end

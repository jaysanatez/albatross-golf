//
//  HoleLookupCollectionViewCell.h
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/15/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import <UIKit/UIKit.h>

@interface HoleLookupCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UILabel *holePar, *holeScore, *holeNo;
@property (nonatomic, strong) IBOutlet UIImageView *image;

@end

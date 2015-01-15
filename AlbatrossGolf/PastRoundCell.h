//
//  PastRoundCell.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/31/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import <UIKit/UIKit.h>
#import "Round.h"

@interface PastRoundCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *courseName,*datePlayed,*totalScore;
@property (nonatomic, weak) Round *round;

- (void)reloadLabels;

@end

//
//  RoundLookupVC.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/31/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import <UIKit/UIKit.h>
#import "HoleLookupCollectionViewCell.h"
#import "HoleLookupTableViewCell.h"
#import "RoundStats.h"
#import "HoleScore.h"
#import "ScorecardVC.h"
#import "TeeDao.h"
#import "Tee.h"
#import "Round.h"

@interface RoundLookupVC : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) Round *round;
@property (nonatomic, weak) IBOutlet UICollectionView *collecView;
@property (nonatomic, weak) IBOutlet UILabel *statsLabel;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *finalizeButtonHeight;
@property (nonatomic, weak) IBOutlet UIButton *finalizeButton;

- (IBAction)finalizeRound:(id)sender;

@end

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
@property (nonatomic, strong) IBOutlet UICollectionView *collecView;
@property (nonatomic, strong) IBOutlet UILabel *statsLabel;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end

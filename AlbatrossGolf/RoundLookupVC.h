//
//  RoundLookupVC.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/31/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import <UIKit/UIKit.h>
#import "HoleLookupTableViewCell.h"
#import "RoundStats.h"
#import "HoleScore.h"
#import "ScorecardVC.h"
#import "TeeDao.h"
#import "Tee.h"
#import "Round.h"
#import "Protocols.h"
#import "FullRoundView.h"

@interface RoundLookupVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id <RoundUpdateDelegate> delegate;

@property (nonatomic, weak) Round *round;
@property (nonatomic, weak) IBOutlet UILabel *statsLabel;
@property (nonatomic, weak) IBOutlet UITableView *tableView, *fullRoundTable;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *finalizeButtonHeight;
@property (nonatomic, weak) IBOutlet UIButton *finalizeButton;

- (IBAction)finalizeRound:(id)sender;

@end

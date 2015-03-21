//
//  Scorecard.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/23/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import <UIKit/UIKit.h>
#import "Round.h"
#import "Tee.h"
#import "HoleScoreVC.h"
#import "Scorecard.h"
#import "RoundDAO.h"
#import "HoleScoreCell.h"
#import "TeeHole.h"
#import "FullRoundView.h"
@class SavingThrobberView;

@interface ScorecardVC : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, RoundDataPostable, RoundPostDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) Scorecard *scorecard;
@property (nonatomic, weak) IBOutlet UICollectionView *collecView;
@property (nonatomic, weak) IBOutlet SavingThrobberView *saving_throbber;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *scorecardTopConstraint;
@property (nonatomic, strong) IBOutlet UITableView *fullRoundTable;

- (IBAction)toggleScorecard:(id)sender;

@end

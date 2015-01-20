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
@class SavingThrobberView;

@interface ScorecardVC : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, RoundDataPostable, RoundPostDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) Scorecard *scorecard;
@property (nonatomic, strong) Round *round;
@property (nonatomic, weak) IBOutlet UICollectionView *collecView;
@property (nonatomic, weak) IBOutlet SavingThrobberView *saving_throbber;

@end

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
@class LoadingThrobberView;

@interface ScorecardVC : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, RoundHolePostable>

@property (nonatomic, strong) Scorecard *scorecard;
@property (nonatomic, weak) IBOutlet UICollectionView *collecView;

- (IBAction)saveRound:(id)sender;

@end

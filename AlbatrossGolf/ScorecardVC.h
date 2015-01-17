//
//  Scorecard.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/23/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import <UIKit/UIKit.h>
#import "Round.h"
#import "TeeHoleDAO.h"
#import "Tee.h"
#import "HoleScoreVC.h"

@interface ScorecardVC : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, TeeHoleFetchDelegate, RoundHolePostable>

@property (nonatomic, weak) Tee *tee;
@property (nonatomic, weak) IBOutlet UICollectionView *collecView;
@property (nonatomic, strong) NSMutableArray *teeHoles;
@property (nonatomic, weak) IBOutlet UIView *spinnerView;

@end

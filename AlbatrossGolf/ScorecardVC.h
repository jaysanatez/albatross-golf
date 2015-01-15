//
//  Scorecard.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/23/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import <UIKit/UIKit.h>
#import "Round.h"
#import "TeeHoleDAO.h"

@interface Scorecard : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, TeeHoleFetchDelegate>

@property (nonatomic, weak) Round *round;
@property (nonatomic, strong) NSNumber *courseId, *teeId;
@property (nonatomic, weak) IBOutlet UICollectionView *collecView;
@property (nonatomic, weak) NSString *courseName;
@property (nonatomic, strong) NSMutableArray *teeHoles;
@property (nonatomic, weak) IBOutlet UIView *spinnerView;

@end

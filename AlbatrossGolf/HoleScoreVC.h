//
//  HoleScore.h
//  SmartShot
//
//  Created by Jacob Sanchez on 5/27/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import <UIKit/UIKit.h>
#import "TeeHole.h"
#import "RoundHole.h"
#import "HoleScore.h"

@protocol RoundHolePostable

- (void)postRoundHole:(RoundHole *)roundHole;
- (void)postHoleScore:(HoleScore *)holeScore;

@end

@interface HoleScoreVC : UIViewController

@property (nonatomic, weak) id <RoundHolePostable> delegate;

@property (nonatomic, weak) IBOutlet UILabel *handicapLabel, *scoreLabel, *yardLabel, *netLabel;
@property (nonatomic, weak) IBOutlet UILabel *holeLabel;
@property (nonatomic, weak) IBOutlet UILabel *courseLabel, *parLabel;
@property (nonatomic, weak) IBOutlet UIView *score_entry_view;
@property (nonatomic, weak) IBOutlet UITextField *score_field;
@property (nonatomic, weak) TeeHole *teeHole;
@property (nonatomic, weak) NSString *courseName;

- (IBAction)scoreEntered:(id)sender;

@end

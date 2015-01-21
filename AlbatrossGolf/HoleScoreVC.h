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
#import "HoleDataView.h"
#import "ScorecardVC.h"
#import "Delegates.h"

@interface HoleScoreVC : UIViewController <HoleDataViewDelegate>

@property (nonatomic, weak) id <RoundDataPostable> delegate;

@property (nonatomic, weak) IBOutlet UILabel *handicapLabel, *scoreLabel, *yardLabel, *netLabel;
@property (nonatomic, weak) IBOutlet UILabel *holeLabel, *courseLabel, *parLabel, *questionLabel;
@property (nonatomic, weak) IBOutlet UIView *score_entry_view, *data_entry_view, *intSelectionView;
@property (nonatomic, weak) IBOutlet UITextField *score_field;
@property (nonatomic, weak) TeeHole *tee_hole;
@property (nonatomic, strong) RoundHole *round_hole;
@property (nonatomic, strong) HoleScore *hole_score;
@property (nonatomic, weak) NSString *course_name;
@property (nonatomic, weak) IBOutlet HoleDataView *hole_data_view;

- (IBAction)scoreEntered:(id)sender;

- (IBAction)yesButtonTapped:(id)sender;
- (IBAction)noButtonTapped:(id)sender;

- (IBAction)zeroButtonTapped:(id)sender;
- (IBAction)oneButtonTapped:(id)sender;
- (IBAction)twoButtonTapped:(id)sender;
- (IBAction)threeButtonTapped:(id)sender;
- (IBAction)fourButtonTapped:(id)sender;
- (IBAction)fiveButtonTapped:(id)sender;

@end

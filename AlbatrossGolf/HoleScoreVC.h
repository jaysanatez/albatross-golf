//
//  HoleScore.h
//  SmartShot
//
//  Created by Jacob Sanchez on 5/27/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeeHole.h"

@interface HoleScoreVC : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *handicapLabel, *scoreLabel, *yardLabel, *netLabel, *courseLabel;
@property (nonatomic, weak) IBOutlet UILabel *popupHoleLabel,*popupParLabel, *popupLengthLabel, *holeLabel, *parLabel;
@property (nonatomic, weak) IBOutlet UILabel *holeQuestion, *holeDescription;
@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) TeeHole *teeHole;
@property (nonatomic, weak) NSString *courseName;
@property (nonatomic, weak) IBOutlet UIView *holeScoreView, *blurView, *boolView, *intView;
@property (nonatomic, weak) IBOutlet UIButton *enterButton;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *constraint;

- (IBAction)enterHoleScore:(id)sender;
- (IBAction)doneWithHole:(id)sender;
- (IBAction)noOptionTapped:(id)sender;
- (IBAction)yesOptionTapped:(id)sender;
- (IBAction)zeroOptionTapped:(id)sender;
- (IBAction)oneOptionTapped:(id)sender;
- (IBAction)twoOptionTapped:(id)sender;
- (IBAction)threeOptionTapped:(id)sender;
- (IBAction)fourOptionTapped:(id)sender;
- (IBAction)fiveOptionTapped:(id)sender;

@end

//
//  HoleScore.m
//  SmartShot
//
//  Created by Jacob Sanchez on 5/27/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import "HoleScoreVC.h"
#import "ScorecardVC.h"
#import "Hole.h"

@interface HoleScore ()
{
    int holeScore;
}

@end

@implementation HoleScore

@synthesize courseLabel,holeLabel,parLabel,teeHole,courseName,textField,popupHoleLabel,popupLengthLabel,popupParLabel;
@synthesize blurView,handicapLabel,scoreLabel,netLabel,yardLabel,holeScoreView,constraint,enterButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title =  @"Scoring Breakdown";
    courseLabel.text = courseName;
    holeLabel.text = [NSString stringWithFormat: @"Hole #%@",teeHole.hole_num];
    parLabel.text = [NSString stringWithFormat:@"Par %@",teeHole.par];
    handicapLabel.text = [NSString stringWithFormat:@"Handicap: %@",teeHole.handicap];
    yardLabel.text = [NSString stringWithFormat:@"Length: %@ yds",teeHole.yardage];
    scoreLabel.text = @"Score: ---";
    netLabel.text = @"-----";
    
    netLabel.layer.cornerRadius = 8;
    netLabel.layer.masksToBounds = YES;
    
    enterButton.layer.cornerRadius = 8;
    enterButton.layer.masksToBounds = YES;
    
    // popup stuff
    popupHoleLabel.text = [NSString stringWithFormat: @"Hole #%@",teeHole.hole_num];
    popupParLabel.text = [NSString stringWithFormat:@"Par %@",teeHole.par];
    popupLengthLabel.text = [NSString stringWithFormat:@"%@ yds",teeHole.yardage];
    
    holeScore = 0;
}

- (IBAction)doneWithHole:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)enterHoleScore:(id)sender
{
    if([textField.text isEqualToString:@""])
    {
        return;
    }
    
    NSNumber *score = [NSNumber numberWithInt:[textField.text integerValue]];
    scoreLabel.text = [NSString stringWithFormat:@"Score: %@",score];
    netLabel.text = [self stringForScore:score];
    constraint.constant = -130;
    [UIView animateWithDuration:0.4f animations:^{
        [self.view layoutIfNeeded];
        blurView.alpha = 0;
    } completion:^(BOOL completed){
        holeScoreView.hidden = YES;
    }];
}

-(NSString *)stringForScore:(NSNumber *)score
{
    int net = [score intValue] - [teeHole.par intValue];
    switch (net)
    {
        case -3:
            return @"ALBATROSS";
        case -2:
            return @"EAGLE";
        case -1:
            return @"BIRDIE";
        case 0:
            return @"PAR";
        case 1:
            return @"BOGEY";
        default:
            return @"D. BOGEY+";
    }
}

@end

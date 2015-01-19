//
//  HoleScore.m
//  SmartShot
//
//  Created by Jacob Sanchez on 5/27/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import "HoleScoreVC.h"
#import "ScorecardVC.h"
#import "RoundHole.h"
#import "HoleScore.h"

@interface HoleScoreVC ()
{
    long *holeScore;
    NSArray *questions, *descriptions;
    int questionsAsked;
    RoundHole *round_hole;
    HoleScore *hole_score;
}

@end

@implementation HoleScoreVC

@synthesize handicapLabel, scoreLabel, yardLabel, netLabel, holeLabel, courseLabel, parLabel, teeHole, courseName, score_entry_view, score_field, delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title =  @"Scoring Breakdown";
    courseLabel.text = courseName;
    holeLabel.text = [NSString stringWithFormat: @"Hole #%li",teeHole.hole.number];
    parLabel.text = [NSString stringWithFormat:@"Par %li",teeHole.par];
    handicapLabel.text = [NSString stringWithFormat:@"Handicap: %li",teeHole.handicap];
    yardLabel.text = [NSString stringWithFormat:@"Length: %li yds",teeHole.yardage];
    scoreLabel.text = @"Score: ---";
    netLabel.text = @"-----";
    
    netLabel.layer.cornerRadius = 8;
    netLabel.layer.masksToBounds = YES;
    
    hole_score = [[HoleScore alloc] init];
    
    questions = [[NSArray alloc] initWithObjects:@"Hit Fairway:", @"GIR:", @"Fairway Bunker:", @"Greenside Bunker:", @"Putts:", @"Penalty Strokes", nil];
    descriptions = [[NSArray alloc] initWithObjects:@"Did your drive land in the fairway?", @"Did you hit the green in regulation?", @"Did you land in a fairway bunker?", @"Did you land in a greenside bunker?", @"How many putts did you have?", @"How many penalty strokes did you have?", nil];
    questionsAsked = 0;
}

- (void)scoreEntered:(id)sender
{
    if ([score_field.text isEqualToString:@""])
    {
        return;
    }
    
    long score = [score_field.text intValue];
    
    if (score <= 0)
    {
        return;
    }
    
    hole_score.hole_number = teeHole.hole.number;
    hole_score.hole_par = teeHole.par;
    hole_score.score = score;
    
    scoreLabel.text = [NSString stringWithFormat:@"Score: %li",hole_score.score ];
    netLabel.text = hole_score.getScoreName;
    
    [UIView animateWithDuration:1 animations:^{
        score_entry_view.alpha = 0;
    } completion:^(BOOL finished){
        score_entry_view.hidden = YES;
        [self postHoleData];
    }];
}

-(void)postHoleData
{
    [delegate postHoleScore:hole_score];
    [self.navigationController popViewControllerAnimated:YES];
}

@end

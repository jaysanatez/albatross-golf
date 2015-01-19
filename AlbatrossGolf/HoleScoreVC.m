//
//  HoleScore.m
//  SmartShot
//
//  Created by Jacob Sanchez on 5/27/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import "HoleScoreVC.h"
#import "ScorecardVC.h"

@interface HoleScoreVC ()
{
    long *holeScore;
    NSArray *questions;
    int questionsAsked;
}

@end

@implementation HoleScoreVC

@synthesize delegate, handicapLabel, scoreLabel, yardLabel, netLabel, holeLabel, courseLabel, parLabel, tee_hole, course_name, score_entry_view, score_field, data_entry_view, hole_score, round_hole, questionLabel, intSelectionRightConstraint;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title =  @"Scoring Breakdown";
    courseLabel.text = course_name;
    holeLabel.text = [NSString stringWithFormat: @"Hole #%li",tee_hole.hole.number];
    parLabel.text = [NSString stringWithFormat:@"Par %li",tee_hole.par];
    handicapLabel.text = [NSString stringWithFormat:@"Handicap: %li",tee_hole.handicap];
    yardLabel.text = [NSString stringWithFormat:@"Length: %li yds",tee_hole.yardage];
    netLabel.adjustsFontSizeToFitWidth = YES;
    
    if (hole_score)
    {
        score_entry_view.hidden = YES;
        data_entry_view.alpha = 1;
        
        scoreLabel.text = [NSString stringWithFormat:@"Score: %li",hole_score.score ];
        netLabel.text = hole_score.getScoreName;
    }
    else
    {
        scoreLabel.text = @"Score: ---";
        netLabel.text = @"-----";
        
        hole_score = [[HoleScore alloc] init];
    }
    
    if (round_hole)
    {
        [self showDataOverview];
    }
    else
    {
        round_hole = [[RoundHole alloc] init];
        round_hole.hole_id = tee_hole.hole.id_num;
    }
    
    netLabel.layer.cornerRadius = 8;
    netLabel.layer.masksToBounds = YES;
    
    questions = [[NSArray alloc] initWithObjects:@"Did your drive hit in the fairway?", @"Did you get on the green in regulation?", @"Did you hit it in a fairway bunker?", @"Did you hit it in a greenside bunker?", @"How many putts did you have?", @"How many penalty strokes did you have?", nil];
    questionsAsked = 0;
    questionLabel.text = [questions objectAtIndex:0];
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
    
    hole_score.hole_number = tee_hole.hole.number;
    hole_score.hole_par = tee_hole.par;
    hole_score.score = score;
    round_hole.score = score;
    
    scoreLabel.text = [NSString stringWithFormat:@"Score: %li",hole_score.score ];
    netLabel.text = hole_score.getScoreName;
    
    [UIView animateWithDuration:1 animations:^{
        score_entry_view.alpha = 0;
        data_entry_view.alpha = 1;
    } completion:^(BOOL finished){
        score_entry_view.hidden = YES;
    }];
}

- (void)postHoleData
{
    [delegate postHoleScore:hole_score];
    [delegate postRoundHole:round_hole];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)yesButtonTapped:(id)sender
{
    [self nextQuestionAnsweredWithBool:YES];
}

- (void)noButtonTapped:(id)sender
{
    [self nextQuestionAnsweredWithBool:NO];
}

- (void)nextQuestionAnsweredWithBool:(BOOL)answer
{
    switch (questionsAsked)
    {
        case 0:
            round_hole.hitFairway = answer;
            break;
            
        case 1:
            round_hole.hitGir = answer;
            break;
            
        case 2:
            round_hole.hitFairwayBunker = answer;
            break;
            
        case 3:
            round_hole.hitGreensideBunker = answer;
            [self switchToIntSelection];
            break;
            
        default:
            break;
    }
    
    [self presentNextQuestion];
}

- (void)zeroButtonTapped:(id)sender
{
    [self nextQuestionAnsweredWithInt:0];
}

- (void)oneButtonTapped:(id)sender
{
    [self nextQuestionAnsweredWithInt:1];
}

- (void)twoButtonTapped:(id)sender
{
    [self nextQuestionAnsweredWithInt:2];
}

- (void)threeButtonTapped:(id)sender
{
    [self nextQuestionAnsweredWithInt:3];
}

- (void)fourButtonTapped:(id)sender
{
    [self nextQuestionAnsweredWithInt:4];
}

- (void)fiveButtonTapped:(id)sender
{
    [self nextQuestionAnsweredWithInt:5];
}

- (void)nextQuestionAnsweredWithInt:(int)answer
{
    switch (questionsAsked)
    {
        case 4:
            round_hole.putts = answer;
            break;
            
        case 5:
            round_hole.penalties = answer;
            break;
            
        default:
            break;
    }
    
    if (questionsAsked > 4) // last question
    {
        [self showDataOverview];
    }
    else
    {
        [self presentNextQuestion];
    }
}

- (void)presentNextQuestion
{
    questionsAsked++;
    questionLabel.text = [questions objectAtIndex:questionsAsked];
}

- (void)switchToIntSelection
{
    intSelectionRightConstraint.constant = 5;
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)showDataOverview
{
    [self postHoleData];
}

@end

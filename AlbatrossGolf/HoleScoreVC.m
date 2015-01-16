//
//  HoleScore.m
//  SmartShot
//
//  Created by Jacob Sanchez on 5/27/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import "HoleScoreVC.h"
#import "ScorecardVC.h"
#import "RoundHole.h"

@interface HoleScoreVC ()
{
    int holeScore;
    NSArray *questions, *descriptions;
    NSMutableArray *holeData;
    int questionsAsked;
    RoundHole *round_hole;
}

@end

@implementation HoleScoreVC

@synthesize courseLabel,holeLabel,parLabel,teeHole,courseName,textField,popupHoleLabel,popupLengthLabel,popupParLabel;
@synthesize blurView,handicapLabel,scoreLabel,netLabel,yardLabel,holeScoreView,constraint,enterButton,holeQuestion;
@synthesize holeDescription,boolView,intView;

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
    
    boolView.hidden = NO;
    intView.hidden = YES;
    holeDescription.adjustsFontSizeToFitWidth = YES;
    holeQuestion.adjustsFontSizeToFitWidth = YES;
    holeScore = 0;
    questions = [[NSArray alloc] initWithObjects:@"Hit Fairway:", @"GIR:", @"Fairway Bunker:", @"Greenside Bunker:", @"Putts:", @"Penalty Strokes", nil];
    descriptions = [[NSArray alloc] initWithObjects:@"Did your drive land in the fairway?", @"Did you hit the green in regulation?", @"Did you land in a fairway bunker?", @"Did you land in a greenside bunker?", @"How many putts did you have?", @"How many penalty strokes did you have?", nil];
    questionsAsked = 0;
    holeQuestion.text = [questions objectAtIndex:questionsAsked];
    holeDescription.text = [descriptions objectAtIndex:questionsAsked];
    holeData = [[NSMutableArray alloc] initWithObjects:nil];
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

- (void)yesOptionTapped:(id)sender
{
    [holeData insertObject:[NSNumber numberWithBool:true] atIndex:questionsAsked];
    [self presentNextQuestion];
}

- (void)noOptionTapped:(id)sender
{
    [holeData insertObject:[NSNumber numberWithBool:false] atIndex:questionsAsked];
    [self presentNextQuestion];
}

- (void)presentNextQuestion
{
    questionsAsked++;
    if(questionsAsked < [questions count])
    {
        if(questionsAsked == 4)
        {
            boolView.hidden = YES;
            intView.hidden = NO;
        }
        holeQuestion.text = [questions objectAtIndex:questionsAsked];
        holeDescription.text = [descriptions objectAtIndex:questionsAsked];
    }
    else
    {
        intView.hidden = YES;
        holeQuestion.text = @"Finished";
        holeDescription.text = @"";
        [self constructRoundHole];
    }
}

- (IBAction)zeroOptionTapped:(id)sender
{
    [holeData insertObject:[NSNumber numberWithInt:0] atIndex:questionsAsked];
    [self presentNextQuestion];
}

- (IBAction)oneOptionTapped:(id)sender
{
    [holeData insertObject:[NSNumber numberWithInt:1] atIndex:questionsAsked];
    [self presentNextQuestion];
}

- (IBAction)twoOptionTapped:(id)sender
{
    [holeData insertObject:[NSNumber numberWithInt:2] atIndex:questionsAsked];
    [self presentNextQuestion];
}

- (IBAction)threeOptionTapped:(id)sender
{
    [holeData insertObject:[NSNumber numberWithInt:3] atIndex:questionsAsked];
    [self presentNextQuestion];
}

- (IBAction)fourOptionTapped:(id)sender
{
    [holeData insertObject:[NSNumber numberWithInt:4] atIndex:questionsAsked];
    [self presentNextQuestion];
}

- (IBAction)fiveOptionTapped:(id)sender
{
    [holeData insertObject:[NSNumber numberWithInt:5] atIndex:questionsAsked];
    [self presentNextQuestion];
}

- (void)constructRoundHole
{
    round_hole = [[RoundHole alloc] init];
    round_hole.hitFairway = [[holeData objectAtIndex:0] boolValue];
    round_hole.hitGir = [[holeData objectAtIndex:1] boolValue];
    round_hole.hitFairwayBunker = [[holeData objectAtIndex:2] boolValue];
    round_hole.hitGreensideBunker = [[holeData objectAtIndex:3] boolValue];
    round_hole.putts = [NSNumber numberWithInt:[[holeData objectAtIndex:4] intValue]];
    round_hole.penalties = [NSNumber numberWithInt:[[holeData objectAtIndex:5] intValue]];
}

@end

//
//  Scorecard.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/23/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import "ScorecardVC.h"
#import "HoleScoreCell.h"
#import "HoleScoreVC.h"
#import "TeeHole.h"

@interface ScorecardVC ()
{
    Round *round;
    RoundDAO *dao;
}

@end

@implementation ScorecardVC

@synthesize collecView, scorecard, saveButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [collecView registerNib:[UINib nibWithNibName:@"HoleScoreCell" bundle:[NSBundle mainBundle]]  forCellWithReuseIdentifier:@"HoleScore"];
    
    // save button styling
    saveButton.layer.cornerRadius = 8;
    saveButton.clipsToBounds = YES;
    
    self.title = scorecard.course.name;
    round = [[Round alloc] init];
    round.hole_scores = [[NSMutableArray alloc] init];
    round.round_holes = [[NSMutableArray alloc] init];
    
    dao = [[RoundDAO alloc] init];
    dao.post_delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [collecView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [scorecard.tee_holes count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"HoleScore";
    HoleScoreCell *hole = [collecView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    TeeHole *tHole = (TeeHole *)[scorecard.tee_holes objectAtIndex:indexPath.row];
    hole.teeHole = tHole;
    hole.showImage = [self getAssociatedHoleScore:tHole] != nil;
    [hole reloadLabels];
    return hole;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HoleScoreVC *holeScore = [[HoleScoreVC alloc] initWithNibName:@"HoleScoreVC" bundle:[NSBundle mainBundle]];
    TeeHole *tHole = (TeeHole *)[scorecard.tee_holes objectAtIndex:indexPath.row];
    holeScore.tee_hole = tHole;
    holeScore.course_name = scorecard.course.name;
    holeScore.delegate = self;
    holeScore.hole_score = [self getAssociatedHoleScore:tHole];
    holeScore.round_hole = [self getAssociatedRoundHole:tHole];
    [self.navigationController pushViewController:holeScore animated:YES];
}

- (HoleScore *)getAssociatedHoleScore:(TeeHole *)tHole
{
    for(HoleScore *hs in round.hole_scores)
    {
        if (hs.hole_number == tHole.hole.number)
        {
            return hs;
        }
    }
    
    return nil;
}

- (RoundHole *)getAssociatedRoundHole:(TeeHole *)tHole
{
    for(RoundHole *rh in round.round_holes)
    {
        if (rh.hole_id == tHole.hole.id_num)
        {
            return rh;
        }
    }
    
    return nil;
}

- (void)postRoundHole:(RoundHole *)roundHole
{
    [round.round_holes addObject:roundHole];
}

- (void)postHoleScore:(HoleScore *)holeScore
{
    [round.hole_scores addObject:holeScore];
}

- (void)saveRound:(id)sender
{
    round.course_id = scorecard.course.id_num;
    round.tee_id = scorecard.tee.id_num;
    
    long round_id = [dao postRound:round forUser:2];
    
    if (round_id != -1)
    {
        for(RoundHole *rh in round.round_holes)
        {
            rh.round_id = round_id;
            [dao postRoundHole:rh forUser:2];
        }
    }
    else // round post returned no data
    {
        [self roundPostThrewError:nil];
    }
}

- (void)roundPostSucceeded
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Save Successful" message:@"The round was saved successfully! View it under Past Rounds." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [alert show];
    
    // pop to menu / push round lookup view
}

- (void)roundPostThrewError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure to Save" message:@"The round was not saved successfully. Please try again." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [alert show];
}

- (void)roundPostTimedOut
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"A Timeout Occurred" message:@"A timeout occurred when trying to save your round. Make sure you have a sufficient data connection and try again." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [alert show];
}

@end

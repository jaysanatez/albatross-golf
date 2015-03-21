//
//  Scorecard.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/23/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import "ScorecardVC.h"
#import "AppDelegate.h"

@interface ScorecardVC ()
{
    RoundDAO *dao;
    _Bool unsaved_data;
    int round_holes_saved;
    bool round_saved;
}

@end

@implementation ScorecardVC

@synthesize collecView, scorecard, saving_throbber;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    _user = [delegate getActiveUser];
    
    [collecView registerNib:[UINib nibWithNibName:@"HoleScoreCell" bundle:[NSBundle mainBundle]]  forCellWithReuseIdentifier:@"HoleScore"];
    
    ((UIView *)saving_throbber).layer.cornerRadius = 8;
    ((UIView *)saving_throbber).layer.masksToBounds = YES;
    
    self.title = scorecard.course.name;
    
    if(!scorecard.round)
    {
        scorecard.round = [[Round alloc] init];
        scorecard.round.hole_scores = [[NSMutableArray alloc] init];
        scorecard.round.round_holes = [[NSMutableArray alloc] init];
    }
    
    dao = [[RoundDAO alloc] init];
    dao.post_delegate = self;
    
    // custom back button
    UIBarButtonItem *exit = [[UIBarButtonItem alloc] initWithTitle:@"Exit" style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = exit;
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveRound)];
    self.navigationItem.rightBarButtonItem = save;
    unsaved_data = false;
    
    round_holes_saved = 0;
    round_saved = true;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [collecView reloadData];
    [self checkRoundCompletion];
}

- (void)goBack
{
    if (unsaved_data)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"WARNING" message:@"Your round will not be saved if you proceed and you will lose any round data." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Leave", nil];
        [alert show];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [scorecard.tee.tee_holes count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"HoleScore";
    HoleScoreCell *hole = [collecView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    TeeHole *tHole = (TeeHole *)[scorecard.tee.tee_holes objectAtIndex:indexPath.row];
    hole.teeHole = tHole;
    
    HoleScore *hs = [self getAssociatedHoleScore:tHole.hole.number];
    hole.showImage = hs != nil && hs.score != -1;
    [hole reloadLabels];
    return hole;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HoleScoreVC *holeScore = [[HoleScoreVC alloc] initWithNibName:@"HoleScoreVC" bundle:[NSBundle mainBundle]];
    TeeHole *tHole = (TeeHole *)[scorecard.tee.tee_holes objectAtIndex:indexPath.row];
    holeScore.tee_hole = tHole;
    holeScore.course_name = scorecard.course.name;
    holeScore.delegate = self;
    holeScore.hole_score = [self getAssociatedHoleScore:tHole.hole.number];
    holeScore.round_hole = [self getAssociatedRoundHole:tHole.hole.id_num];
    [self.navigationController pushViewController:holeScore animated:YES];
}

- (HoleScore *)getAssociatedHoleScore:(long)hole_number
{
    for(HoleScore *hs in scorecard.round.hole_scores)
    {
        if (hs.hole_number == hole_number)
        {
            return hs;
        }
    }
    
    return nil;
}

- (RoundHole *)getAssociatedRoundHole:(long)hole_id
{
    for(RoundHole *rh in scorecard.round.round_holes)
    {
        if (rh.hole_id == hole_id)
        {
            return rh;
        }
    }
    
    return nil;
}

- (void)postRoundHole:(RoundHole *)roundHole
{
    RoundHole *rh = [self getAssociatedRoundHole:roundHole.hole_id];
    
    // if round hole exists, do nothing
    if (rh != nil && rh.id_num == roundHole.id_num)
    {
        return;
    }
    
    [scorecard.round.round_holes addObject:roundHole];
    unsaved_data = true;
}

- (void)postHoleScore:(HoleScore *)holeScore
{
    HoleScore *hs = [self getAssociatedHoleScore:holeScore.hole_number];
    
    // if hole score already exists, do nothing
    if (hs != nil && hs.score != -1)
    {
        return;
    }
    
    // see if "blank" hole score exists remove it if yes
    if (hs != nil && hs.score == -1)
    {
        [scorecard.round.hole_scores removeObject:hs];
    }
    
    [scorecard.round.hole_scores addObject:holeScore];
    unsaved_data = true;
}

- (void)checkRoundCompletion
{
    BOOL alreadyCompleted = scorecard.round.is_complete;
    BOOL completed = scorecard.round.round_holes.count == scorecard.tee.tee_holes.count;
    scorecard.round.is_complete = completed;
    
    if(completed && !alreadyCompleted)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Round Complete" message:@"Tap Save to submit your round to the server." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [dao updateRound:scorecard.round forUser:scorecard.user.id_num];
    }
}

- (void)saveRound
{
    scorecard.round.course_id = scorecard.course.id_num;
    scorecard.round.tee_id = scorecard.tee.id_num;
    
    [self displaySavingThrobber:YES];
    
    // if id already exists, don't post round
    if(scorecard.round.id_num == 0)
    {
        round_saved = false;
        scorecard.round.id_num = [dao postRound:scorecard.round forUser:_user.id_num];
    }
    
    
    if (scorecard.round.id_num != -1)
    {
        for(RoundHole *rh in scorecard.round.round_holes)
        {
            // if round hasn't been posted
            if (rh.id_num == 0)
            {
                rh.round_id = scorecard.round.id_num;
                long newId = [dao postRoundHole:rh forUser:_user.id_num];
                rh.id_num = newId;
            }
            else
            {
                // update it
                [dao updateRoundHole:rh forUser:_user.id_num];
            }
        }
    }
    else // round post returned no data
    {
        [self roundPostThrewError:nil];
    }
    
    unsaved_data = false;
}

- (void)displaySavingThrobber:(BOOL)show
{
    ((UIView *)saving_throbber).hidden = !show;
}

- (void)roundPostSucceeded
{
    round_saved = true;
    [self alertFullRoundPostSuccessful];
    
    // pop to menu / push round lookup view
}

- (void)roundholePostSucceeded
{
    round_holes_saved++;
    [self alertFullRoundPostSuccessful];
}

- (void)alertFullRoundPostSuccessful
{
    NSLog(@"%@ SAVED:%i POSSIBLE:%lu",round_saved ? @"TRUE" : @"FALSE", round_holes_saved, (unsigned long)scorecard.round.round_holes.count);
    if (round_saved && round_holes_saved == scorecard.round.round_holes.count)
    {
        round_holes_saved = 0;
        [self displaySavingThrobber:NO];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Save Successful" message:@"The round was saved successfully! View it under Past Rounds." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)roundPostThrewError:(NSError *)error
{
    [self displaySavingThrobber:NO];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure to Save" message:@"The round/hole data was not saved successfully. Please try again." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [alert show];
}

- (void)roundPostTimedOut
{
    [self displaySavingThrobber:NO];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"A Timeout Occurred" message:@"A timeout occurred when trying to save your round. Make sure you have a sufficient data connection and try again." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [alert show];
}

@end

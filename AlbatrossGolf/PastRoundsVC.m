//
//  PastRoundsVC.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/31/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import "PastRoundsVC.h"
#import "AlbatrossGolf-Swift.h"

@interface PastRoundsVC ()
{
    RoundDAO *dao;
    NSArray *sections;
    NSMutableArray *allRounds, *completeRounds, *incompleteRounds;
}

@end

@implementation PastRoundsVC

@synthesize tableView, loadingView, user;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [tableView registerNib:[UINib nibWithNibName:@"PastRoundTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PastRound"];
    self.title = @"Past Rounds";
    
    loadingView.layer.cornerRadius = 8;
    loadingView.clipsToBounds = YES;
    
    sections = [[NSArray alloc] initWithObjects:@"In Progress",@"Completed",nil];
    
    dao = [[RoundDAO alloc] init];
    [self fetchRounds];
}

- (void)fetchRounds
{
    dao.fetch_delegate = self;
    [dao fetchAllRoundsForUser:2];
    [self displaySpinnerView:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section > 0 ? 20 :30;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? [incompleteRounds count] : [completeRounds count];
}

-(UITableViewCell *)tableView:(UITableView *)tabView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"PastRound";
    PastRoundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[PastRoundTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.round = [self retrieveRoundForIndexPath:indexPath];
    [cell reloadLabels];
    
    return cell;
}

- (void)tableView:(UITableView *)tabView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Round *round = [self retrieveRoundForIndexPath:indexPath];
    RoundLookupVC *controller = [[RoundLookupVC alloc] initWithNibName:@"RoundLookupVC" bundle:[NSBundle mainBundle]];
    controller.delegate = self;
    controller.round = round;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)updateRound:(Round *)round
{
    [dao updateRound:round];
    [self fetchRounds];
}

- (Round *)retrieveRoundForIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return (Round *)[incompleteRounds objectAtIndex:indexPath.row];
    }
    else
    {
        return (Round *)[completeRounds objectAtIndex:indexPath.row];
    }
}

- (void)refreshRoundList:(NSMutableArray *)rounds
{
    allRounds = rounds;
    [self splitIntoCompletedAndNah];

    for (Round *r in allRounds)
    {
        [dao fetchRoundHolesWithRound:r.id_num];
        [dao fetchStatsForRound:r.id_num];
        [dao fetchHoleScoresForRoundId:r.id_num];
    }
}
- (void)roundHolesFetched:(NSMutableArray *)roundHoles forRoundId:(long)round_id
{
    for(Round *r in allRounds)
    {
        if (r.id_num == round_id)
        {
            r.round_holes = roundHoles;
        }
    }
    
    [self displayIfComplete];
}
- (void)roundStatsFetched:(RoundStats *)roundStats forRoundId:(long)round_id
{
    for(Round *r in allRounds)
    {
        if (r.id_num == round_id)
        {
            r.round_stats = roundStats;
        }
    }
    
    [self displayIfComplete];
}

- (void)holeScoresFetched:(NSMutableArray *)holeScores forRoundId:(long)round_id
{
    for(Round *r in allRounds)
    {
        if (r.id_num == round_id)
        {
            r.hole_scores = holeScores;
        }
    }
    
    [self displayIfComplete];
}

- (void)displayIfComplete
{
    for(Round *r in allRounds)
    {
        if(!r.round_stats || !r.round_holes || !r.hole_scores)
        {
            return;
        }
    }
    
    [tableView reloadData];
    [self displaySpinnerView:NO];
}

- (void)splitIntoCompletedAndNah
{
    incompleteRounds = [[NSMutableArray alloc] init];
    completeRounds = [[NSMutableArray alloc] init];
    
    for (Round *r in allRounds)
    {
        if (r.is_complete)
        {
            [completeRounds addObject:r];
        }
        else
        {
            [incompleteRounds addObject:r];
        }
    }
}

-(NSString*)tableView:(UITableView *) tableView titleForHeaderInSection:(NSInteger)section
{
    return [sections objectAtIndex:section];
}

-(void)displaySpinnerView:(BOOL)show
{
    ((UIView *)loadingView).hidden = !show;
}

@end

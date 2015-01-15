//
//  PastRoundsVC.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/31/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import "PastRoundsVC.h"
#import "PastRoundCell.h"
#import "Course.h"
#import "Round.h"
#import "RoundLookupVC.h"

@interface PastRoundsVC ()
{
    RoundDAO *r_dao;
    RoundHoleDAO *rh_dao;
    NSArray *sections;
    NSMutableArray *allRounds, *completeRounds, *incompleteRounds;
}

@end

@implementation PastRoundsVC

@synthesize tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];    
    sections = [[NSArray alloc] initWithObjects:@"In Progress",@"Completed",nil];
    r_dao = [[RoundDAO alloc] init];
    rh_dao = [[RoundHoleDAO alloc] init];
    r_dao.delegate = self;
    [r_dao fetchAllRoundsForUser:[NSNumber numberWithInt:2]];
    incompleteRounds = [[NSMutableArray alloc] init];
    completeRounds = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section > 0)
        return 20;
    return 30;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section == 0) ? [incompleteRounds count] : [completeRounds count];
}

-(UITableViewCell *)tableView:(UITableView *)tabView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"customCell";
    PastRoundCell *cell = (PastRoundCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
        cell = [[PastRoundCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    if (indexPath.section == 0)
    {
        cell.round = (Round *)[incompleteRounds objectAtIndex:indexPath.row];
    }
    else
    {
        cell.round = (Round *)[completeRounds objectAtIndex:indexPath.row];
    }

    [cell reloadLabels];
    return cell;
}

- (void)refreshRoundList:(NSMutableArray *)rounds
{
    allRounds = rounds;
    [self splitIntoCompletedAndNah];
    
    rh_dao.delegate = self;
    for (Round *r in allRounds)
    {
        [rh_dao matchRoundHolesWithRound:r.id_num];
    }
}

- (void)roundHolesForRound:(NSMutableArray *)roundHoles roundId:(NSNumber *)roundId
{
    for(Round *r in allRounds)
    {
        if (r.id_num == roundId)
        {
            r.roundHoles = roundHoles;
        }
    }
    
    for(Round *r in allRounds)
    {
        if (!r.roundHoles)
        {
            return;
        }
    }
    
    [tableView reloadData];
}

- (void)splitIntoCompletedAndNah
{
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

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return ![identifier isEqualToString:@"roundLookup"];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"roundLookup"])
    {
        // something
    }
}

-(NSString*)tableView:(UITableView *) tableView titleForHeaderInSection:(NSInteger)section
{
    return [sections objectAtIndex:section];
}

@end

//
//  PastRoundsVC.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/31/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import "PastRoundsVC.h"
#import "AlbatrossGolf-Swift.h"
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
    controller.round = round;
    [self.navigationController pushViewController:controller animated:YES];
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

-(NSString*)tableView:(UITableView *) tableView titleForHeaderInSection:(NSInteger)section
{
    return [sections objectAtIndex:section];
}

@end

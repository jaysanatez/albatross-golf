//
//  PastRoundsVC.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/31/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import "PastRoundsVC.h"
#import "PastRoundCell.h"
#import "Course.h"
#import "Round.h"
#import "RoundDAO.h"
#import "RoundLookupVC.h"

@interface PastRoundsVC ()
{
    RoundDAO *dao;
    NSArray *sections;
    NSMutableArray *completeRounds, *incompleteRounds;
}

@end

@implementation PastRoundsVC

@synthesize tableView;

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
    sections = [[NSArray alloc] initWithObjects:@"In Progress",@"Completed",nil];
    dao = [[RoundDAO alloc] init];
    [dao fetchAllRoundsForUser:[NSNumber numberWithInt:2] forDelegate:self];
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
    
    
    cell.round = (Round *)[completeRounds objectAtIndex:indexPath.row];
    [cell reloadLabels];
    
    return cell;
}

- (void)refreshRoundList:(NSMutableArray *)rounds
{
    [self splitIntoCompletedAndNah:rounds];
    [tableView reloadData];
}

- (void)splitIntoCompletedAndNah:(NSMutableArray *)allRounds
{
    for (Round *r in allRounds)
    {
        if (r.is_complete)
            [completeRounds addObject:r];
        else
            [incompleteRounds addObject:r];
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

//
//  RecentTeeChoiceVC.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 10/22/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import "RecentTeeChoiceVC.h"
#import "ScorecardVC.h"
#import "TeeChoiceCell.h"
#import "TeeDAO.h"
#import "Tee.h"

@interface RecentTeeChoiceVC ()
{
    TeeDAO *dao;
    int selectedRow;
    NSMutableArray *tees;
}

@end

@implementation RecentTeeChoiceVC

@synthesize playButton,moreButton,table,spinnerView,noTees,user;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *array = @[spinnerView, playButton, moreButton];
    for (UIView *v in array)
    {
        v.layer.cornerRadius = 8;
        v.layer.masksToBounds = YES;
    }
    
    dao = [[TeeDAO alloc] init];
    dao.delegate = self;
    [dao fetchTeesForUser:user.id_num];
    [self displayLoadingScreen:NO];
    selectedRow = -1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tees count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"TeeChoiceCell";
    
    TeeChoiceCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    if(cell == nil)
    {
        cell = [[TeeChoiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    cell.tee = (Tee *)tees[indexPath.row];
    [cell reloadLabels];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeeChoiceCell *cell = (TeeChoiceCell *)[table cellForRowAtIndexPath:indexPath];
    BOOL alreadyChecked = indexPath.row == selectedRow;
    cell.accessoryType = alreadyChecked ? UITableViewCellAccessoryNone : UITableViewCellAccessoryCheckmark;
    playButton.enabled = !alreadyChecked;
    selectedRow = alreadyChecked ? -1 : indexPath.row;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeeChoiceCell *cell = (TeeChoiceCell *)[table cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
}

- (void)refreshTeeList:(NSMutableArray *)teeList
{
    tees = teeList;
    noTees.hidden = [teeList count] != 0;
    [table reloadData];
    [self displayLoadingScreen:YES];
}

- (void)alertNoTeesFetched
{
    noTees.hidden = NO;
    [self displayLoadingScreen:YES];
}

- (void)displayLoadingScreen:(BOOL)fetchedCourses
{
    spinnerView.hidden = fetchedCourses;
}

- (void)pushScorecard:(id)sender
{
    ScorecardVC *controller = [[ScorecardVC alloc] init];
    NSIndexPath *path = [table indexPathForSelectedRow];
    Tee *t = (Tee *)[tees objectAtIndex:path.row];
    controller.tee = t;
    [self.navigationController pushViewController:controller animated:YES];
}

@end

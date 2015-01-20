//
//  RecentTeeChoiceVC.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 10/22/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import "RecentTeeChoiceVC.h"

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
    
    selectedRow = -1;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self displayLoadingScreen:NO];
    dao = [[TeeDAO alloc] init];
    tees = [dao fetchTeesForUser:user.id_num];
    [self displayLoadingScreen:YES];
    
    noTees.hidden = [tees count] != 0;
    [table reloadData];
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

- (void)alertNoTeesFetched
{
    noTees.hidden = NO;
    [self displayLoadingScreen:YES];
}

- (void)displayLoadingScreen:(BOOL)fetchedCourses
{
    ((UIView *)spinnerView).hidden = fetchedCourses;
}

- (void)pushScorecard:(id)sender
{
    ScorecardVC *controller = [[ScorecardVC alloc] init];
    
    // CONFIGURE THE SCORECARD
    Scorecard *sc = [[Scorecard alloc] init];
    NSIndexPath *path = [table indexPathForSelectedRow];
    Tee *t = (Tee *)[tees objectAtIndex:path.row];
    
    Course *c = [[Course alloc] init];
    c.id_num = t.course_id;
    c.name = t.course_name;
    
    sc.user = user;
    sc.course = c;
    sc.tee = t;
    
    controller.scorecard = sc;
    [self.navigationController pushViewController:controller animated:YES];
}

@end

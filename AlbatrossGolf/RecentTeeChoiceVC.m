//
//  RecentTeeChoiceVC.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 10/22/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import "RecentTeeChoiceVC.h"
#import "AppDelegate.h"

@interface RecentTeeChoiceVC ()
{
    TeeDAO *dao;
    Tee *selectedTee;
    NSMutableArray *tees;
}

@end

@implementation RecentTeeChoiceVC

@synthesize playButton,moreButton,table,spinnerView,noTees,user;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    user = [delegate getActiveUser];
    
    ((UIView *)spinnerView).layer.cornerRadius = 8;
    ((UIView *)spinnerView).layer.masksToBounds = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self displayLoadingScreen:YES];
    dao = [[TeeDAO alloc] init];
    tees = [dao fetchTeesForUser:user.id_num];
    [self displayLoadingScreen:NO];
    
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
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.tee = (Tee *)tees[indexPath.row];
    cell.accessory.image = cell.tee == selectedTee ? [UIImage imageNamed:@"checkmark"] : [UIImage imageNamed:@"box"];
    [cell reloadLabels];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeeChoiceCell *cell = (TeeChoiceCell *)[table cellForRowAtIndexPath:indexPath];
    BOOL alreadyChecked = cell.tee == selectedTee;
    cell.accessory.image = alreadyChecked ? [UIImage imageNamed:@"box"] : [UIImage imageNamed:@"checkmark"];
    playButton.enabled = !alreadyChecked;
    selectedTee = alreadyChecked ? nil : cell.tee;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeeChoiceCell *cell = (TeeChoiceCell *)[table cellForRowAtIndexPath:indexPath];
    cell.accessory.image = [UIImage imageNamed:@"box"];
}

- (void)displayLoadingScreen:(BOOL)show
{
    ((UIView *)spinnerView).hidden = !show;
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

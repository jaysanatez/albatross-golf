//
//  TeeChoiceVC.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 10/18/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import "TeeChoiceVC.h"

@interface TeeChoiceVC ()
{
    TeeDAO *dao;
    Tee *selectedTee;
    NSMutableArray *tees;
}

@end

@implementation TeeChoiceVC

@synthesize course, courseName, table, beginButton, loading_throbber;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ((UIView *)loading_throbber).layer.cornerRadius = 8;
    ((UIView *)loading_throbber).layer.masksToBounds = YES;
        
    dao = [[TeeDAO alloc] init];
    
    courseName.text = course.name;
    courseName.adjustsFontSizeToFitWidth = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self displayLoadingView:YES];
    tees = [dao fetchTeesForCourse:course.id_num];
    [self displayLoadingView:NO];
    [table reloadData];
}

- (void)displayLoadingView:(BOOL)show
{
    ((UIView *)loading_throbber).hidden = !show;
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
    beginButton.enabled = !alreadyChecked;
    selectedTee = alreadyChecked ? nil : cell.tee;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeeChoiceCell *cell = (TeeChoiceCell *)[table cellForRowAtIndexPath:indexPath];
    cell.accessory.image = [UIImage imageNamed:@"box"];
}

- (void)alertNoTeesFetched
{
    NSLog(@"No Tees Fetched");
}

- (void)pushScorecard:(id)sender
{
    ScorecardVC *controller = [[ScorecardVC alloc] initWithNibName:@"ScorecardVC" bundle:[NSBundle mainBundle]];
    
    // CONFIGURE THE SCORECARD
    Scorecard *sc = [[Scorecard alloc] init];
    Tee *t = selectedTee;
    
    Course *c = [[Course alloc] init];
    c.id_num = t.course_id;
    c.name = t.course_name;
    
    sc.course = c;
    sc.tee = t;
    
    controller.scorecard = sc;
    [self.navigationController pushViewController:controller animated:YES];
}

@end

//
//  TeeChoiceVC.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 10/18/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import "TeeChoiceVC.h"
#import "TeeDAO.h"
#import "TeeChoiceCell.h"
#import "ScorecardVC.h"

@interface TeeChoiceVC ()
{
    TeeDAO *dao;
    int selectedRow;
    NSMutableArray *tees;
}

@end

@implementation TeeChoiceVC

@synthesize course, courseName, table, beginButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // button borders
    beginButton.layer.borderWidth = 1.0f;
    beginButton.layer.borderColor = [UIColor whiteColor].CGColor;
    beginButton.layer.cornerRadius = 8;
    beginButton.layer.masksToBounds = YES;
        
    dao = [[TeeDAO alloc] init];
    [dao fetchTeesForCourse:course.id_num withDelegate:self];
    courseName.text = course.name;
    courseName.adjustsFontSizeToFitWidth = YES;
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
    beginButton.enabled = !alreadyChecked;
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
    [table reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"beginRound"])
    {
        Scorecard *controller = [segue destinationViewController];
        controller.courseId = course.id_num;
        controller.courseName = course.name;
        NSIndexPath *path = [table indexPathForSelectedRow];
        controller.teeId = ((Tee *)[tees objectAtIndex:path.row]).id_num;

    }
}

@end

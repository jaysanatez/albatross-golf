//
//  CourseChoiceController.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/21/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import "CourseChoiceVC.h"
#import "CourseChoiceCell.h"
#import "TeeChoiceVC.h"

@interface CourseChoice ()
{
    CourseDAO *dao;
    int selectedRow;
    NSMutableArray *courses;
}

@end

@implementation CourseChoice

@synthesize table, previousPage, nextPage, spinnerView, searchField, segment, noCoursesLabel, continueButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *array = @[spinnerView, continueButton, previousPage, nextPage];
    for (UIView *v in array)
    {
        v.layer.cornerRadius = 8;
        v.layer.masksToBounds = YES;
    }
    
    // button borders
    continueButton.layer.borderWidth = 1.0f;
    continueButton.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:102.0/255.5
                                                                        green:1.0
                                                                         blue:102.0/255.0
                                                                        alpha:0.8];
    selectedRow = -1;
    dao = [[CourseDAO alloc] init];
    [self showAllCourses];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [courses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CourseChoiceCell";
    
    CourseChoiceCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    if(cell == nil)
    {
        cell = [[CourseChoiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    BOOL b = (indexPath.row == selectedRow);
    cell.accessoryType = b ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        
    cell.course = (Course *)courses[indexPath.row];
    [cell reloadLabels];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseChoiceCell *cell = (CourseChoiceCell *)[table cellForRowAtIndexPath:indexPath];
    BOOL alreadyChecked = indexPath.row == selectedRow;
    cell.accessoryType = alreadyChecked ? UITableViewCellAccessoryNone : UITableViewCellAccessoryCheckmark;
    continueButton.enabled = !alreadyChecked;
    selectedRow = alreadyChecked ? -1 : indexPath.row;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseChoiceCell *cell = (CourseChoiceCell *)[table cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
}

- (IBAction)searchByTapped:(id)sender
{
    [searchField resignFirstResponder];
    [self displayLoadingScreen:YES];
    selectedRow = -1;
    continueButton.enabled = NO;
    NSInteger index = [segment selectedSegmentIndex];
    NSString *searchString = searchField.text;
    switch (index)
    {
        case 0:
            [dao fetchCoursesSearchByKeyword:searchString];
            break;
        case 1:
            [dao fetchCoursesSearchByCity:searchString];
            break;
        case 2:
            [dao fetchCoursesSearchByState:searchString];
            break;
        default:
            break;
    }
}

- (void)showAllCourses
{
    [self displayLoadingScreen:YES];
    dao.delegate = self;
    [dao fetchFirstPaginatedCourses];
}

- (IBAction)clearSearchParameters:(id)sender
{
    searchField.text = @"";
    [self showAllCourses];
}

- (void)refreshCourseList:(NSMutableArray *)array
{
    courses = array;
    [self displayLoadingScreen:NO];
    [self.table reloadData];
    [self scrollTableToTop];
    noCoursesLabel.hidden = [array count] != 0;
}

- (void)alertNoCoursesFetched
{
    [self displayLoadingScreen:NO];
    noCoursesLabel.hidden = NO;
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"No Courses found."
                                                   message:@"Either your network connection isn't strong enough or we are experiencing technical difficulties."
                                                  delegate:nil
                                         cancelButtonTitle:@"Okay"
                                         otherButtonTitles:nil];
    [view show];
}

- (void)displayLoadingScreen:(BOOL)show
{
    ((UIView *)spinnerView).hidden = !show;
}

- (IBAction)showPrevPagination:(id)sender
{
    [self displayLoadingScreen:YES];
    dao.delegate = self;
    [dao fetchPreviousPaginatedBatch];
}

- (IBAction)showNextPagination:(id)sender
{
    [self displayLoadingScreen:YES];
    dao.delegate = self;
    [dao fetchNextPaginatedBatch];
}

- (void)setPrevButton:(BOOL)prev andNext:(BOOL)next
{
    previousPage.enabled = prev;
    nextPage.enabled = next;
}

- (void)scrollTableToTop
{
    if([courses count] > 0)
    {
        [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"selectTee"])
    {
        TeeChoiceVC *controller = [segue destinationViewController];
        NSIndexPath *path = [table indexPathForSelectedRow];
        controller.course = (Course *)[courses objectAtIndex:path.row];
    }
}

@end

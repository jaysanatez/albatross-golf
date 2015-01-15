//
//  Menu.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/5/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import "MenuVC.h"

@interface ViewController (){
    NSArray *menuOptions;
}

@end

@implementation ViewController

@synthesize tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Menu";
    
    menuOptions = [[NSArray alloc] initWithObjects:
                   @"New Round", @"Past Rounds", @"Multi-Round Statistics",@"Comparative Statistics",@"About Smart Shot",nil];
    
    BOOL is4InchScreen = [[UIScreen mainScreen] bounds].size.height == 568;
    tableView.rowHeight = is4InchScreen ? 70 : 55;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView: (UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection: (NSInteger)section
{
    return [menuOptions count];
}

// customize the appearance of table view cells
- (UITableViewCell *)tableView: (UITableView *)tabView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    static NSString *cellIdentifier;
    
    if(indexPath.row == 0)
        cellIdentifier = @"goToChooseCourse";
    else if(indexPath.row == 1)
        cellIdentifier = @"goToPastRounds";
    else if (indexPath.row == 2)
        cellIdentifier = @"goToMultiStats";
    else if (indexPath.row == 3)
        cellIdentifier = @"goToCompStats";
    else
        cellIdentifier = @"goToAbout";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    // configure the cell
    cell.textLabel.text = [menuOptions objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont fontWithName:@"Iowan Old Style" size:18];
    
    // cell.imageView.image = [UIImage imageNamed:[menuThumbs objectAtIndex:indexPath.row]];
    cell.backgroundColor = [UIColor clearColor];
    
    UIView *selectedBG = [[UIView alloc] init];
    [selectedBG setBackgroundColor:[UIColor colorWithRed:102.0/255.5 green:1.0 blue:102.0/255.0 alpha:0.8]];
    [cell setSelectedBackgroundView: selectedBG];
    
    UIView *normalBG = [[UIView alloc] init];
    [normalBG setBackgroundColor:[UIColor whiteColor]];
    [cell setBackgroundView:normalBG];
    
    return cell;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (void)logout:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

@end
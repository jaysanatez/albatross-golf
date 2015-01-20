//
//  CustomGameList.m
//  SmartShot_2.1
//
//  Created by Jacob Sanchez on 8/28/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

/*#import "CustomGameList.h"

@implementation CustomGameList

@synthesize tableView,games;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
/*
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [games count];
}

-(UITableViewCell *)tableView:(UITableView *)tabView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"customGameCell";
    CustomSelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil)
        cell = [[CustomSelectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    
    
    Game *g = (Game *)[games objectAtIndex:indexPath.row];
    cell.course.text = g.coursePlayed.courseName;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    cell.date.text = [formatter stringFromDate:g.datePlayed];
    cell.score.text = [NSString stringWithFormat:@"%i",[self totalScore:g]];
    return cell;
}

-(int)totalScore:(Game *)g
{
    int score = 0;
    for (NSNumber *n in g.holeScores)
        score += [n intValue];
    return score;
}

-(void)tableView:(UITableView *)tabView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *tableViewCell = [tableView cellForRowAtIndexPath:indexPath];
    tableViewCell.accessoryView.hidden = NO;
    tableViewCell.accessoryType = UITableViewCellAccessoryCheckmark;
}

-(void)tableView:(UITableView *)tabView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *tableViewCell = [tableView cellForRowAtIndexPath:indexPath];
    tableViewCell.accessoryView.hidden = YES;
    tableViewCell.accessoryType = UITableViewCellAccessoryNone;
}

-(NSMutableArray *)getSelectedGames
{
    NSMutableArray *selectedGames = [[NSMutableArray alloc] initWithObjects:nil];
    
    NSArray *selectedIndices = [tableView indexPathsForSelectedRows];
    for(NSIndexPath *path in selectedIndices)
    {
        [selectedGames addObject:[games objectAtIndex:path.row]];
    }
    
    return selectedGames;
}


@end*/

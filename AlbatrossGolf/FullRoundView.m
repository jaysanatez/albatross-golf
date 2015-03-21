//
//  FullRoundView.m
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 3/21/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import "FullRoundView.h"
#import "FullRoundTableViewCell.h"

@implementation FullRoundView
{
    NSMutableArray *rowHoleNums;
    long numCells;
}

- (FullRoundView *)initWithHoleScores:(NSMutableArray *)scores
{
    self = [super init];
    if(self)
    {
        _holeScores = [scores copy];
        
        long fullNines = _holeScores.count / 9;
        numCells = _holeScores.count % 9 != 0 ? fullNines + 1 : fullNines;
        
        rowHoleNums = [[NSMutableArray alloc] initWithCapacity:numCells];
        for (int i=0; i<numCells; i++) { rowHoleNums[i] = [[NSMutableArray alloc] init]; }
        
        int num = 0;
        int row = 0;
        for (id obj in _holeScores)
        {
            [((NSMutableArray *)rowHoleNums[row]) addObject:obj];
            num++;
            if(num % 9 == 0)
            {
                row++;
            }
        }
    }
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return numCells;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FullRoundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FullRoundCell"];
    if (cell == nil)
    {
        cell = [[FullRoundTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FullRoundCell"];
    }

    cell.holes = rowHoleNums[indexPath.row];
    [cell configureDisplay];
    return cell;
}

@end

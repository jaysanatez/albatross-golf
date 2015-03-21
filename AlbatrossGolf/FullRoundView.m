//
//  FullRoundView.m
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 3/21/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import "FullRoundView.h"

@implementation FullRoundView
{
    NSMutableArray *rowHoleNums;
}

- (FullRoundView *)initWithHoleScores:(NSMutableArray *)scores
{
    self = [super init];
    if(self)
    {
        _holeScores = scores;
    }
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    long fullNines = _holeScores.count / 9;
    return _holeScores.count % 9 != 0 ? fullNines + 1 : fullNines;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FullRoundCell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FullRoundCell"];
    }

    return cell;
}

@end

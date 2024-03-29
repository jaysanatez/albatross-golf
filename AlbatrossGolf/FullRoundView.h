//
//  FullRoundView.h
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 3/21/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import <UIKit/UIKit.h>

@interface FullRoundView : UIView <UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *holeScores;

- (void)configureNumbers;
- (FullRoundView *)initWithHoleScores:(NSMutableArray *)scores;

@end

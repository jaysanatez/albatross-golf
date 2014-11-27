//
//  RoundLookupVC.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/31/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

@interface RoundLookupVC : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) Game *game;
@property (nonatomic, strong) IBOutlet UICollectionView *collecView;
@property (nonatomic, strong) NSMutableArray *holeStats, *holeStatsFromDB;
@property (nonatomic, strong) IBOutlet UILabel *statsLabel;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end

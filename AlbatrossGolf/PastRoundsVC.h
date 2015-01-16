//
//  PastRoundsVC.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/31/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import <UIKit/UIKit.h>
#import "RoundDAO.h"
#import "RoundHoleDAO.h"
#import "RoundStats.h"
#import "RoundStatsDAO.h"

@interface PastRoundsVC : UIViewController <UITableViewDelegate, UITableViewDataSource, RoundFetchDelegate, RoundHoleFetchDelegate, RoundStatsFetchDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

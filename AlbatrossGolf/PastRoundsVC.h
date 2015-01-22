//
//  PastRoundsVC.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/31/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import <UIKit/UIKit.h>
#import "RoundDAO.h"
#import "RoundStats.h"
#import "User.h"
#import "Course.h"
#import "Round.h"
#import "RoundLookupVC.h"
#import "Delegates.h"
@class LoadingThrobberView;

@interface PastRoundsVC : UIViewController <UITableViewDelegate, UITableViewDataSource, RoundFetchDelegate, RoundUpdateDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet LoadingThrobberView *loadingView;
@property User *user;


@end

//
//  PastRoundsVC.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/31/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PastRoundsVC : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

-(void)refreshRoundList:(NSMutableArray *)rounds;

@end

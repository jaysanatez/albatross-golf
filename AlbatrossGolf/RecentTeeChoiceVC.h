//
//  RecentTeeChoiceVC.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 10/22/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import <UIKit/UIKit.h>
#import "TeeDAO.h"

@interface RecentTeeChoiceVC : UIViewController<UITableViewDelegate, UITableViewDataSource, TeeFetchDelegate>

@property (nonatomic, weak) IBOutlet UIButton *playButton, *moreButton;
@property (nonatomic, weak) IBOutlet UIView *spinnerView;
@property (nonatomic, weak) IBOutlet UILabel *noTees;
@property (nonatomic, weak) IBOutlet UITableView *table;

-(IBAction)pushScorecard:(id)sender;

@end

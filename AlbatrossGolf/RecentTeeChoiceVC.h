//
//  RecentTeeChoiceVC.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 10/22/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import <UIKit/UIKit.h>
#import "User.h"
#import "TeeDAO.h"
@class LoadingThrobberView;

@interface RecentTeeChoiceVC : UIViewController<UITableViewDelegate, UITableViewDataSource, TeeFetchDelegate>

@property (nonatomic, weak) IBOutlet UIButton *playButton, *moreButton;
@property (nonatomic, weak) IBOutlet LoadingThrobberView *spinnerView;
@property (nonatomic, weak) IBOutlet UILabel *noTees;
@property (nonatomic, weak) IBOutlet UITableView *table;
@property User *user;

-(IBAction)pushScorecard:(id)sender;

@end

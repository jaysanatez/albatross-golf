//
//  TeeChoiceVC.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 10/18/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import <UIKit/UIKit.h>
#import "Course.h"
#import "TeeDAO.h"
#import "TeeChoiceCell.h"
#import "ScorecardVC.h"
@class LoadingThrobberView;

@interface TeeChoiceVC : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UILabel *courseName;
@property (nonatomic, weak) IBOutlet UITableView *table;
@property (nonatomic, weak) Course *course;
@property (nonatomic, weak) IBOutlet UIButton *beginButton;
@property (nonatomic, weak) IBOutlet LoadingThrobberView *loading_throbber;

-(IBAction)pushScorecard:(id)sender;

@end

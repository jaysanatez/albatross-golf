//
//  RootMenuVC.h
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/14/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import <UIKit/UIKit.h>

@interface RootMenuVC : UIViewController

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *viewLeftConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *viewWidthConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *menuViewWidthConstraint;

- (IBAction)expandMenuTapped:(id)sender;
- (IBAction)logoutTapped:(id)sender;

- (IBAction)homeViewTapped:(id)sender;
- (IBAction)playRoundTapped:(id)sender;
- (IBAction)pastRoundsTapped:(id)sender;
- (IBAction)multiRoundStatsTapped:(id)sender;
- (IBAction)compStatsTapped:(id)sender;

@end

//
//  RootMenuVC.m
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/14/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import "RootMenuVC.h"

@interface RootMenuVC ()
{
    NSInteger device_width;
}

@end

static int offset = 16;

@implementation RootMenuVC

@synthesize viewLeftConstraint, viewWidthConstraint, menuViewWidthConstraint;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    device_width = [UIScreen mainScreen].bounds.size.width;
    viewWidthConstraint.constant = device_width;
    menuViewWidthConstraint.constant = device_width / 2;
}

- (void)expandMenuTapped:(id)sender
{
    [self expandMenu];
}

- (void)homeViewTapped:(id)sender
{
    [self collapseMenu];
}

- (void)playRoundTapped:(id)sender
{
    [self collapseMenu];
}

- (void)pastRoundsTapped:(id)sender
{
    [self collapseMenu];
}

- (void)multiRoundStatsTapped:(id)sender
{
    [self collapseMenu];
}

- (void)compStatsTapped:(id)sender
{
    [self collapseMenu];
}

- (void)expandMenu
{
    viewLeftConstraint.constant = device_width / 2 - offset;
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)collapseMenu
{
    viewLeftConstraint.constant = -1 * offset;
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)logoutTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

//
//  LoginVC.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 10/20/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import "LoginVC.h"

@interface LoginVC ()

@end

@implementation LoginVC

@synthesize userName, password, loginButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    userName.layer.borderColor = [UIColor blackColor].CGColor;
    userName.layer.borderWidth = 1.5f;
    userName.layer.cornerRadius = 8;
    userName.layer.masksToBounds = YES;
    
    password.layer.borderColor = [UIColor blackColor].CGColor;
    password.layer.borderWidth = 1.0f;
    password.layer.cornerRadius = 8;
    password.layer.masksToBounds = YES;
    
    loginButton.layer.cornerRadius = 8;
    loginButton.layer.masksToBounds = YES;
    
    UIView *userNamePaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 40)];
    userName.leftView = userNamePaddingView;
    userName.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *passwordPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 40)];
    password.leftView = passwordPaddingView;
    password.leftViewMode = UITextFieldViewModeAlways;
}

@end

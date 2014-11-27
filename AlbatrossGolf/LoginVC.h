//
//  LoginVC.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 10/20/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginVC : UIViewController

@property (nonatomic, weak) IBOutlet UITextField *userName, *password;
@property (nonatomic, weak) IBOutlet UIButton *loginButton;

@end

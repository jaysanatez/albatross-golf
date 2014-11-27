//
//  CustomDropDown.h
//  SmartShot_2.1
//
//  Created by Jacob Sanchez on 8/27/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomGameList.h"

@interface CustomDropDown : UIView

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *heightConstraint;
@property (nonatomic, strong) CustomGameList *gameList;
@property (nonatomic, strong) UIViewController *parentController;
-(void)expandView:(int)height;

@end

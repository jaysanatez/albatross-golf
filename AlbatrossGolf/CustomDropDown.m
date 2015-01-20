//
//  CustomDropDown.m
//  SmartShot_2.1
//
//  Created by Jacob Sanchez on 8/27/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import "CustomDropDown.h"

@implementation CustomDropDown

@synthesize heightConstraint,gameList,parentController;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)expandView:(int)height
{
    heightConstraint.constant = height;
    [UIView animateWithDuration:0.4f animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished){
        gameList.hidden = NO;
    }];
}

-(IBAction)collapseAndSelect:(id)sender
{
    gameList.hidden = YES;
    heightConstraint.constant = 0;
    [UIView animateWithDuration:0.4f animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished){
        [(MGStatsViewVC *)parentController checkCustomGameSet];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

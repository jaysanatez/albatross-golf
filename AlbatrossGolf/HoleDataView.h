//
//  HoleDataView.h
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/19/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import <UIKit/UIKit.h>

@protocol HoleDataViewDelegate

- (void)finishedWithHole;

@end

@interface HoleDataView : UIView

@property (nonatomic, weak) IBOutlet UIView *view;

@property (nonatomic, weak) id <HoleDataViewDelegate> delegate;
- (IBAction)finishTapped:(id)sender;

@end

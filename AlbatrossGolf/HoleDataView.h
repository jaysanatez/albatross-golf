//
//  HoleDataView.h
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/19/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import <UIKit/UIKit.h>
#import "RoundHole.h"
#import "Delegates.h"

@interface HoleDataView : UIView

@property (nonatomic, weak) IBOutlet UIView *view;
@property RoundHole *round_hole;
@property (nonatomic, weak) id <HoleDataViewDelegate> delegate;

- (IBAction)finishTapped:(id)sender;
- (void)displayRoundHole:(RoundHole *)rh;

@end

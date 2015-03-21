//
//  HoleDataView.h
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/19/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import <UIKit/UIKit.h>
#import "RoundHole.h"
#import "Protocols.h"

@interface HoleDataView : UIView

@property (nonatomic, weak) IBOutlet UILabel *score_label, *putts_label, *penalties_label, *fairway_hit_label;
@property (nonatomic, weak) IBOutlet UILabel *gir_label, *fairway_bunker_label, *green_bunker_label;
@property (nonatomic, weak) IBOutlet UIView *view;
@property RoundHole *round_hole;
@property (nonatomic, weak) id <HoleDataViewDelegate> delegate;

- (IBAction)finishTapped:(id)sender;
- (void)displayRoundHole:(RoundHole *)rh;
- (void)setHeight:(CGFloat)height;

@end

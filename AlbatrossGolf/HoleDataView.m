//
//  HoleDataView.m
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/19/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import "HoleDataView.h"

@implementation HoleDataView

@synthesize view, delegate, round_hole, score_label, putts_label, penalties_label, fairway_hit_label, gir_label, fairway_bunker_label, green_bunker_label;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    [[NSBundle mainBundle] loadNibNamed:@"HoleDataView" owner:self options:nil];
    [self addSubview:view];
    
    return self;
}

- (void)setHeight:(CGFloat)height
{
    CGFloat x = CGRectGetMinX(self.view.frame);
    CGFloat y = CGRectGetMinY(self.view.frame);
    CGFloat width = CGRectGetWidth(self.view.frame);
    self.view.frame = CGRectMake(x, y, width, height);
}

- (void)finishTapped:(id)sender
{
    [delegate finishedWithHole:round_hole];
}

- (void)displayRoundHole:(RoundHole *)rh
{
    round_hole = rh;
    [self refreshDisplay];
}

- (void)refreshDisplay
{
    score_label.text = [NSString stringWithFormat:@"Score: %li",round_hole.score];
    putts_label.text = [NSString stringWithFormat:@"Putts: %li",round_hole.putts];
    penalties_label.text = [NSString stringWithFormat:@"Penalties: %li",round_hole.penalties];
    
    fairway_hit_label.text = round_hole.hitFairway ? @"Hit Fairway" : @"Missed Fairway";
    gir_label.text = round_hole.hitGir ? @"Hit Green" : @"Missed Green";
    fairway_bunker_label.text = round_hole.hitFairwayBunker ? @"Fairway Bunker" : @"No Fairway Bunker";
    green_bunker_label.text = round_hole.hitGreensideBunker ? @"Greenside Bunker" : @"No Greenside Bunker";
}

@end

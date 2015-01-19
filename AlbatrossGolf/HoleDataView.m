//
//  HoleDataView.m
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/19/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import "HoleDataView.h"

@implementation HoleDataView

@synthesize view, delegate;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    [[NSBundle mainBundle] loadNibNamed:@"HoleDataView" owner:self options:nil];
    [self addSubview:view];
    
    return self;
}

- (void)finishTapped:(id)sender
{
    [delegate finishedWithHole];
}

@end

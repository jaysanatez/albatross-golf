//
//  HorizontalSlider.m
//  SmartShot_2.1
//
//  Created by Jacob Sanchez on 7/22/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import "HorizontalSlider.h"

@implementation HorizontalSlider

@synthesize itemTitles,currentItem,prevItem,nextItem,selectedItemIndex;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        selectedItemIndex = 0;
    }
    return self;
}

- (void)displayTitles
{
    int count = [itemTitles count];
    int prevTitleIndex = (selectedItemIndex + count - 1) % count;
    int nextTitleIndex = (selectedItemIndex + 1) % count;
    
    prevItem.text = [itemTitles objectAtIndex:prevTitleIndex];
    currentItem.text = [itemTitles objectAtIndex:selectedItemIndex];
    nextItem.text = [itemTitles objectAtIndex:nextTitleIndex];
}

- (IBAction)displayPreviousItem:(id)sender
{
    selectedItemIndex += [itemTitles count] - 1;
    selectedItemIndex %= [itemTitles count];
    [self displayTitles];
}

- (IBAction)displayNextItem:(id)sender
{
    selectedItemIndex++;
    selectedItemIndex %= [itemTitles count];
    [self displayTitles];
}

@end

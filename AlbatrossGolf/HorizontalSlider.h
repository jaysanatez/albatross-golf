//
//  HorizontalSlider.h
//  SmartShot_2.1
//
//  Created by Jacob Sanchez on 7/22/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HorizontalSlider : UIView

@property int selectedItemIndex;
@property (nonatomic, strong) NSMutableArray *itemTitles;
@property (nonatomic, strong) IBOutlet UILabel *currentItem, *prevItem, *nextItem;

- (IBAction)displayPreviousItem:(id)sender;
- (IBAction)displayNextItem:(id)sender;
- (void)displayTitles;

@end

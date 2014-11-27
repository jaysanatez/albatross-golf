//
//  TeeChoiceCell.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 10/19/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tee.h"

@interface TeeChoiceCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *name, *rating, *slope, *gender;
@property (nonatomic, weak) Tee *tee;

- (void)reloadLabels;

@end

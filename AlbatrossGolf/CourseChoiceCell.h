//
//  CourseChoiceCell.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 10/15/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"

@interface CourseChoiceCell : UITableViewCell

@property (nonatomic, weak) Course *course;
@property (nonatomic, weak) IBOutlet UILabel *name, *location;

- (void)reloadLabels;

@end

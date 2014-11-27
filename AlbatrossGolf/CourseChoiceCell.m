//
//  CourseChoiceCell.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 10/15/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import "CourseChoiceCell.h"

@implementation CourseChoiceCell

@synthesize course, name, location;

- (void)awakeFromNib
{
    
}

- (void)reloadLabels
{
    name.adjustsFontSizeToFitWidth = YES;
    name.text = course.name;
    location.text = [NSString stringWithFormat:@"%@, %@",course.city,course.state];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end

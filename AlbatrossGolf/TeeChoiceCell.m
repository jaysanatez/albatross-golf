//
//  TeeChoiceCell.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 10/19/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import "TeeChoiceCell.h"

@implementation TeeChoiceCell

@synthesize tee, name, slope, rating, gender;

- (void)awakeFromNib
{
    
}

- (void)reloadLabels
{
    name.adjustsFontSizeToFitWidth = YES;
    name.text = [NSString stringWithFormat:@"%@ - %@ Tees",tee.course_name,tee.name];
    slope.text = [NSString stringWithFormat:@"Slope: %d",[tee.slope intValue]];
    rating.text = [NSString stringWithFormat:@"Rating: %0.1f",[tee.rating doubleValue]];
    gender.text = tee.isMale ? @"Men's" : @"Women's";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end

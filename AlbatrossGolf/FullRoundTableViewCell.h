//
//  FullRoundTableViewCell.h
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 3/21/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FullRoundCellContainer.h"

@interface FullRoundTableViewCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray *holes;
@property (nonatomic, strong) IBOutlet FullRoundCellContainer *frc1, *frc2, *frc3;

- (void)configureDisplay;

@end

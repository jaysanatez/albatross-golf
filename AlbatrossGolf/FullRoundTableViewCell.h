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
@property (nonatomic, strong) IBOutlet FullRoundCellContainer *frc1, *frc2, *frc3, *frc4, *frc5, *frc6, *frc7, *frc8, *frc9, *frcTotal;

- (void)configureDisplay;

@end

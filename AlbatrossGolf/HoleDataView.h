//
//  HoleDataView.h
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/19/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import <UIKit/UIKit.h>
#import "RoundHole.h"
#import "Protocols.h"

#define selectedBackground [UIColor whiteColor]
#define unselectedBackground [UIColor clearColor]
#define selectedText [UIColor blackColor]
#define unselectedText [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5]

@interface HoleDataView : UIView

@property (nonatomic, weak) IBOutlet UILabel *score_label, *putts_label, *penalties_label;
@property (nonatomic, weak) IBOutlet UILabel *gir_label, *fairway_bunker_label, *green_bunker_label;
@property (nonatomic, weak) IBOutlet UIView *view;
@property (nonatomic, weak) IBOutlet UIButton *fairwayYes, *fairwayNo, *greenYes, *greenNo, *fairwayBunkYes;
@property (nonatomic, weak) IBOutlet UIButton *fairwayBunkNo, *greenBunkYes, *greenBunkNo;
@property RoundHole *round_hole;
@property (nonatomic, weak) id <HoleDataViewDelegate> delegate;

- (IBAction)finishTapped:(id)sender;
- (void)displayRoundHole:(RoundHole *)rh;
- (void)setHeight:(CGFloat)height;

- (IBAction)increaseScore:(id)sender;
- (IBAction)decreaseScore:(id)sender;

- (IBAction)increasePutts:(id)sender;
- (IBAction)decreasePutts:(id)sender;

- (IBAction)increasePenalties:(id)sender;
- (IBAction)decreasePenalties:(id)sender;


- (IBAction)fairwayYesTapped:(id)sender;
- (IBAction)fairwayNoTapped:(id)sender;

- (IBAction)greenYesTapped:(id)sender;
- (IBAction)greenNoTapped:(id)sender;

- (IBAction)fairwayBunkYesTapped:(id)sender;
- (IBAction)fairwayBunkNoTapped:(id)sender;

- (IBAction)greenBunkYesTapped:(id)sender;
- (IBAction)greenBunkNoTapped:(id)sender;

@end

//
//  HoleDataView.m
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/19/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import "HoleDataView.h"

@implementation HoleDataView

@synthesize view, delegate, round_hole, score_label, putts_label, penalties_label, gir_label, fairway_bunker_label, green_bunker_label;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    [[NSBundle mainBundle] loadNibNamed:@"HoleDataView" owner:self options:nil];
    [self addSubview:view];
    
    NSArray *buttons = @[_fairwayYes, _fairwayNo, _greenYes, _greenNo, _fairwayBunkYes, _fairwayBunkNo, _greenBunkYes, _greenBunkNo];
    for (UIButton *b in buttons)
    {
        b.layer.cornerRadius = 3;
        b.clipsToBounds = YES;
    }
    
    return self;
}

- (void)setHeight:(CGFloat)height
{
    CGFloat x = CGRectGetMinX(self.view.frame);
    CGFloat y = CGRectGetMinY(self.view.frame);
    CGFloat width = CGRectGetWidth(self.view.frame);
    self.view.frame = CGRectMake(x, y, width, height);
}

- (void)finishTapped:(id)sender
{
    [delegate finishedWithHole:round_hole];
}

- (void)displayRoundHole:(RoundHole *)rh
{
    round_hole = rh;
    
    [self refreshDisplay];
}

- (void)refreshDisplay
{
    score_label.text = [NSString stringWithFormat:@"Score: %li",round_hole.score];
    putts_label.text = [NSString stringWithFormat:@"Putts: %li",round_hole.putts];
    penalties_label.text = [NSString stringWithFormat:@"Penalties: %li",round_hole.penalties];
    
    [self setFairwayHit:round_hole.hitFairway];
    [self setGreenHit:round_hole.hitGir];
    [self setFairwayBunkHit:round_hole.hitFairwayBunker];
    [self setGreenBunkHit:round_hole.hitGreensideBunker];
}

- (void)fairwayNoTapped:(id)sender
{
    [self setFairwayHit:NO];
}

- (void)fairwayYesTapped:(id)sender
{
    [self setFairwayHit:YES];
}

- (void)setFairwayHit:(BOOL)hit
{
    round_hole.hitFairway = hit;
    [self styleButtonsOnButton:hit?_fairwayYes:_fairwayNo offButton:hit?_fairwayNo:_fairwayYes];
}

- (void)greenYesTapped:(id)sender
{
    [self setGreenHit:YES];
}

- (void)greenNoTapped:(id)sender
{
    [self setGreenHit:NO];
}

- (void)setGreenHit:(BOOL)hit
{
    round_hole.hitGir = hit;
    [self styleButtonsOnButton:hit?_greenYes:_greenNo offButton:hit?_greenNo:_greenYes];
}

- (void)fairwayBunkYesTapped:(id)sender
{
    [self setFairwayBunkHit:YES];
}

- (void)fairwayBunkNoTapped:(id)sender
{
    [self setFairwayBunkHit:NO];
}

- (void)setFairwayBunkHit:(BOOL)hit
{
    round_hole.hitFairwayBunker = hit;
    [self styleButtonsOnButton:hit?_fairwayBunkYes:_fairwayBunkNo offButton:hit?_fairwayBunkNo:_fairwayBunkYes];
}

- (void)greenBunkYesTapped:(id)sender
{
    [self setGreenBunkHit:YES];
}

- (void)greenBunkNoTapped:(id)sender
{
    [self setGreenBunkHit:NO];
}

- (void)setGreenBunkHit:(BOOL)hit
{
    round_hole.hitGreensideBunker = hit;
    [self styleButtonsOnButton:hit?_greenBunkYes:_greenBunkNo offButton:hit?_greenBunkNo:_greenBunkYes];
}

- (void)styleButtonsOnButton:(UIButton *)on offButton:(UIButton *)off
{
    on.backgroundColor = selectedBackground;
    off.backgroundColor = unselectedBackground;
    
    on.titleLabel.textColor = selectedText;
    off.titleLabel.textColor = unselectedText;
}

- (void)increaseScore:(id)sender
{
    round_hole.score++;
    [self refreshDisplay];
}

- (void)decreaseScore:(id)sender
{
    round_hole.score--;
    [self refreshDisplay];
}

- (void)increasePutts:(id)sender
{
    round_hole.putts++;
    [self refreshDisplay];
}

- (void)decreasePutts:(id)sender
{
    round_hole.putts--;
    [self refreshDisplay];
}

- (void)increasePenalties:(id)sender
{
    round_hole.penalties++;
    [self refreshDisplay];
}

- (void)decreasePenalties:(id)sender
{
    round_hole.penalties--;
    [self refreshDisplay];
}

@end

//
//  RoundLookupVC.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/31/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import "RoundLookupVC.h"

@interface RoundLookupVC ()

@end

@implementation RoundLookupVC

@synthesize round, collecView, statsLabel, tableView, finalizeButtonHeight, finalizeButton, delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [collecView registerNib:[UINib nibWithNibName:@"HoleLookupCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HoleLookup"];
    [tableView registerNib:[UINib nibWithNibName:@"HoleLookupTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"RoundStat"];
    self.title = @"Round Lookup";
    
    if (!round.is_complete)
    {
        statsLabel.text = @"Complete for final statistics.";
        statsLabel.textColor = [UIColor redColor];
    }
    else
    {
        statsLabel.text = @"Round Statistics";
        statsLabel.textColor = [UIColor whiteColor];
        finalizeButtonHeight.constant = 0;
        finalizeButton.hidden = YES;
    }
    tableView.allowsSelection = NO;
    
   
    UIBarButtonItem *resume = [[UIBarButtonItem alloc] initWithTitle: round.is_complete ? @"Edit" : @"Resume" style:UIBarButtonItemStyleDone target:self action:@selector(pushScorecard:)];
        self.navigationItem.rightBarButtonItem = resume;
}

- (HoleScore *)findHoleScoreForHole:(NSInteger)hole_number
{
    for (HoleScore *hs in round.hole_scores)
    {
        if (hs.hole_number == hole_number)
        {
            return hs;
        }
    }
    return nil;
}

- (void)pushScorecard:(id)sender
{
    ScorecardVC *controller = [[ScorecardVC alloc] initWithNibName:@"ScorecardVC" bundle:[NSBundle mainBundle]];
    
    // CONFIGURE THE SCORECARD
    Scorecard *sc = [[Scorecard alloc] init];
    
    Course *c = [[Course alloc] init];
    c.id_num = round.course_id;
    c.name = round.course_name;
    
    sc.user = nil; // MURDER
    sc.course = c;
    sc.round = round;
    
    // fetch tees for round
    TeeDAO *tee_dao = [[TeeDAO alloc] init];
    Tee *t = [tee_dao fetchTeeWithTeeId:round.tee_id];
    sc.tee = t;
    
    controller.scorecard = sc;
    [self.navigationController pushViewController:controller animated:YES];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return round.hole_scores.count + 3;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HoleLookupCollectionViewCell *cell = [collecView dequeueReusableCellWithReuseIdentifier:@"HoleLookup" forIndexPath:indexPath];
    
    if (indexPath.row < 9)
    {
        HoleScore *hs = [self findHoleScoreForHole:indexPath.row + 1];
        cell.hole_score = hs;
        [cell loadDisplay];
    }
    else if (indexPath.row == 9)
    {
        cell.holeNo.text = @"OUT";
        cell.holePar.text = [NSString stringWithFormat:@"%i",[round getFrontNinePar]];
        cell.holeScore.text = [round frontNineIsCompleted] ? [NSString stringWithFormat:@"%i",[round getFrontNineTotal]] : @"-";
        cell.holeScoreWord.text = [round frontNineIsCompleted] ? [round getRelativeFrontNineScore] : @"";
    }
    else if (indexPath.row > 9 && indexPath.row < 19)
    {
        HoleScore *hs = [self findHoleScoreForHole:indexPath.row];
        cell.hole_score = hs;
        [cell loadDisplay];
    }
    else if (indexPath.row == 19)
    {
        cell.holeNo.text = @"IN";
        cell.holePar.text = [NSString stringWithFormat:@"%i",[round getBackNinePar]];
        cell.holeScore.text = [round backNineIsComplete] ? [NSString stringWithFormat:@"%i",[round getBackNineTotal]] : @"-";
        cell.holeScoreWord.text = [round backNineIsComplete] ? [round getRelativeBackNineScore] : @"";
    }
    else // total cell
    {
        BOOL done = round.frontNineIsCompleted && round.backNineIsComplete;
        cell.holeNo.text = @"TOTAL";
        cell.holePar.text = done ? [NSString stringWithFormat:@"%i",[round getCoursePar]] : @"-";
        cell.holeScore.text = done ? [NSString stringWithFormat:@"%i",[round getRoundScore]] : @"-";
        cell.holeScoreWord.text = done ? [round getRelativeRoundScore] : @"";
    }
    
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2; // This is the minimum inter item spacing, can be more
}

// table view datasource and delegate
 
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 18;
}

- (UITableViewCell *)tableView:(UITableView *)tabView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HoleLookupTableViewCell *cell = (HoleLookupTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"RoundStat"];
    
    if (cell == nil)
    {
        cell = [[HoleLookupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoundStat"];
    }
    
    RoundStats *rs = round.round_stats;
    
    switch (indexPath.row)
    {
        
        case 0:
            cell.statName.text = @"Total Score";
            cell.statFig.text = [NSString stringWithFormat:@"%li",rs.total_score];
            cell.statFrac.text = @"";
            break;
        case 1:
            cell.statName.text = @"Eagles";
            cell.statFig.text = [NSString stringWithFormat:@"%li",rs.num_eagles];
            cell.statFrac.text = @"";
            break;
            
        case 2:
            cell.statName.text = @"Birdies";
            cell.statFig.text = [NSString stringWithFormat:@"%li",rs.num_birdies];
            cell.statFrac.text = @"";
            break;
            
        case 3:
            cell.statName.text = @"Pars";
            cell.statFig.text = [NSString stringWithFormat:@"%li",rs.num_pars];
            cell.statFrac.text = @"";
            break;
        
        case 4:
            cell.statName.text = @"Bogeys";
            cell.statFig.text = [NSString stringWithFormat:@"%li",rs.num_bogeys];
            cell.statFrac.text = @"";
            break;
            
        case 5:
            cell.statName.text = @"D. Bogeys+";
            cell.statFig.text = [NSString stringWithFormat:@"%li",rs.num_double_bogeys + rs.num_doubles_plus];
            cell.statFrac.text = @"";
            break;
            
        case 6:
            cell.statName.text = @"Par 3 Avg.";
            cell.statFig.text = [NSString stringWithFormat:@"%.2f", rs.par_3_avg];
            cell.statFrac.text = @"";
            break;
            
        case 7:
            cell.statName.text = @"Par 4 Avg.";
            cell.statFig.text = [NSString stringWithFormat:@"%.2f",rs.par_4_avg];
            cell.statFrac.text = @"";
            break;
            
        case 8:
            cell.statName.text = @"Par 5 Avg.";
            cell.statFig.text = [NSString stringWithFormat:@"%.2f",rs.par_5_avg];
            cell.statFrac.text = @"";
            break;
        case 9:
            cell.statName.text = @"Fairways";
            cell.statFig.text = [rs getFairwayPerc];
            cell.statFrac.text = [rs getFairwayFrac];
            break;
            
        case 10:
            cell.statName.text = @"GIR";
            cell.statFig.text = [rs getGIRPerc];
            cell.statFrac.text = [rs getGIRFrac];
            break;
            
        case 11:
            cell.statName.text = @"Putts";
            cell.statFig.text = [NSString stringWithFormat:@"%li",rs.num_putts];
            cell.statFrac.text = @"";
            break;
            
        case 12:
            cell.statName.text = @"1 Putts";
            cell.statFig.text = [NSString stringWithFormat:@"%li",rs.num_one_putts];
            cell.statFrac.text = @"";
            break;
            
        case 13:
            cell.statName.text = @"3 Putts";
            cell.statFig.text = [NSString stringWithFormat:@"%li",rs.num_three_putts];
            cell.statFrac.text = @"";
            break;
            
        case 14:
            cell.statName.text = @"Par Saves";
            cell.statFig.text = [rs getParSavePerc];
            cell.statFrac.text = [rs getParSaveFrac];
            break;
            
        case 15:
            cell.statName.text = @"Sand Saves";
            cell.statFig.text = [rs getSandSavePerc];
            cell.statFrac.text = [rs getSandSaveFrac];
            break;
            
        case 16:
            cell.statName.text = @"Bunkers";
            cell.statFig.text = [NSString stringWithFormat:@"%li", rs.num_bunkers_hit];
            cell.statFrac.text = @"";
            break;
            
        case 17:
            cell.statName.text = @"Penalty Strokes";
            cell.statFig.text = [NSString stringWithFormat:@"%li",rs.num_penalty_strokes];
            cell.statFrac.text = @"";
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (void)finalizeRound:(id)sender
{
    round.is_complete = YES;
    [delegate updateRound:round];
    [self.navigationController popViewControllerAnimated:YES];
}

@end

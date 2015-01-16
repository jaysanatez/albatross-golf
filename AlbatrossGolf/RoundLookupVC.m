//
//  RoundLookupVC.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/31/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import "RoundLookupVC.h"
#import "HoleLookupCollectionViewCell.h"
#import "HoleLookupTableViewCell.h"
#import "RoundStats.h"

@interface RoundLookupVC ()
{
    // BOOL hasAllFrontNine;
    // BOOL hasAllBackNine;
}

@end

@implementation RoundLookupVC

@synthesize round, collecView, statsLabel, tableView;

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
    
    /* hasAllFrontNine = YES;
    hasAllBackNine = YES;*/
    
    if (!round.is_complete)
    {
        statsLabel.text = @"Complete to compile statistics.";
        statsLabel.textColor = [UIColor redColor];
    }
    else
    {
        statsLabel.text = @"Round Statistics";
        statsLabel.textColor = [UIColor whiteColor];
    }
    tableView.allowsSelection = NO;
}



// collectionview datasource and delegate method

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HoleLookupCollectionViewCell *cell = [collecView dequeueReusableCellWithReuseIdentifier:@"HoleLookup" forIndexPath:indexPath];
   
    cell.holeNo.text = [NSString stringWithFormat:@"%i", indexPath.row];
    cell.holePar.text = @"4";
    cell.holeScore.text = indexPath.row % 2 == 0 ? @"3" : @"5";
    cell.image.image = [UIImage imageNamed: indexPath.row % 2 == 0 ? @"circle.png" : @"square.png"];
    
    /*if(indexPath.item < 9)
    {
        [[cell holePar] setText:[NSString stringWithFormat: @"%@",
                                [game.coursePlayed.parSequence objectAtIndex:indexPath.item]]];
        [[cell holeScore] setText:[NSString stringWithFormat:@"%@",
                                   [game.holeScores objectAtIndex:indexPath.item]]];
        [[cell holeNo] setText:[NSString stringWithFormat:@"%i",(indexPath.item+1)]];
        
        if([[game.coursePlayed.parSequence objectAtIndex:indexPath.item] intValue]
           - [[game.holeScores objectAtIndex:indexPath.item] intValue] > 1)
            [[cell image] setImage:[UIImage imageNamed:@"2circle.png"]];
        if([[game.coursePlayed.parSequence objectAtIndex:indexPath.item] intValue]
           - [[game.holeScores objectAtIndex:indexPath.item] intValue] == 1)
            [[cell image] setImage:[UIImage imageNamed:@"circle.png"]];
        if([[game.coursePlayed.parSequence objectAtIndex:indexPath.item] intValue]
           - [[game.holeScores objectAtIndex:indexPath.item] intValue] == -1)
            [[cell image] setImage:[UIImage imageNamed:@"square.png"]];
        if([[game.coursePlayed.parSequence objectAtIndex:indexPath.item] intValue]
           - [[game.holeScores objectAtIndex:indexPath.item] intValue] < -1)
            [[cell image] setImage:[UIImage imageNamed:@"2square.png"]];
        
        if([[cell holeScore].text isEqualToString:@"0"])
        {
            [cell holeScore].text = @"-";
            hasAllFrontNine = NO;
            [cell image].image = nil;
        }
    }
        else if (indexPath.item == 9)
        {
            [[cell holeNo] setText:@"IN"];
            
            int frontNinePar = 0;
            for(int i=0; i<9;i++)
                frontNinePar += [[game.coursePlayed.parSequence objectAtIndex:i] intValue];
            [[cell holePar] setText:[NSString stringWithFormat: @"%i",frontNinePar]];
        
            int frontNineScore = 0;
            for(int i=0; i<9;i++)
                frontNineScore += [[game.holeScores objectAtIndex:i] intValue];
            [[cell holeScore] setText:[NSString stringWithFormat: @"%i",frontNineScore]];
            if(!hasAllFrontNine)
                [cell holeScore].text = @"-";
            [cell holeScore].textColor = [UIColor colorWithRed:102.0/255.5
                                                         green:1.0
                                                          blue:102.0/255.0
                                                         alpha:0.8];
        }
    else if (indexPath.item < 19)
    {
        [[cell holePar] setText:[NSString stringWithFormat: @"%@",
                                [game.coursePlayed.parSequence objectAtIndex:(indexPath.item-1)]]];
        [[cell holeScore] setText:[NSString stringWithFormat:@"%@",
                               [game.holeScores objectAtIndex:(indexPath.item-1)]]];
        [[cell holeNo] setText:[NSString stringWithFormat:@"%i",indexPath.item]];
        
        if([[game.coursePlayed.parSequence objectAtIndex:indexPath.item-1] intValue]
           - [[game.holeScores objectAtIndex:indexPath.item-1] intValue] >1)
            [[cell image] setImage:[UIImage imageNamed:@"2circle.png"]];
        if([[game.coursePlayed.parSequence objectAtIndex:indexPath.item-1] intValue]
           - [[game.holeScores objectAtIndex:indexPath.item-1] intValue] == 1)
            [[cell image] setImage:[UIImage imageNamed:@"circle.png"]];
        if([[game.coursePlayed.parSequence objectAtIndex:indexPath.item-1] intValue]
           - [[game.holeScores objectAtIndex:indexPath.item-1] intValue] == -1)
            [[cell image] setImage:[UIImage imageNamed:@"square.png"]];
        if([[game.coursePlayed.parSequence objectAtIndex:indexPath.item-1] intValue]
           - [[game.holeScores objectAtIndex:indexPath.item-1] intValue] < -1)
            [[cell image] setImage:[UIImage imageNamed:@"2square.png"]];
        
        if([[cell holeScore].text isEqualToString:@"0"])
        {
            [cell holeScore].text = @"-";
            hasAllBackNine = NO;

            [cell image].image = nil;
        }
    }
        else
        {
            [[cell holeNo] setText:@"OUT"];
        
            int backNinePar = 0;
            for(int i=9; i<18;i++)
                backNinePar += [[game.coursePlayed.parSequence objectAtIndex:i] intValue];
            [[cell holePar] setText:[NSString stringWithFormat: @"%i",backNinePar]];
        
            int backNineScore = 0;
            for(int i=9; i<18;i++)
                backNineScore += [[game.holeScores objectAtIndex:i] intValue];
            [[cell holeScore] setText:[NSString stringWithFormat: @"%i",backNineScore]];
            if(!hasAllBackNine)
                [[cell holeScore] setText:@"-"];
            [cell holeScore].textColor = [UIColor colorWithRed:102.0/255.5
                                                         green:1.0
                                                          blue:102.0/255.0
                                                         alpha:0.8];
        }*/
    
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2; // This is the minimum inter item spacing, can be more
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,0,0,0);
}

// table view datasource and delegate
 
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 17;
}

- (UITableViewCell *)tableView:(UITableView *)tabView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HoleLookupTableViewCell *cell = (HoleLookupTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"RoundStat"];
    
    if (cell == nil)
    {
        cell = [[HoleLookupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoundStat"];
    }
    
    if (!round.is_complete)
    {
        cell.statName.text = @"";
        cell.statFig.text = @"";
        cell.statFrac.text = @"";
        return cell;
    }
    
    RoundStats *rs = round.round_stats;
    
    switch (indexPath.row)
    {
        case 0:
            cell.statName.text = @"Pars";
            cell.statFig.text = [NSString stringWithFormat:@"%@",rs.num_pars];
            cell.statFrac.text = @"";
            break;
            
        case 1:
            cell.statName.text = @"Eagles";
            cell.statFig.text = [NSString stringWithFormat:@"%@",rs.num_eagles];
            cell.statFrac.text = @"";
            break;
            
        case 2:
            cell.statName.text = @"Birdies";
            cell.statFig.text = [NSString stringWithFormat:@"%@",rs.num_birdies];
            cell.statFrac.text = @"";
            break;
        
        case 3:
            cell.statName.text = @"Bogeys";
            cell.statFig.text = [NSString stringWithFormat:@"%@",rs.num_bogeys];
            cell.statFrac.text = @"";
            break;
            
        case 4:
            cell.statName.text = @"D. Bogeys+";
            cell.statFig.text = [NSString stringWithFormat:@"%i",rs.num_double_bogeys.integerValue + rs.num_doubles_plus.intValue];
            cell.statFrac.text = @"";
            break;
            
        case 5:
            cell.statName.text = @"Par 3 Avg.";
            cell.statFig.text = [NSString stringWithFormat:@"%.2f", rs.par_3_avg.doubleValue];
            cell.statFrac.text = @"";
            break;
            
        case 6:
            cell.statName.text = @"Par 4 Avg.";
            cell.statFig.text = [NSString stringWithFormat:@"%.2f",rs.par_4_avg.doubleValue];
            cell.statFrac.text = @"";
            break;
            
        case 7:
            cell.statName.text = @"Par 5 Avg.";
            cell.statFig.text = [NSString stringWithFormat:@"%.2f",rs.par_5_avg.doubleValue];
            cell.statFrac.text = @"";
            break;
        case 8:
            cell.statName.text = @"Fairways";
            cell.statFig.text = [rs getFairwayPerc];
            cell.statFrac.text = [rs getFairwayFrac];
            break;
            
        case 9:
            cell.statName.text = @"GIR";
            cell.statFig.text = [rs getGIRPerc];
            cell.statFrac.text = [rs getGIRFrac];
            break;
            
        case 10:
            cell.statName.text = @"Putts";
            cell.statFig.text = [NSString stringWithFormat:@"%@",rs.num_putts];
            cell.statFrac.text = @"";
            break;
            
        case 11:
            cell.statName.text = @"1 Putts";
            cell.statFig.text = [NSString stringWithFormat:@"%@",rs.num_one_putts];
            cell.statFrac.text = @"";
            break;
            
        case 12:
            cell.statName.text = @"3 Putts";
            cell.statFig.text = [NSString stringWithFormat:@"%@",rs.num_three_putts];
            cell.statFrac.text = @"";
            break;
            
        case 13:
            cell.statName.text = @"Par Saves";
            cell.statFig.text = [rs getParSavePerc];
            cell.statFrac.text = [rs getParSaveFrac];
            break;
            
        case 14:
            cell.statName.text = @"Sand Saves";
            cell.statFig.text = [rs getSandSavePerc];
            cell.statFrac.text = [rs getSandSaveFrac];
            break;
            
        case 15:
            cell.statName.text = @"Bunkers";
            cell.statFig.text = [NSString stringWithFormat:@"%@", rs.num_bunkers_hit];
            cell.statFrac.text = @"";
            break;
            
        case 16:
            cell.statName.text = @"Penalty Strokes";
            cell.statFig.text = [NSString stringWithFormat:@"%@",rs.num_penalty_strokes];
            cell.statFrac.text = @"";
            break;
            
        default:
            break;
    }
    
    return cell;
}

@end

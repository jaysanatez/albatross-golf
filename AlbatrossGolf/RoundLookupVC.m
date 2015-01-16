//
//  RoundLookupVC.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/31/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import "RoundLookupVC.h"
#import "HoleLookupCollectionViewCell.h"
#import "HoleLookupTableViewCell.h"

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
    hasAllBackNine = YES;
    [self getHoleStats];*/
    
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

/* -(void)doTheStats
{
    NSMutableArray *actScores = game.coursePlayed.parSequence;
    NSMutableArray *myScores = game.holeScores;
    int holesPlayed = [actScores count];
    parsHad = 0;
    birdiesHad = 0;
    bogeysHad = 0;
    worseThanBogeys = 0;
    threeScores = 0;
    numThrees = 0;
    fourScores = 0;
    numFours = 0;
    fiveScores = 0;
    numFives = 0;
    
    for(int i=0; i<holesPlayed; i++)
    {
        NSNumber *real = [actScores objectAtIndex:i];
        NSNumber *me = [myScores objectAtIndex:i];
        int diff = [me intValue] - [real intValue];
        switch (diff) {
            case 0:
                parsHad++;
                break;
            case -1:
                birdiesHad++;
                break;
            case 1:
                bogeysHad++;
                break;
            default:
                break;
        }
        if(diff > 1)
            worseThanBogeys++;
        
        switch ([real intValue]) {
            case 3:
                threeScores += [me intValue];
                numThrees++;
                break;
            case 4:
                fourScores += [me intValue];
                numFours++;
                break;
            case 5:
                fiveScores += [me intValue];
                numFives++;
                break;
            default:
                break;
        }
    }
    
    int fHit = 0, gHit = 0, saveSucc = 0, saveChances = 0, sandSucc = 0, sandChances=0;
    numBunkers = 0;
    numberPen = 0;
    numPutts = 0;
    numOnePutts = 0;
    numThreePutts = 0;
    for(Hole *hole in holeStats)
    {
        if(hole.hitFairway)
            fHit++;
        if(hole.gir)
            gHit++;
        else
        {
            saveChances++;
            NSNumber *par = [actScores objectAtIndex:([hole.holeNumber intValue]-1)];
            NSNumber *score = [myScores objectAtIndex:([hole.holeNumber intValue]-1)];
            if(par == score)
                saveSucc++;
        }
        
        numPutts += [hole.putts intValue];
        numberPen += [hole.penalties intValue];
        
        if([hole.putts intValue] == 1)
            numOnePutts++;
        if([hole.putts intValue] == 3)
            numThreePutts++;
            
        if(hole.fairBunk)
            numBunkers++;
        if(hole.greenBunk)
        {
            numBunkers++;
            sandChances++;
            NSNumber *par = [actScores objectAtIndex:([hole.holeNumber intValue]-1)];
            NSNumber *score = [myScores objectAtIndex:([hole.holeNumber intValue]-1)];
            if(par == score)
                sandSucc++;
        }
    }
    
    if(numFours+numFives != 0)
    {
        fairwayFrac = [NSString stringWithFormat:@"%i/%i",fHit,(numFours+numFives)];
        if(fHit == 0)
        {
            fairHit = @"0%";
        }
        else
        {
            fairHit = [[NSString stringWithFormat:@"%f",
                              100*((double) fHit)/(numFours+numFives)] substringToIndex:2];
        }
    }
    else
    {
        fairwayFrac = @"-/-";
        fairHit = @"--";
    }
    
    greenFrac = [NSString stringWithFormat:@"%i/18",gHit];
    
    if(gHit == 0)
    {
        greensHit = @"0%";
    }
    else
    {
        NSString *greHit = [[NSString stringWithFormat:@"%f",100*((double) gHit)/18.0] substringToIndex:2];
        greensHit = [NSString stringWithFormat:@"%@",greHit];
    }

    if(saveChances != 0){
        parSavesFrac = [NSString stringWithFormat:@"%i/%i",saveSucc,saveChances];
        if(saveSucc == 0)
        {
            parSaves = @"0%";
        }
        else
        {
            NSString *ps = [[NSString stringWithFormat:@"%f",100*((double) saveSucc)/saveChances] substringToIndex:2];
            parSaves = [NSString stringWithFormat:@"%@",ps];
        }
    }
    else
    {
        parSavesFrac = @"-/-";
        parSaves = @"--";
    }
    
    if(sandChances != 0)
    {
        sandSavesFrac = [NSString stringWithFormat:@"%i/%i",sandSucc,sandChances];
        if(sandSucc == 0)
        {
            sandSaves = @"0%";
        }
        else
        {
            NSString *ss = [[NSString stringWithFormat:@"%f",100*((double) sandSucc)/sandChances] substringToIndex:2];
            sandSaves = [NSString stringWithFormat:@"%@",ss];
        }
    }
    else
    {
        sandSavesFrac = @"-/-";
        sandSaves = @"--";
    }
}*/

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
    return 16;
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
    else
    {
        cell.statName.text = @"Category";
        cell.statFig.text = @"##";
        cell.statFrac.text = @"#/##";
    }
    
    switch (indexPath.row)
    {
        /*case 0:
            cell.statName.text = @"Pars";
            cell.statFig.text = [NSString stringWithFormat:@"%i",parsHad];
            cell.statFrac.text = @"";
            break;
            
        case 1:
            cell.statName.text = @"Birdies";
            cell.statFig.text = [NSString stringWithFormat:@"%i",birdiesHad];
            cell.statFrac.text = @"";
            break;
        
        case 2:
            cell.statName.text = @"Bogeys";
            cell.statFig.text = [NSString stringWithFormat:@"%i",bogeysHad];
            cell.statFrac.text = @"";
            break;
            
        case 3:
            cell.statName.text = @"D. Bogeys+";
            cell.statFig.text = [NSString stringWithFormat:@"%i",worseThanBogeys];
            cell.statFrac.text = @"";
            break;
            
        case 4:
            cell.statName.text = @"Par 3 Avg.";
            cell.statFig.text = [[NSString stringWithFormat:@"%f",((double) threeScores)/numThrees] substringToIndex:4];
            cell.statFrac.text = @"";
            break;
            
        case 5:
            cell.statName.text = @"Par 4 Avg.";
            cell.statFig.text = [[NSString stringWithFormat:@"%f",((double) fourScores)/numFours] substringToIndex:4];
            cell.statFrac.text = @"";
            break;
            
        case 6:
            cell.statName.text = @"Par 5 Avg.";
            cell.statFig.text = [[NSString stringWithFormat:@"%f",((double) fiveScores)/numFives] substringToIndex:4];
            cell.statFrac.text = @"";
            break;
        case 7:
            cell.statName.text = @"Fairways";
            cell.statFrac.text = [self getFairwaysHitFraction];
            cell.statFig.text = [self getFairwaysHitPercentage];
            break;
            
        case 8:
            cell.statName.text = @"GIR";
            cell.statFrac.text = [NSString stringWithFormat:@"%@",greenFrac];
            cell.statFig.text = [NSString stringWithFormat:@"%@%%",greensHit];
            break;
            
        case 9:
            cell.statName.text = @"Putts";
            cell.statFig.text = [NSString stringWithFormat:@"%i",numPutts];
            cell.statFrac.text = @"";
            break;
            
        case 10:
            cell.statName.text = @"1 Putts";
            cell.statFig.text = [NSString stringWithFormat:@"%i",numOnePutts];
            cell.statFrac.text = @"";
            break;
            
        case 11:
            cell.statName.text = @"3 Putts";
            cell.statFig.text = [NSString stringWithFormat:@"%i",numThreePutts];
            cell.statFrac.text = @"";
            break;
            
        case 12:
            cell.statName.text = @"Par Saves";
            cell.statFig.text = [NSString stringWithFormat:@"%@%%",parSaves];
            cell.statFrac.text = [NSString stringWithFormat:@"%@",parSavesFrac];
            break;
            
        case 13:
            cell.statName.text = @"Bunkers";
            cell.statFig.text = [NSString stringWithFormat:@"%i", numBunkers];
            cell.statFrac.text = @"";
            break;
            
        case 14:
            cell.statName.text = @"Sand Saves";
            cell.statFig.text = [NSString stringWithFormat:@"%@%%",sandSaves];
            cell.statFrac.text = [NSString stringWithFormat:@"%@",sandSavesFrac];
            break;
            
        case 15:
            cell.statName.text = @"Penalty Strokes";
            cell.statFig.text = [NSString stringWithFormat:@"%i",numberPen];
            cell.statFrac.text = @"";
            break;*/
            
        default:
            break;
    }
    
    return cell;
}

@end

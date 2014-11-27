//
//  MGStatsViewVC.m
//  SmartShot_2.1
//
//  Created by Jacob Sanchez on 6/15/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import "MGStatsViewVC.h"
#import "Game.h"
#import "Hole.h"
#import "GroupStatCell.h"
#import "HoleStatsDAO.h"
#import "GameDAO.h"

@interface MGStatsViewVC ()
{
    double totalScore,totalPars,totalBirds,totalBogeys,totalDB,b3avg,w3avg,b4avg,w4avg,b5avg,w5avg,bSave,wSave,bSSave,wSSave;
    int bScore,wScore,bPars,wPars,bBirds,wBirds,bBogeys,wBogeys,bDB,wDB,bFair,wFair,bGIR,wGIR,bPutts,wPutts,b1P,w1P,b3P,w3P,bBunk,wBunk,bPen,wPen;
    NSString *meanFairHit, *meanGreen, *meanPutt, *mean1Putt, *mean3Putt, *par3avg, *par4avg, *par5avg, *bunkers;
    NSString *parSaves, *sandSaves, *meanPen;
}

@end

@implementation MGStatsViewVC

@synthesize games,tableView,slider,dropDown,gameList;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width-130,
                                                                    self.navigationController.navigationBar.bounds.size.height)];
    titleLabel.text= [NSString stringWithFormat:@"Multi-Game Statistics"];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:@"Iowan Old Style" size:18];
    titleLabel.textAlignment = NSTextAlignmentRight;
    self.navigationItem.titleView = titleLabel;
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:102.0/255.5
                                                                        green:1.0
                                                                         blue:102.0/255.0
                                                                        alpha:0.8];
    [self getAllGames];
    if([self checkForZeroGames])
    {
        [self displayStats];
    }
    
    slider.itemTitles = [[NSMutableArray alloc] initWithObjects:@"All Time",@"This Year",@"This Month",@"Custom", nil];
    slider.selectedItemIndex = 0;
    [slider displayTitles];
    tableView.allowsSelection = NO;
    dropDown.gameList = self.gameList;
    dropDown.parentController = self;
    gameList.games = self.games;
    gameList.tableView.allowsMultipleSelection = YES;
}

-(BOOL)checkForZeroGames
{
    if([games count] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Rounds"
                                                        message:@"This range contains zero rounds."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    return YES;
}

-(void)displayStats
{
    double totalFair, totalFairP, totalGIR, totalPutt, total1Putt, total3Putt, total3Score, total4Score, total5Score;
    double totalBunkers, saves, savesP, sanSaves, sanSavesP, totalPen;
    int num3s, num4s, num5s;
    Game *firstGame = ((Game *)[games objectAtIndex:0]);
    
    double firstTotalScore = [self totalScoreFrom:firstGame];
    bScore = firstTotalScore;
    wScore = firstTotalScore;
    totalScore = firstTotalScore;
    
    double firstNumPars = [self numParsFrom:firstGame];
    bPars = firstNumPars;
    wPars = firstNumPars;
    totalPars = firstNumPars;
    
    double firstNumBirds = [self numBirdiesFrom:firstGame];
    bBirds = firstNumBirds;
    wBirds = firstNumBirds;
    totalBirds = firstNumBirds;
    
    double firstNumBogs = [self numBogeysFrom:firstGame];
    bBogeys = firstNumBogs;
    wBogeys = firstNumBogs;
    totalBogeys = firstNumBogs;
    
    double firstNumDB = [self numDBogeysFrom:firstGame];
    bDB = firstNumDB;
    wDB = firstNumDB;
    totalDB = firstNumDB;
    
    NSMutableArray *array = [self getHoleStats:firstGame];
    
    double firstFairHit = [self numFairHit:array];
    double firstFairPoss = [self numFairPossible:firstGame];
    bFair = firstFairHit;
    wFair = firstFairHit;
    totalFair = firstFairHit;
    totalFairP = firstFairPoss;
    
    double firstGreenHit = [self numGreensHit:array];
    bGIR = firstGreenHit;
    wGIR = firstGreenHit;
    totalGIR = firstGreenHit;
    
    double firstNumPutts = [self numPuttsInGame:array];
    bPutts = firstNumPutts;
    wPutts = firstNumPutts;
    totalPutt = firstNumPutts;
    
    double firstNum1Putts = [self num1PuttsInGame:array];
    b1P = firstNum1Putts;
    w1P = firstNum1Putts;
    total1Putt = firstNum1Putts;
    
    double firstNum3Putts = [self num3PuttsInGame:array];
    b3P = firstNum3Putts;
    w3P = firstNum3Putts;
    total3Putt = firstNum3Putts;
    
    total3Score = 0;
    NSMutableArray *first3Scores = [self par3Scores:firstGame];
    for(NSNumber *obj in first3Scores)
        total3Score += [obj intValue];
    num3s = [first3Scores count];
    if(num3s != 0)
    {
        b3avg = total3Score/num3s;
        w3avg = b3avg;
    }
        
    total4Score = 0;
    NSMutableArray *first4Scores = [self par4Scores:firstGame];
    for(id obj in first4Scores)
        total4Score += [obj intValue];
    num4s = [first4Scores count];
    if(num4s != 0)
    {
        b4avg = total4Score/num4s;
        w4avg = b4avg;
    }
    
    total5Score = 0;
    NSMutableArray *first5Scores = [self par5Scores:firstGame];
    for(id obj in first5Scores)
        total5Score += [obj intValue];
    num5s = [first5Scores count];
    if(num5s != 0)
    {
        b5avg = total5Score/num5s;
        w5avg = b5avg;
    }
    
    double firstNumBunk = [self numBunkersReached:array];
    bBunk = firstNumBunk;
    wBunk = firstNumBunk;
    totalBunkers = firstNumBunk;
    
    saves = [self numParSavesInGame:firstGame withStats:array];
    savesP = [self numSaveOppsInGame:array];
    if(savesP != 0)
    {
        bSave = saves/savesP;
        wSave = bSave;
    }
    
    sanSaves = [self numSandSavesInGame:firstGame withStats:array];
    sanSavesP = [self numSandyOppsInGame:array];
    if(sanSavesP)
    {
        bSSave = sanSaves/sanSavesP;
        wSSave = bSSave;
    }
    
    double firstNumPen = [self numPenaltiesInGame:array];
    bPen = firstNumPen;
    wPen = firstNumPen;
    totalPen = firstNumPen;
    
    for(int i=1; i<[games count]; i++)
    {
        Game *g = ((Game *)[games objectAtIndex:i]);
        
        double score = [self totalScoreFrom:g];
        totalScore += score;
        if(score < bScore)
            bScore = score;
        if(score > wScore)
            wScore = score;
        
        double pars = [self numParsFrom:g];
        totalPars += pars;
        if(pars < wPars)
            wPars = pars;
        if(pars > bPars)
            bPars = pars;
        
        double birds = [self numBirdiesFrom:g];
        totalBirds += birds;
        if(birds > bBirds)
            bBirds = birds;
        if(birds < wBirds)
            wBirds = birds;
        
        double bogs = [self numBogeysFrom:g];
        totalBogeys += bogs;
        if(bogs > wBogeys)
            wBogeys = bogs;
        if(bogs < bBogeys)
            bBogeys = bogs;
        
        double dbs = [self numDBogeysFrom:g];
        totalDB += dbs;
        if(dbs > wDB)
            wDB = dbs;
        if(dbs < bDB)
            bDB = dbs;
        
        NSMutableArray *ary = [self getHoleStats:g];
        
        double numFair = [self numFairHit:ary];
        totalFair += numFair;
        totalFairP += [self numFairPossible:g];
        if(numFair > bFair)
            bFair = numFair;
        if(numFair < wFair)
            wFair = numFair;
        
        double numGIR = [self numGreensHit:ary];
        totalGIR += numGIR;
        if(numGIR > bGIR)
            bGIR = numGIR;
        if(numGIR < wGIR)
            wGIR = numGIR;
        
        double numPutts = [self numPuttsInGame:ary];
        totalPutt += numPutts;
        if(numPutts < bPutts)
            bPutts = numPutts;
        if(numPutts > wPutts)
            wPutts = numPutts;
        
        double num1P = [self num1PuttsInGame:ary];
        total1Putt += num1P;
        if(num1P > b1P)
            b1P = num1P;
        if(num1P < w1P)
            w1P = num1P;
        
        double num3P = [self num3PuttsInGame:ary];
        total3Putt += num3P;
        if(num3P < b3P)
            b3P = num3P;
        if(num3P > w3P)
            w3P = num3P;
        
        NSMutableArray *par3Scores = [self par3Scores:g];
        if([par3Scores count] != 0)
        {
            double course3Scores = 0.0;
            for(id obj in par3Scores)
            {
                total3Score += [obj intValue];
                course3Scores += [obj intValue];
            }
            num3s += [par3Scores count];
            double course3avg = course3Scores/[par3Scores count];
            if(course3avg < b3avg)
                b3avg = course3avg;
            if(course3avg > w3avg)
                w3avg = course3avg;
        }
        
        NSMutableArray *par4Scores = [self par4Scores:g];
        if([par4Scores count] != 0)
        {
            double course4Scores = 0.0;
            for(id obj in par4Scores)
            {
                total4Score += [obj intValue];
                course4Scores += [obj intValue];
            }
            num4s += [par4Scores count];
            double course4avg = course4Scores/[par4Scores count];
            if(course4avg < b4avg)
                b4avg = course4avg;
            if(course4avg > w4avg)
                w4avg = course4avg;
        }
            
        NSMutableArray *par5Scores = [self par5Scores:g];
        if([par5Scores count] != 0)
        {
            double course5Scores = 0.0;
            for(id obj in par5Scores)
            {
                total5Score += [obj intValue];
                course5Scores += [obj intValue];
            }
            num5s += [par5Scores count];
            double course5avg = course5Scores/[par5Scores count];
            if(course5avg < b5avg)
                b5avg = course5avg;
            if(course5avg > w5avg)
                w5avg = course5avg;
        }
        
        double numBunk = [self numBunkersReached:ary];
        totalBunkers += numBunk;
        if(numBunk < bBunk)
            bBunk = numBunk;
        if(numBunk > wBunk)
            wBunk = numBunk;
        
        double roundSaves = [self numParSavesInGame:g withStats:ary];
        double roundSaveOpps = [self numSaveOppsInGame:ary];
        if(roundSaveOpps != 0)
        {
            double roundSaveP = roundSaves/roundSaveOpps;
            if(roundSaveP > bSave)
                bSave = roundSaveP;
            if(roundSaveP < wSave)
                wSave = roundSaveP;
        }
        saves += roundSaves;
        savesP += roundSaveOpps;
        
        double roundSSaves = [self numSandSavesInGame:g withStats:ary];
        double roundSSaveOpps = [self numSandyOppsInGame:ary];
        if(roundSSaveOpps != 0)
        {
            double roundSSaveP = roundSSaves/roundSSaveOpps;
            if(roundSSaveP > bSSave)
                bSSave = roundSSaveP;
            if(roundSSaveP < wSSave)
                wSSave = roundSSaveP;
        }
        sanSaves += roundSSaves;
        sanSavesP += roundSSaveOpps;
        
        double numPen = [self numPenaltiesInGame:ary];
        totalPen += numPen;
        if(numPen < bPen)
            bPen = numPen;
        if(numPen > wPen)
            wPen = numPen;
    }

    if([games count] != 0)
    {
        if(totalFairP != 0)
            meanFairHit = [NSString stringWithFormat:@"%.1f%%",100*totalFair/totalFairP];
        meanGreen = [NSString stringWithFormat:@"%.1f%%",100*totalGIR/18/[games count]];
        meanPutt = [NSString stringWithFormat:@"%.1f",totalPutt/[games count]];
        mean1Putt = [NSString stringWithFormat:@"%.2f",total1Putt/[games count]];
        mean3Putt = [NSString stringWithFormat:@"%.2f",total3Putt/[games count]];
    
        if(num3s != 0)
            par3avg = [NSString stringWithFormat:@"%.2f",total3Score/num3s];
        if(num4s != 0)
            par4avg = [NSString stringWithFormat:@"%.2f",total4Score/num4s];
        if(num5s != 0)
            par5avg = [NSString stringWithFormat:@"%.2f",total5Score/num5s];
    
        bunkers = [NSString stringWithFormat:@"%.2f",totalBunkers/[games count]];
        if(savesP != 0)
            parSaves = [NSString stringWithFormat:@"%.1f%%",100*saves/savesP];
        if(sanSavesP != 0)
            sandSaves = [NSString stringWithFormat:@"%.1f%%",100*sanSaves/sanSavesP];
        meanPen = [NSString stringWithFormat:@"%.1f",totalPen/[games count]];
    }
}

-(double)totalScoreFrom:(Game *)game
{
    double tScore = 0.0;
    for(id num in game.holeScores)
    {
        tScore += [num doubleValue];
    }
    return tScore;
}

-(double)numParsFrom:(Game *)game
{
    double num = 0;
    for(int i=0; i<[game.coursePlayed.parSequence count]; i++)
        if([game.holeScores objectAtIndex:i] == [game.coursePlayed.parSequence objectAtIndex:i])
            num++;
    return num;
}

-(double)numBirdiesFrom:(Game *)game
{
    double num = 0;
    for(int i=0; i<[game.coursePlayed.parSequence count]; i++)
        if([[game.holeScores objectAtIndex:i] intValue]-[[game.coursePlayed.parSequence objectAtIndex:i] intValue] == -1)
            num++;
    return num;
}

-(double)numBogeysFrom:(Game *)game
{
    double num = 0;
    for(int i=0; i<[game.coursePlayed.parSequence count]; i++)
        if([[game.holeScores objectAtIndex:i] intValue]-[[game.coursePlayed.parSequence objectAtIndex:i] intValue] == 1)
            num++;
    return num;
}

-(double)numDBogeysFrom:(Game *)game
{
    double num = 0;
    for(int i=0; i<[game.coursePlayed.parSequence count]; i++)
        if([[game.holeScores objectAtIndex:i] intValue]-[[game.coursePlayed.parSequence objectAtIndex:i] intValue] > 1)
            num++;
    return num;
}

-(double)numFairHit:(NSMutableArray *)array
{
    double numHit = 0;
    for(Hole *h in array)
        if(h.hitFairway)
            numHit++;
    return numHit;
}

-(int)numFairPossible:(Game *)game
{
    int num = 0;
    for(int i=0; i<[game.coursePlayed.parSequence count]; i++)
    {
        int holeScore = [[game.coursePlayed.parSequence objectAtIndex:i] intValue];
        if(holeScore != 3)
            num++;
    }
    return num;
}

-(double)numGreensHit:(NSMutableArray *)array
{
    double numHit = 0;
    for(Hole *h in array)
        if(h.gir)
            numHit++;
    return numHit;
}

-(double)numPuttsInGame:(NSMutableArray *)array
{
    double numPutts = 0.0;
    for(Hole *h in array)
        numPutts += [h.putts intValue];
    return numPutts;
}

-(double)num1PuttsInGame:(NSMutableArray *)array
{
    double num1Putts = 0.0;
    for(Hole *h in array)
        if([h.putts intValue] == 1)
            num1Putts++;
    return num1Putts;
}

-(double)num3PuttsInGame:(NSMutableArray *)array
{
    double num3Putts = 0.0;
    for(Hole *h in array)
        if([h.putts intValue] > 2)
            num3Putts++;
    return num3Putts;
}

-(NSMutableArray *)par3Scores:(Game *)game
{
    NSMutableArray *arrrrrrgh = [[NSMutableArray alloc] initWithCapacity:0];
    for(int i=0; i<[game.coursePlayed.parSequence count];i++)
    {
        int holePar = [[game.coursePlayed.parSequence objectAtIndex:i] intValue];
        if(holePar == 3)
           [arrrrrrgh addObject:[game.holeScores objectAtIndex:i]];
    }
    return arrrrrrgh;
}

-(NSMutableArray *)par4Scores:(Game *)game
{
    NSMutableArray *arrrrrrgh = [[NSMutableArray alloc] initWithCapacity:0];
    for(int i=0; i<[game.coursePlayed.parSequence count];i++)
    {
        int holePar = [[game.coursePlayed.parSequence objectAtIndex:i] intValue];
        if(holePar == 4)
            [arrrrrrgh addObject:[game.holeScores objectAtIndex:i]];
    }
    return arrrrrrgh;
}

-(NSMutableArray *)par5Scores:(Game *)game
{
    NSMutableArray *arrrrrrgh = [[NSMutableArray alloc] initWithCapacity:0];
    for(int i=0; i<[game.coursePlayed.parSequence count];i++)
    {
        int holePar = [[game.coursePlayed.parSequence objectAtIndex:i] intValue];
        if(holePar == 5)
            [arrrrrrgh addObject:[game.holeScores objectAtIndex:i]];
    }
    return arrrrrrgh;
}

-(double)numBunkersReached:(NSMutableArray *)array
{
    double num = 0.0;
    for(Hole *h in array)
    {
        if(h.greenBunk)
            num++;
        if(h.fairBunk)
            num++;
    }
    return num;
}

-(double)numParSavesInGame:(Game *)game withStats:(NSMutableArray *)array
{
    double numSaves = 0.0;
    for(int i=0; i<[array count];i++)
    {
        int par = [[game.coursePlayed.parSequence objectAtIndex:i] intValue];
        int score = [[game.holeScores objectAtIndex:i] intValue];
        Hole *h = (Hole *)[array objectAtIndex:i];
        if((par == score) && !h.gir)
            numSaves++;
    }
    return  numSaves;
}

-(double)numSaveOppsInGame:(NSMutableArray *)array
{
    double numOpps = 0.0;
    for(Hole *h in array)
        if(!h.gir)
            numOpps++;
    return  numOpps;
}

-(double)numSandSavesInGame:(Game *)game withStats:(NSMutableArray *)array
{
    double numSaves = 0.0;
    for(int i=0; i<[array count];i++)
    {
        int par = [[game.coursePlayed.parSequence objectAtIndex:i] intValue];
        int score = [[game.holeScores objectAtIndex:i] intValue];
        Hole *h = (Hole *)[array objectAtIndex:i];
        if((par == score) && h.greenBunk)
            numSaves++;
    }
    return  numSaves;
}

-(double)numSandyOppsInGame:(NSMutableArray *)array
{
    double numOpps = 0.0;
    for(Hole *h in array)
        if(h.greenBunk)
            numOpps++;
    return  numOpps;
}

-(double)numPenaltiesInGame:(NSMutableArray *)array
{
    double numPens = 0.0;
    for(Hole *h in array)
        numPens += [h.penalties intValue];
    return numPens;
}

-(NSMutableArray *)getHoleStats:(Game *)game
{
    HoleStatsDAO *dao = [[HoleStatsDAO alloc] init];
    return [dao getHoleStatsForGame:game];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 17;
}

- (UITableViewCell *)tableView:(UITableView *)tabView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"statCell";
    GroupStatCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil)
        cell = [[GroupStatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    
    if([games count] == 0)
    {
        cell.statName.text = @"";
        cell.statAve.text = @"";
        cell.statBest.text = @"";
        cell.statWorst.text = @"";
    }
    else
    {
        switch (indexPath.row) {
            case 0:
                cell.statName.text = @"Total Score";
                cell.statAve.text = [NSString stringWithFormat:@"%.1f",totalScore/[games count]];
                cell.statBest.text = [NSString stringWithFormat:@"%i",bScore];
                cell.statWorst.text = [NSString stringWithFormat:@"%i",wScore];
                break;

            case 1:
                cell.statName.text = @"Pars";
                cell.statAve.text = [NSString stringWithFormat:@"%.2f",totalPars/[games count]];;
                cell.statBest.text = [NSString stringWithFormat:@"%i",bPars];;
                cell.statWorst.text = [NSString stringWithFormat:@"%i",wPars];;
                break;
            
            case 2:
                cell.statName.text = @"Birdies";
                cell.statAve.text = [NSString stringWithFormat:@"%.2f",totalBirds/[games count]];
                cell.statBest.text = [NSString stringWithFormat:@"%i",bBirds];
                cell.statWorst.text = [NSString stringWithFormat:@"%i",wBirds];
                break;
                
            case 3:
                cell.statName.text = @"Bogeys";
                cell.statAve.text = [NSString stringWithFormat:@"%.2f",totalBogeys/[games count]];
                cell.statBest.text = [NSString stringWithFormat:@"%i",bBogeys];
                cell.statWorst.text = [NSString stringWithFormat:@"%i",wBogeys];
                break;
                
            case 4:
                cell.statName.text = @"D. Bogeys+";
                cell.statAve.text = [NSString stringWithFormat:@"%.2f",totalDB/[games count]];
                cell.statBest.text = [NSString stringWithFormat:@"%i",bDB];
                cell.statWorst.text = [NSString stringWithFormat:@"%i",wDB];
                break;
                
            case 5:
                cell.statName.text = @"Fairways";
                cell.statAve.text = meanFairHit;
                cell.statBest.text = [NSString stringWithFormat:@"%i",bFair];
                cell.statWorst.text = [NSString stringWithFormat:@"%i",wFair];
                break;
                
            case 6:
                cell.statName.text = @"GIR";
                cell.statAve.text = meanGreen;
                cell.statBest.text = [NSString stringWithFormat:@"%i",bGIR];
                cell.statWorst.text = [NSString stringWithFormat:@"%i",wGIR];
                break;
                
            case 7:
                cell.statName.text = @"Putts";
                cell.statAve.text = meanPutt;
                cell.statBest.text = [NSString stringWithFormat:@"%i",bPutts];
                cell.statWorst.text = [NSString stringWithFormat:@"%i",wPutts];
                break;
                
            case 8:
                cell.statName.text = @"1 Putts";
                cell.statAve.text = mean1Putt;
                cell.statBest.text = [NSString stringWithFormat:@"%i",b1P];
                cell.statWorst.text = [NSString stringWithFormat:@"%i",w1P];
                break;
                
            case 9:
                cell.statName.text = @"3 Putts";
                cell.statAve.text = mean3Putt;
                cell.statBest.text = [NSString stringWithFormat:@"%i",b3P];
                cell.statWorst.text = [NSString stringWithFormat:@"%i",w3P];
                break;
                
            case 10:
                cell.statName.text = @"Par 3 Avg.";
                cell.statAve.text = par3avg;
                cell.statBest.text = [NSString stringWithFormat:@"%.2f",b3avg];
                cell.statWorst.text = [NSString stringWithFormat:@"%.2f",w3avg];
                break;
                
            case 11:
                cell.statName.text = @"Par 4 Avg.";
                cell.statAve.text = par4avg;
                cell.statBest.text = [NSString stringWithFormat:@"%.2f",b4avg];
                cell.statWorst.text = [NSString stringWithFormat:@"%.2f",w4avg];
                break;
                
            case 12:
                cell.statName.text = @"Par 5 Avg.";
                cell.statAve.text = par5avg;
                cell.statBest.text = [NSString stringWithFormat:@"%.2f",b5avg];
                cell.statWorst.text = [NSString stringWithFormat:@"%.2f",w5avg];
                break;
                
            case 13:
                cell.statName.text = @"Par Saves";
                cell.statAve.text = parSaves;
                cell.statBest.text = [NSString stringWithFormat:@"%.1f%%",bSave*100];
                cell.statWorst.text = [NSString stringWithFormat:@"%.1f%%",wSave*100];
                break;
                
            case 14:
                cell.statName.text = @"Bunkers";
                cell.statAve.text = bunkers;
                cell.statBest.text = [NSString stringWithFormat:@"%i",bBunk];
                cell.statWorst.text = [NSString stringWithFormat:@"%i",wBunk];
                break;
                
            case 15:
                cell.statName.text = @"Sand Saves";
                cell.statAve.text = sandSaves;
                cell.statBest.text = [NSString stringWithFormat:@"%.1f%%",bSSave*100];
                cell.statWorst.text = [NSString stringWithFormat:@"%.1f%%",wSSave*100];
                break;
                
            case 16:
                cell.statName.text = @"Penalties";
                cell.statAve.text = meanPen;
                cell.statBest.text = [NSString stringWithFormat:@"%i",bPen];
                cell.statWorst.text = [NSString stringWithFormat:@"%i",wPen];
                break;
            
            default:
                break;
        }
    }
    return cell;
}

-(void)getAllGames
{
    GameDAO *dao = [[GameDAO alloc] init];
    games = [dao getCompletedGames];
}

-(void)previousOptionTapped
{
    [self configureStats];
}

-(void)nextOptionTapped
{
    [self configureStats];
}

-(void)configureStats
{
    switch (slider.selectedItemIndex)
    {
        case 0:
            [self setToAllGames];
            break;
            
        case 1:
            [self setToGamesThisYear];
            break;
            
        case 2:
            [self setToGamesThisMonth];
            break;
            
        case 3:
            [self setToCustomSet];
            break;
            
        default:
            break;
    }
    
    if(slider.selectedItemIndex != 3)
    {
        if([self checkForZeroGames])
        {
            [self displayStats];
        }
        [self.tableView reloadData];
    }
}

-(void)setToAllGames
{
    [self getAllGames];
}

-(void)setToGamesThisYear
{
    [self getAllGames];
    NSMutableArray *gamesThisYear = [[NSMutableArray alloc] initWithObjects: nil];
    
    NSDate *date = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [gregorian components:(NSYearCalendarUnit) fromDate:date];
    NSInteger currentYear = [dateComponents year];
    
    for(Game *g in games)
    {
        NSDateComponents *dateComponents2 = [gregorian components:(NSYearCalendarUnit) fromDate:g.datePlayed];
        if([dateComponents2 year] == currentYear)
            [gamesThisYear addObject:g];
    }
    games = gamesThisYear;
}

-(void)setToGamesThisMonth
{
    [self getAllGames];
    NSMutableArray *gamesThisMonth = [[NSMutableArray alloc] initWithObjects: nil];
    
    NSDate *date = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [gregorian components:(NSMonthCalendarUnit) fromDate:date];
    NSInteger currentMonth = [dateComponents month];
    
    for(Game *g in games)
    {
        NSDateComponents *dateComponents2 = [gregorian components:(NSMonthCalendarUnit) fromDate:g.datePlayed];
        if([dateComponents2 month] == currentMonth)
            [gamesThisMonth addObject:g];
    }
    games = gamesThisMonth;
}

-(void)setToCustomSet
{
    games = [[NSMutableArray alloc] initWithObjects:nil];
    [dropDown expandView:tableView.frame.size.height];
}

-(void)checkCustomGameSet
{
    games = [gameList getSelectedGames];
    if([self checkForZeroGames])
    {
        [self displayStats];
    }
    [self.tableView reloadData];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

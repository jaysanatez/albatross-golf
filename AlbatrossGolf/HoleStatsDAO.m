//
//  HoleStatsDAO.m
//  SmartShot_2.1
//
//  Created by Jacob Sanchez on 9/3/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import "HoleStatsDAO.h"
#import "Hole.h"

@implementation HoleStatsDAO
/*
-(NSManagedObjectContext *)manageObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if([delegate performSelector:@selector(managedObjectContext)])
    {
        context = [delegate managedObjectContext];
    }
    return context;
}

-(NSMutableArray *)getHoleStatsForGame:(Game *)game
{
    NSManagedObjectContext *context = [self manageObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Holes"];
    NSMutableArray *holeStatsFromDB = [[context executeFetchRequest:request error:nil] mutableCopy];
    NSMutableArray *holeStats = [[NSMutableArray alloc] initWithCapacity:18];
    for(int i=0; i<18;i++)
    {
        [holeStats setObject:[NSNumber numberWithInt:0] atIndexedSubscript:i];
    }
    
    // puts only the ones that match into holeStats at index courseHole-1
    for(int i=0; i<[holeStatsFromDB count]; i++)
    {
        NSManagedObject *holeFromDB = [holeStatsFromDB objectAtIndex:i];
        Hole *hole = [[Hole alloc] init];
        hole.game = game;
        hole.holeNumber = [NSNumber numberWithInt:[[holeFromDB valueForKeyPath:@"courseHole"] intValue] ];
        hole.hitFairway = [[holeFromDB valueForKeyPath:@"hitFairway"] isEqualToString:@"true"];
        hole.gir = [[holeFromDB valueForKeyPath:@"hitGreen"] isEqualToString:@"true"];
        hole.putts = [NSNumber numberWithInt:[[holeFromDB valueForKeyPath:@"putts"] intValue]];
        hole.fairBunk = [[holeFromDB valueForKeyPath:@"reachedFBunker"] isEqualToString:@"true"];
        hole.greenBunk = [[holeFromDB valueForKeyPath:@"reachedGBunker"] isEqualToString:@"true"];
        hole.penalties = [NSNumber numberWithInt:[[holeFromDB valueForKeyPath:@"penalties"] intValue]];
        
        NSString *courseName = [holeFromDB valueForKeyPath:@"courseName"];
        NSDate *date = [holeFromDB valueForKeyPath:@"date"];
        NSString *scores = [holeFromDB valueForKeyPath:@"scores"];
        
        NSString *gameScores = [game.holeScores componentsJoinedByString:@","];
        if([game.coursePlayed.courseName isEqualToString:courseName] && [game.datePlayed isEqualToDate:date] &&
           [gameScores isEqualToString:scores])
            [holeStats setObject:hole atIndexedSubscript:([hole.holeNumber intValue]-1)];
    }
    NSLog(@"Retrieved HoleStats");
    return holeStats;
}

-(NSMutableArray *)getHoleStatsFromDBForGame:(Game *)game
{
    NSManagedObjectContext *context = [self manageObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Holes"];
    NSMutableArray *holeStatsFromDB = [[context executeFetchRequest:request error:nil] mutableCopy];
    NSLog(@"Retrieved HoleStatsFromDB");
    return holeStatsFromDB;
}

- (void)addHoleStats:(Hole *)hole forGame:(Game *)game
{
    NSManagedObjectContext *context = [self manageObjectContext];
    NSManagedObject *holeFromDB = [NSEntityDescription insertNewObjectForEntityForName:@"Holes" inManagedObjectContext:context];
    
    // to identify with correct game and hole
    [holeFromDB setValue:game.coursePlayed.courseName forKey:@"courseName"];
    [holeFromDB setValue:game.datePlayed forKey:@"date"];
    NSString *parString = [game.holeScores componentsJoinedByString:@","];
    [holeFromDB setValue:parString forKey:@"scores"];
    [holeFromDB setValue:hole.holeNumber forKey:@"courseHole"];
    
    
    // actual stats
    [holeFromDB setValue:(hole.hitFairway ? @"true" : @"false") forKey:@"hitFairway"];
    [holeFromDB setValue:(hole.gir ? @"true" : @"false") forKey:@"hitGreen"];
    [holeFromDB setValue:hole.putts forKey:@"putts"];
    [holeFromDB setValue:(hole.fairBunk ? @"true" : @"false") forKey:@"reachedFBunker"];
    [holeFromDB setValue:(hole.greenBunk ? @"true" : @"false") forKey:@"reachedGBunker"];
    [holeFromDB setValue:hole.penalties forKey:@"penalties"];
    
    NSError *error = nil;
    if(![context save:&error])
        NSLog(@"Save failed! %@ %@",error,[error localizedDescription]);
    NSLog(@"Added Stats");
}

- (void)updateHoleStatsOfDBHole:(NSManagedObject *)holeFromDB OfGame:(Game *)game AndHole:(Hole *)hole
{
    NSManagedObjectContext *context = [self manageObjectContext];
    NSString *parString = [game.holeScores componentsJoinedByString:@","];
    [holeFromDB setValue:parString forKey:@"scores"];
    
    // actual stats
    [holeFromDB setValue:(hole.hitFairway ? @"true" : @"false") forKey:@"hitFairway"];
    [holeFromDB setValue:(hole.gir ? @"true" : @"false") forKey:@"hitGreen"];
    [holeFromDB setValue:hole.putts forKey:@"putts"];
    [holeFromDB setValue:(hole.fairBunk ? @"true" : @"false") forKey:@"reachedFBunker"];
    [holeFromDB setValue:(hole.greenBunk ? @"true" : @"false") forKey:@"reachedGBunker"];
    [holeFromDB setValue:hole.penalties forKey:@"penalties"];
    
    NSError *error = nil;
    if(![context save:&error])
        NSLog(@"Save failed! %@ %@",error,[error localizedDescription]);
    NSLog(@"Updated Stats");
}*/

@end

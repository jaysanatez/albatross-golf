//
//  GameDAO.m
//  SmartShot_2.1
//
//  Created by Jacob Sanchez on 9/3/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import "GameDAO.h"
#import "Game.h"

@implementation GameDAO

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

-(NSMutableArray *)getAllGames
{
    NSManagedObjectContext *context = [self manageObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Games"];
    NSMutableArray *gamesFromDB = [[context executeFetchRequest:request error:nil] mutableCopy];
    NSMutableArray *games = [[NSMutableArray alloc] initWithObjects:nil];
    
    for (int i=0; i<[gamesFromDB count]; i++)
    {
        NSManagedObject *gameFromDB = [gamesFromDB objectAtIndex:i];
        Game *game = [[Game alloc] init];
        
        game.coursePlayed = [self getCourseWithName:[gameFromDB valueForKeyPath:@"course"]];
        game.datePlayed = [gameFromDB valueForKeyPath:@"date"];
        game.completed = [[gameFromDB valueForKeyPath:@"completed"] isEqualToString:@"true"];
        
        NSString *scoreSeq = [gameFromDB valueForKeyPath:@"scores"];
        NSArray *strArray = [scoreSeq componentsSeparatedByString:@","];
        NSMutableArray *scoreSequence = [[NSMutableArray alloc] initWithCapacity:[strArray count]];
        for(int i=0; i<[strArray count]; i++)
            [scoreSequence setObject:[NSNumber numberWithInt:[[strArray objectAtIndex:i] intValue]]
                  atIndexedSubscript:i];
        game.holeScores = scoreSequence;
        
        [games addObject:game];
    }
    NSLog(@"Retrieved All Games");
    return games;
}

-(NSMutableArray *)getCompletedGames
{
    NSManagedObjectContext *context = [self manageObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Games"];
    NSMutableArray *gamesFromDB = [[context executeFetchRequest:request error:nil] mutableCopy];
    NSMutableArray *games = [[NSMutableArray alloc] initWithObjects:nil];
    
    for (int i=0; i<[gamesFromDB count]; i++)
    {
        NSManagedObject *gameFromDB = [gamesFromDB objectAtIndex:i];
        Game *game = [[Game alloc] init];
        
        game.coursePlayed = [self getCourseWithName:[gameFromDB valueForKeyPath:@"course"]];
        game.datePlayed = [gameFromDB valueForKeyPath:@"date"];
        game.completed = [[gameFromDB valueForKeyPath:@"completed"] isEqualToString:@"true"];
        
        NSString *scoreSeq = [gameFromDB valueForKeyPath:@"scores"];
        NSArray *strArray = [scoreSeq componentsSeparatedByString:@","];
        NSMutableArray *scoreSequence = [[NSMutableArray alloc] initWithCapacity:[strArray count]];
        for(int i=0; i<[strArray count]; i++)
            [scoreSequence setObject:[NSNumber numberWithInt:[[strArray objectAtIndex:i] intValue]]
                  atIndexedSubscript:i];
        game.holeScores = scoreSequence;
        
        if(game.completed)
            [games addObject:game];
    }
    NSLog(@"Retrieved Completed Games");
    return games;
}

-(NSMutableArray *)getGamesFromDB
{
    NSManagedObjectContext *context = [self manageObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Games"];
    NSMutableArray *gamesFromDB = [[context executeFetchRequest:request error:nil] mutableCopy];
    NSLog(@"Retrieved GamesFromDB");
    return gamesFromDB;
}

-(Course *)getCourseWithName:(NSString *)courseName
{
    NSManagedObjectContext *context = [self manageObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Courses"];
    NSArray *coursesFromDB = [[context executeFetchRequest:request error:nil] mutableCopy];
    NSMutableArray *courses = [[NSMutableArray alloc] initWithObjects:nil];
    
    // populate courses
    for(int i=0; i<[coursesFromDB count]; i++)
    {
        NSManagedObject *courseFromDB = [coursesFromDB objectAtIndex:i];
        Course *course = [[Course alloc] init];
        course.courseName = [courseFromDB valueForKeyPath:@"name"];
        course.courseLocation = [courseFromDB valueForKeyPath:@"location"];
        course.coursePar = [courseFromDB valueForKeyPath:@"par"];
        course.courseRating = [courseFromDB valueForKeyPath:@"rating"];
        course.courseSlope = [courseFromDB valueForKeyPath:@"slope"];
        
        NSString *parSeq = [courseFromDB valueForKeyPath:@"parSequence"];
        NSArray *strArray = [parSeq componentsSeparatedByString:@","];
        NSMutableArray *parSequence = [[NSMutableArray alloc] initWithCapacity:[strArray count]];
        for(int i=0; i<[strArray count]; i++)
            [parSequence setObject:[NSNumber numberWithInt:[[strArray objectAtIndex:i] intValue]] atIndexedSubscript:i];
        course.parSequence = parSequence;
        
        [courses addObject:course];
    }
    
    // traverse courses
    for(Course *thisCourse in courses)
    {
        if([thisCourse.courseName isEqualToString:courseName])
            return thisCourse;
    }
    return nil;
}

-(void)addGame:(Game *)game
{
    NSManagedObjectContext *context = [self manageObjectContext];
    NSManagedObject *gameForDB = [NSEntityDescription insertNewObjectForEntityForName:@"Games"
                                                               inManagedObjectContext:context];
    [gameForDB setValue:[game.coursePlayed courseName] forKey:@"course"];
    [gameForDB setValue:[game datePlayed] forKey:@"date"];
    [gameForDB setValue:(game.completed ? @"true" : @"false") forKey:@"completed"];
    NSString* parsAsString = [game.holeScores componentsJoinedByString:@","];
    [gameForDB setValue:parsAsString forKey:@"scores"];
    
    
    NSError *error = nil;
    if(![context save:&error])
        NSLog(@"Save failed! %@ %@",error,[error localizedDescription]);
    NSLog(@"Added Game");
}

-(void)updateGame:(NSManagedObject *)gameFromDB WithGame:(Game *)game
{
    NSManagedObjectContext *context = [self manageObjectContext];
    [gameFromDB setValue:[game.coursePlayed courseName] forKey:@"course"];
    [gameFromDB setValue:[game datePlayed] forKey:@"date"];
    [gameFromDB setValue:(game.completed?@"true" : @"false") forKey:@"completed"];
    NSString* parsAsString = [game.holeScores componentsJoinedByString:@","];
    [gameFromDB setValue:parsAsString forKey:@"scores"];
    
    NSError *error = nil;
    if(![context save:&error])
        NSLog(@"Save failed! %@ %@",error,[error localizedDescription]);
    NSLog(@"Updated Game");
}

-(void)deleteGameFromDB:(NSManagedObject *)game
{
    NSManagedObjectContext *context = [self manageObjectContext];
    [context deleteObject:game];
    
    NSError *error = nil;
    if(![context save:&error])
        NSLog(@"Save failed! %@ %@",error,[error localizedDescription]);
    [self removeUnmatchedHoleStats];
    NSLog(@"Deleted Game");
}

-(void)removeUnmatchedHoleStats
{
    NSManagedObjectContext *context = [self manageObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Holes"];
    NSArray *existingHoleStats = [[context executeFetchRequest:request error:nil] mutableCopy];
    
    for(int i=0; i<[existingHoleStats count]; i++)
    {
        NSManagedObject *obj = (NSManagedObject *)[existingHoleStats objectAtIndex:i];
        NSString *courseName = [obj valueForKeyPath:@"courseName"];
        NSDate *date = [obj valueForKeyPath:@"date"];
        NSString *scores = [obj valueForKeyPath:@"scores"];
        NSMutableArray *games = [self getAllGames];
        
        BOOL foundOne = NO;
        for(Game *g in games)
        {
            NSString *gameScores = [g.holeScores componentsJoinedByString:@","];
            if([g.coursePlayed.courseName isEqualToString:courseName] && [g.datePlayed isEqualToDate:date] &&
               [gameScores isEqualToString:scores])
            {
                foundOne = YES;
            }
        }
        
        if(!foundOne)
        {
            [context deleteObject:obj];
            NSLog(@"Removed Unmatched Stats");
        }
    }
}*/

@end

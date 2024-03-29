//
//  RoundDAO.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 11/5/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import "RoundDAO.h"
#import "AppDelegate.h"

@implementation RoundDAO

static NSString *baseUrl, *apiVersion;

@synthesize fetch_delegate, post_delegate;

- (void)fetchAllRoundsForUser:(long)user_id
{
    NSString *urlString = [NSString stringWithFormat:@"user/%li/rounds",user_id];
    [self submitRoundFetchRequest:urlString];
}

- (void)fetchRoundHolesWithRound:(long)round_id
{
    NSString *urlString = [NSString stringWithFormat:@"round/%li/holes",round_id];
    [self submitRoundHoleFetchRequest:urlString forRound:round_id];
}

- (void)fetchStatsForRound:(long)round_id
{
    NSString *urlString = [NSString stringWithFormat:@"round/%li/stats",round_id ];
    [self submitRoundStatFetchRequest:urlString forRound:round_id];
}

- (void)fetchHoleScoresForRoundId:(long)round_id
{
    NSString *urlString = [NSString stringWithFormat:@"round/%li/scores",round_id];
    [self submitHoleScoreFetchRequest:urlString forRound:round_id];
}

// url request methods

- (void)submitRoundFetchRequest:(NSString *)urlString
{
    __block NSMutableArray *rounds = [[NSMutableArray alloc] initWithObjects:nil];
    
    AppDelegate *d = [UIApplication sharedApplication].delegate;
    baseUrl = d.baseUrl;
    apiVersion = d.apiVersion;
    
    NSString *apiUrl = [NSString stringWithFormat:@"%@%@%@",baseUrl,apiVersion,urlString];
    NSLog(@"REQUESTED URL: %@",apiUrl);
    NSURL *url = [NSURL URLWithString:apiUrl];
    NSString *body = @"";
    NSString *token = [d getToken];
    NSString *tokenHeader = [NSString stringWithFormat:@"Token %@",token];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"GET"];
    [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [urlRequest addValue:tokenHeader forHTTPHeaderField:@"Authorization"];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // the donger
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *error){
         if([data length] > 0 && error == nil)
         {
             // do the things
             dispatch_async(dispatch_get_main_queue(), ^(void){
                 [rounds addObjectsFromArray:[self parseAllRoundData:data]];
                 [fetch_delegate refreshRoundList:rounds];
             });
         }
         else if ([data length] == 0)
         {
             NSLog(@"Round retrieval returned an empty response.");
         }
         else if (error != nil)
         {
             NSLog(@"Error = %@",[error description]);
         }
     }];
}

- (void)submitRoundHoleFetchRequest:(NSString *)urlString forRound:(long)roundId
{
    __block NSMutableArray *roundHoles = [[NSMutableArray alloc] initWithObjects:nil];
    
    AppDelegate *d = [UIApplication sharedApplication].delegate;
    baseUrl = d.baseUrl;
    apiVersion = d.apiVersion;
    
    NSString *apiUrl = [NSString stringWithFormat:@"%@%@%@",baseUrl,apiVersion,urlString];
    NSLog(@"REQUESTED URL: %@",apiUrl);
    NSURL *url = [NSURL URLWithString:apiUrl];
    NSString *body = @"";
    NSString *token = [d getToken];
    NSString *tokenHeader = [NSString stringWithFormat:@"Token %@",token];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"GET"];
    [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [urlRequest addValue:tokenHeader forHTTPHeaderField:@"Authorization"];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // the donger
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *error){
         if([data length] > 0 && error == nil)
         {
             // do the things
             dispatch_async(dispatch_get_main_queue(), ^(void){
                 [roundHoles addObjectsFromArray:[self parseAllRoundHoleData:data]];
                 [fetch_delegate roundHolesFetched:roundHoles forRoundId:roundId];
             });
         }
         else if ([data length] == 0)
         {
             NSLog(@"Round retrieval returned an empty response.");
         }
         else if (error != nil)
         {
             NSLog(@"Error = %@",[error description]);
         }
     }];
}

- (void)submitRoundStatFetchRequest:(NSString *)urlString forRound:(long)roundId
{
    AppDelegate *d = [UIApplication sharedApplication].delegate;
    baseUrl = d.baseUrl;
    apiVersion = d.apiVersion;
    
    NSString *apiUrl = [NSString stringWithFormat:@"%@%@%@",baseUrl,apiVersion,urlString];
    NSLog(@"REQUESTED URL: %@",apiUrl);
    NSURL *url = [NSURL URLWithString:apiUrl];
    NSString *body = @"";
    NSString *token = [d getToken];
    NSString *tokenHeader = [NSString stringWithFormat:@"Token %@",token];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"GET"];
    [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [urlRequest addValue:tokenHeader forHTTPHeaderField:@"Authorization"];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // the donger
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *error){
         if([data length] > 0 && error == nil)
         {
             // do the things
             dispatch_async(dispatch_get_main_queue(), ^(void){
                 [fetch_delegate roundStatsFetched:[self parseAllRoundStatData:data] forRoundId:roundId];
             });
         }
         else if ([data length] == 0)
         {
             NSLog(@"Round retrieval returned an empty response.");
         }
         else if (error != nil)
         {
             NSLog(@"Error = %@",[error description]);
         }
     }];
}

- (void)submitHoleScoreFetchRequest:(NSString *)urlString forRound:(long)roundId
{
    AppDelegate *d = [UIApplication sharedApplication].delegate;
    baseUrl = d.baseUrl;
    apiVersion = d.apiVersion;
    
    __block NSMutableArray *holeScores = [[NSMutableArray alloc] initWithObjects:nil];
    
    NSString *apiUrl = [NSString stringWithFormat:@"%@%@%@",baseUrl,apiVersion,urlString];
    NSLog(@"REQUESTED URL: %@",apiUrl);
    NSURL *url = [NSURL URLWithString:apiUrl];
    NSString *body = @"";
    NSString *token = [d getToken];
    NSString *tokenHeader = [NSString stringWithFormat:@"Token %@",token];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"GET"];
    [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [urlRequest addValue:tokenHeader forHTTPHeaderField:@"Authorization"];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // the donger
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *error){
         if([data length] > 0 && error == nil)
         {
             // do the things
             dispatch_async(dispatch_get_main_queue(), ^(void){
                 [holeScores addObjectsFromArray:[self parseAllHoleScoreData:data]];
                 [fetch_delegate holeScoresFetched:holeScores forRoundId:roundId];
             });
         }
         else if ([data length] == 0)
         {
             NSLog(@"Round retrieval returned an empty response.");
         }
         else if (error != nil)
         {
             NSLog(@"Error = %@",[error description]);
         }
     }];
}

// json parse methods

- (NSMutableArray *)parseAllRoundData:(NSData *)data
{
    NSMutableArray *rounds = [[NSMutableArray alloc] initWithObjects:nil];
    
    NSString *myData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"JSON data = %@...", [myData length] > 100 ? [myData substringToIndex:100] : myData);
    NSError *error = nil;
    
    //parsing the JSON response
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (jsonObject != nil && error == nil && [jsonObject isKindOfClass:[NSArray class]])
    {
        NSLog(@"Successfully deserialized.");
        
        for(NSDictionary *roundDict in jsonObject)
        {
            [rounds addObject:[self parseSingleRoundData:roundDict]];
        }
    }
    return rounds;
}

- (NSMutableArray *)parseAllRoundHoleData:(NSData *)data
{
    NSMutableArray *roundHoles = [[NSMutableArray alloc] initWithObjects:nil];
    
    NSString *myData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"JSON data = %@...", [myData length] > 100 ? [myData substringToIndex:100] : myData);
    NSError *error = nil;
    
    //parsing the JSON response
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (jsonObject != nil && error == nil && [jsonObject isKindOfClass:[NSArray class]])
    {
        NSLog(@"Successfully deserialized.");
        
        for(NSDictionary *rhDict in jsonObject)
        {
            [roundHoles addObject:[self parseSingleRoundHoleData:rhDict]];
        }
    }
    return roundHoles;
}

- (RoundStats *)parseAllRoundStatData:(NSData *)data
{
    RoundStats *rs = [[RoundStats alloc] init];
    
    NSString *myData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"JSON data = %@...", [myData length] > 100 ? [myData substringToIndex:100] : myData);
    NSError *error = nil;
    
    //parsing the JSON response
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (jsonObject != nil && error == nil && [jsonObject isKindOfClass:[NSDictionary class]])
    {
        NSLog(@"Successfully deserialized.");
        NSDictionary *d = (NSDictionary *)jsonObject;
        
        rs.total_score = [[d valueForKey:@"score"] longValue];
        
        rs.num_putts = [[d valueForKey:@"putt"] longValue];
        rs.num_penalty_strokes = [[d valueForKey:@"penalty_strokes"] longValue];
        
        rs.num_one_putts = [[d valueForKey:@"one_putt"] longValue];
        rs.num_three_putts = [[d valueForKey:@"three_putt"] longValue];
        
        rs.num_bunkers_hit = [[d valueForKey:@"bunker_hit"] longValue];
        
        rs.par_3_avg = [[d valueForKey:@"par_3_avg"] doubleValue];
        rs.par_4_avg = [[d valueForKey:@"par_4_avg"] doubleValue];
        rs.par_5_avg = [[d valueForKey:@"par_5_avg"] doubleValue];
        
        rs.num_eagles = [[d valueForKey:@"eagle"] longValue];
        rs.num_birdies = [[d valueForKey:@"birdie"] longValue];
        rs.num_pars = [[d valueForKey:@"par"] longValue];
        rs.num_bogeys = [[d valueForKey:@"bogey"] longValue];
        rs.num_double_bogeys = [[d valueForKey:@"double_bogey"] longValue];
        rs.num_doubles_plus = [[d valueForKey:@"double_bogey_plus"] longValue];
        
        rs.num_greens_hit = [[d valueForKey:@"hit_green"] longValue];
        rs.num_greens_possible = [[d valueForKey:@"green_possible"] longValue];
        
        rs.num_fairways_hit = [[d valueForKey:@"hit_fairway"] longValue];
        rs.num_fairways_possible = [[d valueForKey:@"fairway_possible"] longValue];
        
        rs.num_par_saves = [[d valueForKey:@"par_save"] longValue];
        rs.num_par_saves_possible = [[d valueForKey:@"par_save_possible"] longValue];
        
        rs.num_sand_saves = [[d valueForKey:@"sand_save"] longValue];
        rs.num_sand_saves_possible = [[d valueForKey:@"sand_save_possible"] longValue];
    }
    return rs;
}

- (NSMutableArray *)parseAllHoleScoreData:(NSData *)data
{
    NSMutableArray *holeScores = [[NSMutableArray alloc] initWithObjects:nil];
    
    NSString *myData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"JSON data = %@...", [myData length] > 100 ? [myData substringToIndex:100] : myData);
    NSError *error = nil;
    
    //parsing the JSON response
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (jsonObject != nil && error == nil && [jsonObject isKindOfClass:[NSArray class]])
    {
        NSLog(@"Successfully deserialized.");
        
        for(NSDictionary *hsDict in jsonObject)
        {
            HoleScore *hs = [[HoleScore alloc] init];
            
            hs.hole_number = [[hsDict valueForKey:@"hole"] longValue];
            hs.hole_par = [[hsDict valueForKey:@"par"] longValue];
            hs.score = [[hsDict valueForKey:@"score"] longValue];
            
            [holeScores addObject:hs];
        }
    }
    return holeScores;
}

- (long)postRound:(Round *)round forUser:(long)user_id
{
    return [self submitRoundRequest:round forUser:user_id withMethod:@"POST"];
}

- (void)updateRound:(Round *)round forUser:(long)user_id
{
    [self submitRoundRequest:round forUser:user_id withMethod:@"PUT"];;
}

- (long)submitRoundRequest:(Round *)round forUser:(long)user_id withMethod:(NSString *)method
{
    AppDelegate *d = [UIApplication sharedApplication].delegate;
    baseUrl = d.baseUrl;
    apiVersion = d.apiVersion;
    
    NSString *post = [NSString stringWithFormat:@"id=%li&course=%li&tee=%li&completed=%@",round.id_num, round.course_id,round.tee_id, [self getBooleanString:round.is_complete]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSString *urlString = [NSString stringWithFormat:@"%@%@user/%li/rounds",baseUrl,apiVersion,user_id];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSLog(@"POSTING TO: %@", urlString);
    
    NSString *token = [d getToken];
    NSString *tokenHeader = [NSString stringWithFormat:@"Token %@",token];
    
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:method];
    [urlRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [urlRequest addValue:tokenHeader forHTTPHeaderField:@"Authorization"];
    [urlRequest setHTTPBody:postData];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest
                                         returningResponse:&response
                                                     error:&error];
    
    if(error != nil)
    {
        NSLog(@"Error returned of %@",error);
    }
    else if([data length] == 0)
    {
        NSLog(@"Round posting returned no data.");
    }
    else
    {
        // normal execution here
        NSString *decodedData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSError *json_error = nil;
        NSLog(@"Data from round post: %@",decodedData);
        
        //parsing the JSON response
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&json_error];
        if (jsonObject != nil && error == nil && [jsonObject isKindOfClass:[NSDictionary class]])
        {
            NSLog(@"Successfully deserialized.");
            
            Round *r = [self parseSingleRoundData:jsonObject];
            
            [post_delegate roundPostSucceeded];
            
            return r.id_num;
        }
    }
    
    return -1;
}

- (long)postRoundHole:(RoundHole *)round_hole forUser:(long)user_id
{
    return [self submitRoundHoleRequest:round_hole forUser:user_id withMethod:@"POST"];
}

- (void)updateRoundHole:(RoundHole *)round_hole forUser:(long)user_id
{
    [self submitRoundHoleRequest:round_hole forUser:user_id withMethod:@"PUT"];
}

- (long)submitRoundHoleRequest:(RoundHole *)round_hole forUser:(long)user_id withMethod:(NSString *)method
{
    AppDelegate *d = [UIApplication sharedApplication].delegate;
    baseUrl = d.baseUrl;
    apiVersion = d.apiVersion;
    
    NSString *post = [NSString stringWithFormat:@"id=%li&score=%li&putts=%li&penalties=%li&hit_fairway=%@&hit_green=%@&hit_fairway_bunker=%@&hit_green_bunker=%@",round_hole.id_num, round_hole.score,round_hole.putts,round_hole.penalties,[self getBooleanString:round_hole.hitFairway],[self getBooleanString:round_hole.hitGir],[self getBooleanString:round_hole.hitFairwayBunker], [self getBooleanString:round_hole.hitGreensideBunker]];
    NSLog(@"POST: %@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@round/%li/hole/%li",baseUrl,apiVersion,round_hole.round_id,round_hole.hole_id];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSLog(@"POSTING TO: %@", urlString);
    
    NSString *token = [d getToken];
    NSString *tokenHeader = [NSString stringWithFormat:@"Token %@",token];
    
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:method];
    [urlRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [urlRequest addValue:tokenHeader forHTTPHeaderField:@"Authorization"];
    [urlRequest setHTTPBody:postData];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest
                                         returningResponse:&response
                                                     error:&error];
    
    if(error != nil)
    {
        NSLog(@"Error returned of %@",error);
    }
    else if([data length] == 0)
    {
        NSLog(@"Round posting returned no data.");
    }
    else
    {
        // normal execution here
        NSString *decodedData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSError *json_error = nil;
        NSLog(@"Data from round post: %@", [decodedData length] > 100 ? [decodedData substringToIndex:100] : decodedData);
        
        //parsing the JSON response
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&json_error];
        if (jsonObject != nil && error == nil && [jsonObject isKindOfClass:[NSDictionary class]])
        {
            NSLog(@"Successfully deserialized.");
            
            RoundHole *rh = [self parseSingleRoundHoleData:jsonObject];
            
            [post_delegate roundholePostSucceeded];
            
            return rh.id_num;
        }
    }
    
    return -1;
}

-(NSString *)getBooleanString:(BOOL)b
{
    return b ? @"true" : @"false";
}

- (Round *)parseSingleRoundData:(NSDictionary *)roundDict
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    NSString *dateString;
    
    Round *round = [[Round alloc] init];
    
    round.id_num = [[roundDict valueForKey:@"id"] longValue];
    round.user_id = [[roundDict valueForKey:@"user"] longValue];
    
    NSDictionary *courseDict = [roundDict objectForKey:@"course"];
    round.course_name = [courseDict valueForKey:@"name"];
    round.course_id = [[courseDict valueForKey:@"id"] longValue];
    
    dateString = [roundDict objectForKey:@"date"];
    round.date_played = [dateFormat dateFromString:dateString];
    round.tee_id = [[roundDict valueForKey:@"tee"] longValue];
    round.is_complete = [[roundDict valueForKey:@"completed"] boolValue];
    
    return round;
}

- (RoundHole *)parseSingleRoundHoleData:(NSDictionary *)rhDict
{
    RoundHole *rh = [[RoundHole alloc] init];
    
    rh.score = [[rhDict valueForKey:@"score"] longValue];
    rh.putts = [[rhDict valueForKey:@"putts"] longValue];
    rh.penalties = [[rhDict valueForKey:@"penalties"] longValue];
    
    rh.hitFairway = [[rhDict valueForKey:@"hit_fairway"] boolValue];
    rh.hitGir = [[rhDict valueForKey:@"hit_green"] boolValue];
    rh.hitFairwayBunker = [[rhDict valueForKey:@"hit_fairway_bunker"] boolValue];
    rh.hitGreensideBunker = [[rhDict valueForKey:@"hit_green_bunker"] boolValue];
    
    rh.id_num = [[rhDict valueForKey:@"id"] longValue];
    rh.round_id = [[rhDict valueForKey:@"round"] longValue];
    rh.hole_id = [[rhDict valueForKey:@"hole"] longValue];
    
    return rh;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // post request handlers
    if(![[connection.originalRequest HTTPMethod] isEqualToString:@"POST"])
    {
        return;
    }
    
    if (error.code == NSURLErrorTimedOut)
    {
        NSLog(@"Round Post Timeout");
        [post_delegate roundPostTimedOut];
    }
    else
    {
        NSLog(@"Something else went wrong");
        [post_delegate roundPostThrewError:error];
    }
}

@end
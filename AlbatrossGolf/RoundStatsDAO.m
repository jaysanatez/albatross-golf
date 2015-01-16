//
//  RoundStatsDAO.m
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/16/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import "RoundStatsDAO.h"

static NSString *baseUrl = @"http://brobin.pythonanywhere.com/v1/";

@implementation RoundStatsDAO

@synthesize delegate;

- (void)fetchStatsForRound:(NSNumber *)round_id
{
    NSString *urlString = [NSString stringWithFormat:@"round/%@/stats",[round_id stringValue]];
    [self submitRoundFetchRequest:urlString forRound:round_id];
}

- (void)submitRoundFetchRequest:(NSString *)urlString forRound:(NSNumber *)roundId
{
    NSString *apiUrl = [NSString stringWithFormat:@"%@%@",baseUrl,urlString];
    NSLog(@"REQUESTED URL: %@",apiUrl);
    NSURL *url = [NSURL URLWithString:apiUrl];
    NSString *body = @"";
    NSString *token = @"7ebb3f3d899a23bcb680ebcdc50e247fc4d21fca";
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
                 [delegate roundStatsForRound:roundId roundStats:[self parseAllRoundHoleData:data]];
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

- (RoundStats *)parseAllRoundHoleData:(NSData *)data
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
        
        rs.total_score = [d valueForKey:@"score"];
        
        rs.num_putts = [d valueForKey:@"putt"];
        rs.num_penalty_strokes = [d valueForKey:@"penalty_strokes"];
        
        rs.num_one_putts = [d valueForKey:@"one_putt"];
        rs.num_three_putts = [d valueForKey:@"three_putt"];
        
        rs.num_bunkers_hit = [d valueForKey:@"bunker_hit"];
        
        rs.par_3_avg = [d valueForKey:@"par_3_avg"];
        rs.par_4_avg = [d valueForKey:@"par_4_avg"];
        rs.par_5_avg = [d valueForKey:@"par_5_avg"];
        
        rs.num_eagles = [d valueForKey:@"eagle"];
        rs.num_birdies = [d valueForKey:@"birdie"];
        rs.num_pars = [d valueForKey:@"par"];
        rs.num_bogeys = [d valueForKey:@"bogey"];
        rs.num_double_bogeys = [d valueForKey:@"double_bogey"];
        rs.num_doubles_plus = [d valueForKey:@"double_bogey_plus"];
        
        rs.num_greens_hit = [d valueForKey:@"hit_green"];
        rs.num_greens_possible = [d valueForKey:@"green_possible"];
        
        rs.num_fairways_hit = [d valueForKey:@"hit_fairway"];
        rs.num_fairways_possible = [d valueForKey:@"fairway_possible"];
        
        rs.num_par_saves = [d valueForKey:@"par_save"];
        rs.num_par_saves_possible = [d valueForKey:@"par_save_possible"];
        
        rs.num_sand_saves = [d valueForKey:@"sand_save"];
        rs.num_sand_saves_possible = [d valueForKey:@"sand_save_possible"];
    }
    return rs;
}

@end

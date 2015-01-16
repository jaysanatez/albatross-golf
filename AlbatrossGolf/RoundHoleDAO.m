//
//  RoundHoleDAO.m
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/14/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import "RoundHoleDAO.h"
#import "RoundHole.h"

@implementation RoundHoleDAO

static NSString *baseUrl = @"http://brobin.pythonanywhere.com/v1/";

@synthesize delegate;

- (void)fetchRoundHolesWithRound:(NSNumber *)round_id
{
    NSString *urlString = [NSString stringWithFormat:@"round/%@/holes",[round_id stringValue]];
    [self submitRoundFetchRequest:urlString forRound:round_id];
}

- (void)submitRoundFetchRequest:(NSString *)urlString forRound:(NSNumber *)roundId
{
    __block NSMutableArray *roundHoles = [[NSMutableArray alloc] initWithObjects:nil];
    
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
                [roundHoles addObjectsFromArray:[self parseAllRoundHoleData:data]];
                [delegate roundHolesForRound:roundHoles roundId:roundId];
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
            RoundHole *rh = [[RoundHole alloc] init];
            
            rh.score = [rhDict valueForKey:@"score"];
            rh.putts = [rhDict valueForKey:@"putts"];
            rh.penalties = [rhDict valueForKey:@"penalties"];
            
            rh.hitFairway = [[rhDict valueForKey:@"hit_fairway"] boolValue];
            rh.hitGir = [[rhDict valueForKey:@"hit_green"] boolValue];
            rh.hitFairwayBunker = [[rhDict valueForKey:@"hit_fairway_bunker"] boolValue];
            rh.hitGreensideBunker = [[rhDict valueForKey:@"hit_green_bunker"] boolValue];
            
            rh.round_id = [rhDict valueForKey:@"round"];
            rh.hole_id = [rhDict valueForKey:@"hole"];
        
            [roundHoles addObject:rh];
        }
    }
    return roundHoles;
}

@end

//
//  HoleScoreDAO.m
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/16/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import "HoleScoreDAO.h"
#import "HoleScore.h"

@implementation HoleScoreDAO

static NSString *baseUrl = @"http://brobin.pythonanywhere.com/v1/";

@synthesize delegate;

- (void)fetchHoleScoresForRoundId:(NSNumber *)round_id
{
    NSString *urlString = [NSString stringWithFormat:@"round/%@/scores",[round_id stringValue]];
    [self submitRoundFetchRequest:urlString forRound:round_id];
}

- (void)submitRoundFetchRequest:(NSString *)urlString forRound:(NSNumber *)roundId
{
    __block NSMutableArray *holeScores = [[NSMutableArray alloc] initWithObjects:nil];
    
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
                 [holeScores addObjectsFromArray:[self parseAllHoleScoreData:data]];
                 [delegate holeScoresFetched:holeScores forRoundId:roundId];
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
            
            hs.hole_number = [hsDict valueForKey:@"hole"];
            hs.hole_par = [hsDict valueForKey:@"par"];
            hs.score = [hsDict valueForKey:@"score"];
            
            [holeScores addObject:hs];
        }
    }
    return holeScores;
}

@end

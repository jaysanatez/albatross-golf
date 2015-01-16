//
//  RoundDAO.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 11/5/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import "RoundDAO.h"
#import "Round.h"
#import "PastRoundsVC.h"

@implementation RoundDAO

static NSString *baseUrl = @"http://brobin.pythonanywhere.com/v1/";

@synthesize delegate;

- (void)fetchAllRoundsForUser:(NSNumber *)user_id
{
    NSString *urlString = [NSString stringWithFormat:@"user/%@/rounds",[user_id stringValue]];
    [self submitRoundFetchRequest:urlString];
}

- (void)submitRoundFetchRequest:(NSString *)urlString
{
    __block NSMutableArray *rounds = [[NSMutableArray alloc] initWithObjects:nil];
    
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
                 [rounds addObjectsFromArray:[self parseAllRoundData:data]];
                 [delegate refreshRoundList:rounds];
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
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
        NSString *dateString;
        
        for(NSDictionary *roundDict in jsonObject)
        {
            Round *round = [[Round alloc] init];
            
            round.id_num = [roundDict objectForKey:@"id"];
            round.user_id = [roundDict objectForKey:@"user"];
            
            NSDictionary *courseDict = [roundDict objectForKey:@"course"];
            round.course_name = [courseDict objectForKey:@"name"];
            round.course_id = [courseDict objectForKey:@"id"];
            
            dateString = [roundDict objectForKey:@"date"];
            round.date_played = [dateFormat dateFromString:dateString];
            round.tee_id = [roundDict objectForKey:@"tee"];
            round.is_complete = [[roundDict valueForKey:@"completed"] boolValue];
            
            [rounds addObject:round];
        }
    }
    return rounds;
}

@end

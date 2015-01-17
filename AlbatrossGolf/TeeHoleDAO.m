//
//  TeeHoleDAO.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 10/19/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import "TeeHoleDAO.h"
#import "ScorecardVC.h"
#import "TeeHole.h"

@implementation TeeHoleDAO
{
    NSString *urlExt;
}

static NSString *baseUrl = @"http://brobin.pythonanywhere.com/v1/";

@synthesize delegate;

- (void)fetchTeeHolesForTee:(long)teeId
{
    __block NSMutableArray *teeHoles = [[NSMutableArray alloc] initWithObjects:nil];
    
    NSString *apiUrl = [NSString stringWithFormat:@"%@tee/%li/holes",baseUrl,teeId];
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
                 [teeHoles addObjectsFromArray:[self parseAllTeeHoleData:data]];
                 [delegate refreshTeeHoles:teeHoles];
             });
         }
         else if ([data length] == 0)
         {
             NSLog(@"Hole retrieval returned an empty response.");
         }
         else if (error != nil)
         {
             NSLog(@"Error = %@",[error description]);
         }
     }];
}

- (NSMutableArray *)parseAllTeeHoleData:(NSData *)data
{
    NSMutableArray *teeHoles = [[NSMutableArray alloc] initWithObjects:nil];
    
    NSString *myData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"JSON data = %@...", [myData length] > 100 ? [myData substringToIndex:100] : myData);
    NSError *error = nil;
    
    //parsing the JSON response
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (jsonObject != nil && error == nil && [jsonObject isKindOfClass:[NSArray class]])
    {
        NSLog(@"Successfully deserialized.");
        
        for(NSDictionary *tHoleDict in jsonObject)
        {
            TeeHole *tHole = [[TeeHole alloc] init];
            
            tHole.id_num = [tHoleDict objectForKey:@"id"];
            tHole.yardage = [tHoleDict objectForKey:@"yardage"];
            tHole.par = [tHoleDict objectForKey:@"par"];
            tHole.handicap = [tHoleDict objectForKey:@"handicap"];
            tHole.hole_id = [tHoleDict objectForKey:@"hole"];
            tHole.tee_id = [tHoleDict objectForKey:@"tee"];
            
            [teeHoles insertObject:tHole atIndex:([tHole.hole_id intValue]-1)]; // murder
        }
    }
    return teeHoles;
}

@end

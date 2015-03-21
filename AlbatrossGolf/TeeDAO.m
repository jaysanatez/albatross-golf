//
//  TeeDAO.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 10/19/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import "TeeDAO.h"
#import "AppDelegate.h"

@implementation TeeDAO


static NSString *baseUrl, *apiVersion;

- (NSMutableArray *)fetchTeesForCourse:(long)courseId
{
    NSString *urlString = [NSString stringWithFormat:@"course/%li/tees",courseId];
    return [self submitTeeFetchRequest:urlString];
}

- (NSMutableArray *)fetchTeesForUser:(long)userId
{
    NSString *urlString = [NSString stringWithFormat:@"user/%li/tees",userId];
    return [self submitTeeFetchRequest:urlString];
}

- (Tee *)fetchTeeWithTeeId:(long)teeId
{
    NSString *urlString = [NSString stringWithFormat:@"tee/%li",teeId];
    return (Tee *)[[self submitTeeFetchRequest:urlString] objectAtIndex:0];
}

- (NSMutableArray *)submitTeeFetchRequest:(NSString *)urlString
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
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error]; // the donger
    
    if([data length] > 0 && error == nil)
    {
        // normal execution
        return [self parseAllTeeData:data];
    }
    else if ([data length] == 0)
    {
        NSLog(@"Tee retrieval returned an empty response.");
    }
    else if (error != nil)
    {
        NSLog(@"Error = %@",[error description]);
    }
    
    return nil;
}

- (NSMutableArray *)parseAllTeeData:(NSData *)data
{
    NSMutableArray *tees = [[NSMutableArray alloc] initWithObjects:nil];
    
    NSString *myData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"JSON data = %@...", [myData length] > 100 ? [myData substringToIndex:100] : myData);
    NSError *error = nil;
    
    //parsing the JSON response
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (jsonObject != nil && error == nil && [jsonObject isKindOfClass:[NSArray class]])
    {
        NSLog(@"Successfully deserialized.");
        
        for(NSDictionary *tee_dict in jsonObject)
        {
            [tees addObject:[self parseSingleTee:tee_dict]];
        }
    }
    else if (jsonObject != nil && error == nil && [jsonObject isKindOfClass:[NSDictionary class]])
    {
        NSLog(@"Successfully deserialized.");
        [tees addObject:[self parseSingleTee:jsonObject]];
    }
    return tees;
}

- (Tee *)parseSingleTee:(NSDictionary *)tee_dict
{
    Tee *tee = [[Tee alloc] init];
    
    tee.id_num = [[tee_dict valueForKey:@"id"] longValue];
    tee.name = [tee_dict valueForKey:@"name"];
    tee.slope = [[tee_dict valueForKey:@"slope"] longValue];
    tee.rating = [[tee_dict valueForKey:@"rating"] doubleValue];
    tee.isMale = [[tee_dict valueForKey:@"gender"] isEqualToString:@"M"];
    
    NSDictionary *course_dict = [tee_dict objectForKey:@"course"];
    tee.course_id = [[course_dict objectForKey:@"id"] longValue];
    tee.course_name = [course_dict objectForKey:@"name"];
    
    NSArray *tee_holes_dict = [tee_dict objectForKey:@"tee_holes"];
    NSMutableArray *tee_holes = [[NSMutableArray alloc] init];
    
    for(NSDictionary *thDict in tee_holes_dict)
    {
        TeeHole *th = [[TeeHole alloc] init];
        
        th.id_num = [[thDict valueForKey:@"id"] longValue];
        th.yardage = [[thDict valueForKey:@"yardage"] longValue];
        th.par = [[thDict valueForKey:@"par"] longValue];
        th.handicap = [[thDict valueForKey:@"handicap"] longValue];
        
        NSDictionary *holeDict = [thDict objectForKey:@"hole"];
        
        Hole *h = [[Hole alloc] init];
        
        h.id_num = [[holeDict valueForKey:@"id"] longValue];
        h.number = [[holeDict valueForKey:@"number"] longValue];
        h.name = [holeDict valueForKey:@"name"];
        
        th.hole = h;
        
        [tee_holes addObject:th];
    }
    
    tee.tee_holes = tee_holes;
    return tee;
}

@end

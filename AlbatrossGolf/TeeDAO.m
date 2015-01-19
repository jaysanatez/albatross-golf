//
//  TeeDAO.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 10/19/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import "TeeDAO.h"
#import "Tee.h"
#import "TeeHole.h"
#import "Hole.h"
#import "RecentTeeChoiceVC.h"
#import "TeeChoiceVC.h"

@implementation TeeDAO

@synthesize delegate;

static NSString *baseUrl = @"http://brobin.pythonanywhere.com/v1/";

- (void)fetchTeesForCourse:(long)courseId
{
    NSString *urlString = [NSString stringWithFormat:@"course/%li/tees",courseId];
    [self submitCourseFetchRequest:urlString];
}

- (void)fetchTeesForUser:(long)userId
{
    NSString *urlString = [NSString stringWithFormat:@"user/%li/tees",userId];
    [self submitCourseFetchRequest:urlString];
}

- (void)submitCourseFetchRequest:(NSString *)urlString
{
    __block NSMutableArray *tees = [[NSMutableArray alloc] initWithObjects:nil];
    
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
                 [tees addObjectsFromArray:[self parseAllTeeData:data]];
                 [delegate refreshTeeList:tees];
             });
         }
         else if ([data length] == 0)
         {
             NSLog(@"Tee retrieval returned an empty response.");
             [delegate alertNoTeesFetched];
         }
         else if (error != nil)
         {
             NSLog(@"Error = %@",[error description]);
             [delegate alertNoTeesFetched];
         }
     }];
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
            
            [tees addObject:tee];
        }
    }
    return tees;
}

@end

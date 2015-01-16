//
//  TeeDAO.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 10/19/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import "TeeDAO.h"
#import "Tee.h"
#import "RecentTeeChoiceVC.h"
#import "TeeChoiceVC.h"

@implementation TeeDAO
{
    NSString *urlExt;
}

@synthesize delegate;

static NSString *baseUrl = @"http://brobin.pythonanywhere.com/v1/";

- (void)fetchTeesForCourse:(NSNumber *)courseId
{
    NSString *urlString = [NSString stringWithFormat:@"course/%@/tees",[courseId stringValue]];
    [self submitCourseFetchRequest:urlString];
}

- (void)fetchTeesForUser:(NSNumber *)userId
{
    NSString *urlString = [NSString stringWithFormat:@"user/%@/tees",[userId stringValue]];
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
        
        for(NSDictionary *teeDict in jsonObject)
        {
            Tee *tee = [[Tee alloc] init];
            
            tee.id_num = [teeDict objectForKey:@"id"];
            tee.name = [teeDict objectForKey:@"name"];
            tee.slope = [teeDict objectForKey:@"slope"];
            tee.rating = [teeDict objectForKey:@"rating"];
            tee.isMale = [[teeDict objectForKey:@"gender"] isEqualToString:@"M"];
            
            NSDictionary *courseDict = [teeDict objectForKey:@"course"];
            tee.course_id = [courseDict objectForKey:@"id"];
            tee.course_name = [courseDict objectForKey:@"name"];
            
            [tees addObject:tee];
        }
    }
    return tees;
}

@end

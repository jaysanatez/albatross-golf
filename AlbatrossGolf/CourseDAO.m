//
//  CourseDAO.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 9/3/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import "CourseDAO.h"
#import "AppDelegate.h"

@implementation CourseDAO
{
    NSString *urlExt, *prevPag, *nextPag;
}

static NSString *baseUrl, *apiVersion;
static NSString *searchParam = @"";
static NSString *cityParam = @"";
static NSString *stateParam = @"";

@synthesize delegate;

- (void)fetchFirstPaginatedCourses
{
    searchParam = @"";
    cityParam = @"";
    stateParam = @"";
    [self setUrlExt];
    [self submitCourseFetchRequest:urlExt];
}

- (void)fetchCoursesSearchByKeyword:(NSString *)keyword
{
    searchParam = keyword;
    cityParam = @"";
    stateParam = @"";
    [self setUrlExt];
    [self submitCourseFetchRequest:urlExt];
}

- (void)fetchCoursesSearchByCity:(NSString *)city
{
    searchParam = @"";
    cityParam = city;
    stateParam = @"";
    [self setUrlExt];
    [self submitCourseFetchRequest:urlExt];
}

- (void)fetchCoursesSearchByState:(NSString *)state
{
    searchParam = @"";
    cityParam = @"";
    stateParam = state;
    [self setUrlExt];
    [self submitCourseFetchRequest:urlExt];
}

- (void)fetchPreviousPaginatedBatch
{
    NSString *previousString = [NSString stringWithFormat:@"%@%@",urlExt,prevPag];
    [self submitCourseFetchRequest:previousString];
}

- (void)fetchNextPaginatedBatch
{
    NSString *nextString = [NSString stringWithFormat:@"%@%@",urlExt,nextPag];
    [self submitCourseFetchRequest:nextString];
}

- (void)setUrlExt
{
    urlExt = [NSString stringWithFormat:@"courses/search/?search=%@&city=%@&state=%@",searchParam,cityParam,stateParam];
}

-(void)submitCourseFetchRequest:(NSString *)urlString
{
    __block NSMutableArray *courses = [[NSMutableArray alloc] initWithObjects:nil];
    
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
                 [courses addObjectsFromArray:[self parseAllCourseData:data]];
                 [delegate refreshCourseList:courses];
                 [delegate setPrevButton:(prevPag != (id)[NSNull null]) && ([prevPag length] != 0)
                                 andNext:(nextPag != (id)[NSNull null]) && ([nextPag length] != 0)];
             });
         }
         else if ([data length] == 0)
         {
             NSLog(@"Course retrieval returned an empty response.");
             [delegate alertNoCoursesFetched];
             [delegate setPrevButton:NO andNext:NO];
         }
         else if (error != nil)
         {
             NSLog(@"Error = %@",[error description]);
             [delegate alertNoCoursesFetched];
             [delegate setPrevButton:NO andNext:NO];
         }
     }];
}

- (NSMutableArray *)parseAllCourseData:(NSData *)data
{
    NSMutableArray *courses = [[NSMutableArray alloc] initWithObjects:nil];
    
    NSString *myData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"JSON data = %@...", [myData length] > 100 ? [myData substringToIndex:100] : myData);
    NSError *error = nil;
    
    //parsing the JSON response
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (jsonObject != nil && error == nil && [jsonObject isKindOfClass:[NSDictionary class]])
    {
        NSLog(@"Successfully deserialized.");
        
        // parse that bad boy
        NSArray *info = [jsonObject objectForKey:@"courses"];
        for (NSDictionary *courseDict in info)
        {
            Course *course = [[Course alloc] init];
            
            course.id_num = [[courseDict valueForKey:@"id"] longValue];
            course.name = [courseDict valueForKey:@"name"];
            course.city = [courseDict valueForKey:@"city"];
            course.state = [courseDict valueForKey:@"state"];
            course.address = [courseDict valueForKey:@"address"];
            course.zip = [courseDict valueForKey:@"zip_code"];
            
            [courses addObject:course];
        }
        
        prevPag = [jsonObject valueForKey:@"previous"];
        nextPag = [jsonObject valueForKey:@"next"];
        
        if (prevPag != (id)[NSNull null])
        {
            prevPag = [prevPag stringByReplacingOccurrencesOfString:@"?" withString:@"&"];
        }
        
        if (nextPag != (id)[NSNull null])
        {
            nextPag = [nextPag stringByReplacingOccurrencesOfString:@"?" withString:@"&"];
        }
    }
    return courses;
}

@end

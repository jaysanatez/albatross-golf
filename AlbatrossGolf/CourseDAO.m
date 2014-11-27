//
//  CourseDAO.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 9/3/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import "CourseDAO.h"
#import "Course.h"
#import "CourseChoiceVC.h"

@implementation CourseDAO
{
    NSString *urlExt, *prevPag, *nextPag;
}

static NSString *baseUrl = @"http://api.scorecard.us/v1/";
static NSString *searchParam = @"%20";
static NSString *cityParam = @"%20";
static NSString *stateParam = @"%20";

- (void)fetchFirstPaginatedCourses:(NSObject *)delegate
{
    urlExt = @"courses";
    [self submitCourseFetchRequest:delegate urlString:urlExt];
}

- (void)fetchCoursesSearchByKeyword:(NSObject *)delegate search:(NSString *)keyword
{
    searchParam = keyword;
    cityParam = @"%20";
    stateParam = @"%20";
    urlExt = [NSString stringWithFormat:@"courses/search/%@/city/%@/state/%@",searchParam,cityParam,stateParam];
    [self submitCourseFetchRequest:delegate urlString:urlExt];
}

- (void)fetchCoursesSearchByCity:(NSObject *)delegate search:(NSString *)city
{
    searchParam = @"%20";
    cityParam = city;
    stateParam = @"%20";
    urlExt = [NSString stringWithFormat:@"courses/search/%@/city/%@/state/%@",searchParam,cityParam,stateParam];
    [self submitCourseFetchRequest:delegate urlString:urlExt];
}

- (void)fetchCoursesSearchByState:(NSObject *)delegate search:(NSString *)state
{
    searchParam = @"%20";
    cityParam = @"%20";
    stateParam = state;
    urlExt = [NSString stringWithFormat:@"courses/search/%@/city/%@/state/%@",searchParam,cityParam,stateParam];
    [self submitCourseFetchRequest:delegate urlString:urlExt];
}

- (void)fetchPreviousPaginatedBatch:(NSObject *)delegate
{
    NSString *previousString = [NSString stringWithFormat:@"%@%@",urlExt,prevPag];
    [self submitCourseFetchRequest:delegate urlString:previousString];
}

- (void)fetchNextPaginatedBatch:(NSObject *)delegate
{
    NSString *nextString = [NSString stringWithFormat:@"%@%@",urlExt,nextPag];
    [self submitCourseFetchRequest:delegate urlString:nextString];
}

-(void)submitCourseFetchRequest:(NSObject *)delegate urlString:(NSString *)urlString
{
    __block NSMutableArray *courses = [[NSMutableArray alloc] initWithObjects:nil];
    
    NSString *apiUrl = [NSString stringWithFormat:@"%@%@",baseUrl,urlString];
    NSLog(@"REQUESTED URL: %@",apiUrl);
    NSURL *url = [NSURL URLWithString:apiUrl];
    NSString *body = @"";
    NSString *token = @"78d9c1bc30a4127652ded10d5a069a063544d743";
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
                 [courses addObjectsFromArray:[self parseAllCourseData:data withDelegate:delegate]];
                 if([delegate isKindOfClass:[CourseChoice class]])
                 {
                     [(CourseChoice *)delegate refreshCourseList:courses];
                     [(CourseChoice *)delegate setPrevButton:(prevPag != (id)[NSNull null]) && ([prevPag length] != 0)
                                                     andNext:(nextPag != (id)[NSNull null]) && ([nextPag length] != 0)];
                 }
             });
         }
         else if ([data length] == 0)
         {
             NSLog(@"Course retrieval returned an empty response.");
             if([delegate isKindOfClass:[CourseChoice class]])
             {
                 [(CourseChoice *)delegate alertNoCoursesFetched];
                 [(CourseChoice *)delegate setPrevButton:NO andNext:NO];
             }
         }
         else if (error != nil)
         {
             NSLog(@"Error = %@",[error description]);
             if([delegate isKindOfClass:[CourseChoice class]])
             {
                 [(CourseChoice *)delegate alertNoCoursesFetched];
                 [(CourseChoice *)delegate setPrevButton:NO andNext:NO];
             }
         }
     }];
}

- (NSMutableArray *)parseAllCourseData:(NSData *)data withDelegate:(NSObject *)delegate
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
            
            course.id_num = [courseDict objectForKey:@"id"];
            course.name = [courseDict objectForKey:@"name"];
            course.city = [courseDict objectForKey:@"city"];
            course.state = [courseDict objectForKey:@"state"];
            course.address = [courseDict objectForKey:@"address"];
            course.zip = [courseDict objectForKey:@"zip_code"];
            
            course.courseName = course.name;
            course.courseLocation = course.city;
            
            [courses addObject:course];
        }
        prevPag = [jsonObject objectForKey:@"previous"];
        nextPag = [jsonObject objectForKey:@"next"];
        
        if([delegate isKindOfClass:[CourseChoice class]])
        {
            [(CourseChoice *)delegate setPrevButton:YES andNext:YES];
        }
    }
    return courses;
}

@end

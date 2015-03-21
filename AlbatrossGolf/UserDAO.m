//
//  UserDAO.m
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/26/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import <CoreData/CoreData.h>
#import "UserDAO.h"
#import "User.h"
#import "AppDelegate.h"

@implementation UserDAO

static NSString *baseUrl;

- (User *)createUser:(User *)newUser
{
    newUser.id_num = 2;
    return newUser;
}

- (BOOL)attemptLoginWithUsername:(NSString *)username AndPassword:(NSString *)password
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    baseUrl = delegate.baseUrl;

    NSDictionary *dict = @{ @"username":username, @"password":password };
    NSLog(@"POST: %@", dict.description);
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSString *apiUrl = [NSString stringWithFormat:@"%@%@",baseUrl,@"v1/token"];
    NSLog(@"REQUESTED URL: %@",apiUrl);
    NSURL *url = [NSURL URLWithString:apiUrl];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPBody:postData];
    
    error = nil;
    NSURLResponse *response;
    
    // the donger
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    if([data length] > 0 && error == nil)
    {
        // normal execution
        NSString *myData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"JSON data = %@...", [myData length] > 100 ? [myData substringToIndex:100] : myData);
        
        if(![myData containsString:@"token"]) return NO;
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        NSString *token = [jsonObject valueForKey:@"token"];
        [delegate setToken:token];
        
        return YES;
    }
    else if ([data length] == 0)
    {
        NSLog(@"User login returned an empty response.");
        return NO;
    }
    else if (error != nil)
    {
        NSLog(@"Error = %@",[error description]);
        return NO;
    }
    else
    {
        // something else ?
        return NO;
    }
}

- (void)fetchAndStoreUserAsActiveUser:(NSString *)username
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    baseUrl = delegate.baseUrl;
    
    NSString *apiUrl = [NSString stringWithFormat:@"%@%@",baseUrl,@"v1/user"];
    NSLog(@"REQUESTED URL: %@",apiUrl);
    NSURL *url = [NSURL URLWithString:apiUrl];
    NSString *body = @"";
    NSString *token = [delegate getToken];
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
        NSString *myData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"JSON data = %@...", [myData length] > 100 ? [myData substringToIndex:100] : myData);
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        [self storeUserAsActiveUser:[User instanceFromDictionary:jsonObject]];
        [self storeToken:token];
    }
    else if ([data length] == 0)
    {
        NSLog(@"User retrieval returned an empty response.");
    }
    else if (error != nil)
    {
        NSLog(@"Error = %@",[error description]);
    }
}

- (void)storeUserAsActiveUser:(User *)user
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    // store in CoreData
    NSManagedObjectContext *ctx = [delegate managedObjectContext];
    NSManagedObject *userObj = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:ctx];
    NSError *error;
    
    [userObj setValue:[NSNumber numberWithLong:user.id_num] forKey:@"id"];
    [userObj setValue:user.userName forKey:@"username"];
    [userObj setValue:user.firstName forKey:@"fname"];
    [userObj setValue:user.lastName forKey:@"lname"];
    [userObj setValue:user.email forKey:@"email"];
    [userObj setValue:user.password forKey:@"password"];
    [ctx save:&error];
    
    if(error)
    {
        NSLog(@"ERROR");
    }
    else
    {
        user.cdObject = userObj;
    }
    
    [delegate setActiveUser:user];
}

- (void)storeToken:(NSString *)token
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    // store in CoreData
    NSManagedObjectContext *ctx = [delegate managedObjectContext];
    NSManagedObject *tokenObj = [NSEntityDescription insertNewObjectForEntityForName:@"Token" inManagedObjectContext:ctx];
    NSError *error;
    
    [tokenObj setValue:[delegate getToken] forKey:@"token"];
    [ctx save:&error];
}

@end

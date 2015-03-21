//
//  User.h
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/18/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface User : NSObject

@property long id_num;
@property NSString *userName, *firstName, *lastName, *password, *email;
@property (nonatomic, strong) NSManagedObject *cdObject;

+ (instancetype) instanceFromManagedObject:(NSManagedObject *)object;
+ (instancetype) instanceFromDictionary:(NSDictionary *)dict;

@end

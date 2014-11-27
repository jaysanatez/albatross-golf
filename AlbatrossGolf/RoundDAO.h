//
//  RoundDAO.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 11/5/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoundDAO : NSObject

- (void)fetchAllRoundsForUser:(NSNumber *)user_id forDelegate:(NSObject *)delegate;

@end

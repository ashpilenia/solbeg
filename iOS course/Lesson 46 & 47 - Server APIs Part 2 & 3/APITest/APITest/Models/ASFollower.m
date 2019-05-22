//
//  ASFollower.m
//  APITest
//
//  Created by Alex on 5/14/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASFollower.h"

@implementation ASFollower

- (instancetype)initWithServerResponse:(NSDictionary *)response {
    
    self = [super init];
    if (self) {
        
        self.firstName = [response valueForKey:@"first_name"];
        self.lastName = [response valueForKey:@"last_name"];
        self.imageUrl = [NSURL URLWithString:[response valueForKey:@"photo_50"]];
        self.identifier = [response valueForKey:@"id"];
    }
    return self;
}

@end

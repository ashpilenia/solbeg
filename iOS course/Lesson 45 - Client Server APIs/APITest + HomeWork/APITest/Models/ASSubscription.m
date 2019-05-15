//
//  ASSubscription.m
//  APITest
//
//  Created by Alex on 5/14/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASSubscription.h"

@implementation ASSubscription

- (instancetype)initWithServerResponse:(NSDictionary *)response {
    
    self = [super init];
    if (self) {
        
        self.name = [response valueForKey:@"name"];
        self.imageUrl = [NSURL URLWithString:[response valueForKey:@"photo_50"]];
        self.identifier = [response valueForKey:@"id"];
    }
    return self;
}

@end

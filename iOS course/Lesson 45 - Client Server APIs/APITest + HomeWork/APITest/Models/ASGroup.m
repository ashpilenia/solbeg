//
//  ASGroup.m
//  APITest
//
//  Created by Alex on 5/21/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASGroup.h"

@implementation ASGroup

- (instancetype)initWithServerResponse:(NSDictionary *)response {
    
    self = [super init];
    if (self) {
        
        self.name = [response valueForKey:@"name"];
        self.photoUrl = [NSURL URLWithString:[response valueForKey:@"photo_50"]];
        self.identifier = [response valueForKey:@"id"];
    }
    return self;
}

@end

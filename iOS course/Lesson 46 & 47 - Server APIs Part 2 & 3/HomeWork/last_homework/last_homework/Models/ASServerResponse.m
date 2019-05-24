//
//  ASServerResponse.m
//  last_homework
//
//  Created by Alex on 5/24/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASServerResponse.h"

@implementation ASServerResponse

- (instancetype)initWithServerResponse:(NSDictionary *)response {
    
    self = [super init];
    if (self) {
        
        self.hashValue = [response valueForKey:@"hash"];
        self.server = [response valueForKey:@"server"];
        self.photoList = [response valueForKey:@"photos_list"];
    }
    return self;
}

@end

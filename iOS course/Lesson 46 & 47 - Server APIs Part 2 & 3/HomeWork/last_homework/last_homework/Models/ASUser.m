//
//  ASUser.m
//  last_homework
//
//  Created by Alex on 5/23/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASUser.h"

@implementation ASUser


- (instancetype)initWithServerResponse:(NSDictionary *)response {
    
    self = [super init];
    if (self) {
        
        self.firstName = [response valueForKey:@"first_name"];
        self.lastName = [response valueForKey:@"last_name"];
        self.imageUrl = [NSURL URLWithString:[response valueForKey:@"photo_50"]];
        self.identifier = [response valueForKey:@"id"];
        self.originalImageUrl = [NSURL URLWithString:[response valueForKey:@"photo_max_orig"]];
        self.sex = [self getSexFromEnum:[response valueForKey:@"sex"]];
        self.city = [response valueForKeyPath:@"city.title"];
        self.lastSeenDate = [self convertLastSeenDateInterval:[response valueForKeyPath:@"last_seen.time"]];
        
    }
    return self;
}

- (NSString *)getSexFromEnum:(NSNumber *)value {
    NSInteger intValue = [value integerValue];
    return intValue == 1 ? @"Female" : @"Male";
}

- (NSDate *)convertLastSeenDateInterval:(NSNumber *)value {
    
    NSTimeInterval interval = [value doubleValue];
    return [NSDate dateWithTimeIntervalSince1970:interval];
}

@end

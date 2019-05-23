//
//  ASPhoto.m
//  last_homework
//
//  Created by Alex on 5/23/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASPhoto.h"

@implementation ASPhoto

- (instancetype)initWithServerResponse:(NSDictionary *)response {
    
    self = [super init];
    if (self) {
        
        self.identifier = [response valueForKey:@"id"];
        self.photoURL = [self extractUrlFromSizesArray:[response valueForKey:@"sizes"]];
        self.ownerID = [response valueForKey:@"owner_id"];
    }
    return self;
}

- (NSURL *)extractUrlFromSizesArray:(NSArray *)array {
    
    NSDictionary *dict = [array lastObject];
    NSString *urlString = [dict valueForKey:@"url"];
    return [NSURL URLWithString:urlString];
    
}

@end

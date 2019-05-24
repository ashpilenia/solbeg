//
//  ASVideo.m
//  last_homework
//
//  Created by Alex on 5/24/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASVideo.h"

@implementation ASVideo

- (instancetype)initWithServerResponse:(NSDictionary *)response {
    
    self = [super init];
    if (self) {
        
        self.duration = [response valueForKey:@"duration"];
        self.identifier = [response valueForKey:@"id"];
        self.ownerID = [response valueForKey:@"owner_id"];
        self.player = [NSURL URLWithString:[response valueForKey:@"player"]];
        self.photoURL = [NSURL URLWithString:[response valueForKey:@"photo_320"]];
        self.videoTitle = [response valueForKey:@"title"];
    }
    return self;
}

@end

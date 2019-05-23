//
//  ASAlbum.m
//  last_homework
//
//  Created by Alex on 5/23/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASAlbum.h"

@implementation ASAlbum

- (instancetype)initWithServerResponse:(NSDictionary *)response {
    
    self = [super init];
    if (self) {
        
        self.name = [response valueForKey:@"title"];
        self.desc = [response valueForKey:@"description"];
        self.identifier = [response valueForKey:@"id"];
        self.canUpload = [[response valueForKey:@"can_upload"] boolValue];
        self.size = [response valueForKey:@"size"];
        self.avatarURL = [self extractUrlFromSizesArray:[response valueForKey:@"sizes"]];
        self.ownerID = [response valueForKey:@"owner_id"];
    }
    return self;
}

- (NSURL *)extractUrlFromSizesArray:(NSArray *)array {
    
    NSDictionary *dict = [array lastObject];
    NSString *urlString = [dict valueForKey:@"src"];
    return [NSURL URLWithString:urlString];
    
}

@end

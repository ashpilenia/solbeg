//
//  ASWallItem.m
//  APITest
//
//  Created by Alex on 5/17/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASWallItem.h"

@implementation ASWallItem

- (instancetype)initWithServerResponse:(NSDictionary *)response {

    self = [super init];
    if (self) {
        
        self.isRepost = NO;
        if ([[response valueForKeyPath:@"copy_history"] count]) {
            self.isRepost = YES;
            NSNumber *ownerId = [(NSArray *)[response valueForKeyPath:@"copy_history.owner_id"] firstObject];
            if ([ownerId integerValue] < 0) {
                self.isUsingGroup = YES;
                NSInteger owner = [ownerId integerValue];
                ownerId = [NSNumber numberWithInteger:owner *(-1)];
            }
        
            self.ownerId = ownerId;
        }
        
        NSArray *attachmentsArray = self.isRepost ? [response valueForKeyPath:@"copy_history.attachments"] : [response valueForKey:@"attachments"];
        if ([attachmentsArray.firstObject isKindOfClass:[NSArray class]]) {
            attachmentsArray = attachmentsArray.firstObject;
        }
        self.attachmentsArray = [self extractImagesFromAttachmentsArray:attachmentsArray];
        
        self.text = self.isRepost ? [response valueForKeyPath:@"copy_history.text"] : [response valueForKey:@"text"];
        if ([self.text isKindOfClass:[NSArray class]]) {
            self.text = [(NSArray *)self.text firstObject];
        }
        
        self.likes = [response valueForKeyPath:@"likes.count"];
        self.reposts = [response valueForKeyPath:@"reposts.count"];
        if ([response valueForKeyPath:@"views.count"]) {
            self.views = [response valueForKeyPath:@"views.count"];
        } else {
            self.views = @(0);
        }
        
        
        
    }
    return self;
    
}


- (NSArray<NSURL *>*)extractImagesFromAttachmentsArray:(NSArray *)array {
    
    NSMutableArray *imagesArray = [NSMutableArray array];
    if ([array.firstObject isKindOfClass:[NSDictionary class]]) {
        for (NSDictionary *dict in array) {
            
            if ([[dict valueForKey:@"type"] isEqualToString:@"photo"]) {
                NSArray *sizesArray = [dict valueForKeyPath:@"photo.sizes"];
                NSDictionary *sizeDict = [sizesArray lastObject];
                NSString *urlString = [sizeDict objectForKey:@"url"];
                NSURL *url = [NSURL URLWithString:urlString];
                [imagesArray addObject:url];
            }
    }
        
    }
    return imagesArray;
    
}
@end

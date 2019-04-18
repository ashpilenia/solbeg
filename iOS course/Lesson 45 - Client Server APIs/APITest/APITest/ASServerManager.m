//
//  ASServerManager.m
//  APITest
//
//  Created by Alex on 4/18/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASServerManager.h"
#import <AFNetworking.h>

@interface ASServerManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation ASServerManager

static NSString * const version = @"5.95";

+ (ASServerManager *)sharedManager {
    
    static ASServerManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ASServerManager alloc] init];
    });
    
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        NSURL *baseUrl = [NSURL URLWithString:@"https://api.vk.com/method/"];
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseUrl];
    }
    return self;
}

- (void)getFriendsWithOffset:(NSInteger)offset
                       count:(NSInteger)count
                   onSuccess:(successBlock)successBlock
                   onFailure:(failureBlock)failureBlock {
    
    NSDictionary *params = @{
                             @"user_id"      : @"11799823",
                             @"order"        : @"name",
                             @"count"        : @(count),
                             @"offset"       : @(offset),
                             @"fields"       : @"photo_50",
                             @"name_case"    : @"nom",
                             @"access_token" : [self serviceKey],
                             @"v"            : version
                             };
    
    [self.sessionManager GET:@"friends.get"
                  parameters:params
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                         NSLog(@"JSON: %@", responseObject);
                         
                         NSArray *itemsArray = [responseObject valueForKeyPath:@"response.items"];
                         if (successBlock) {
                             successBlock(itemsArray);
                         }
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         NSLog(@"Error: %@", error);
                         
                         if (failureBlock) {
                             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) task.response;
                             failureBlock(error, httpResponse.statusCode);
                         }
                     }];
}

- (NSString *)serviceKey {
    
    return @"aa6fc259aa6fc259aa6fc25928aa05d275aaa6faa6fc259f6d7432f20428dbe90f96c51";
}



@end

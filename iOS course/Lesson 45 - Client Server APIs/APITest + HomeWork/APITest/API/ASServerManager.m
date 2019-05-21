//
//  ASServerManager.m
//  APITest
//
//  Created by Alex on 4/18/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASServerManager.h"
#import <AFNetworking.h>
#import "ASUser.h"
#import "ASSubscription.h"
#import "ASFollower.h"
#import "ASWallItem.h"

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
                     success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nonnull responseObject) {
                         NSLog(@"JSON: %@", responseObject);
                         
                         NSArray *itemsArray = [responseObject valueForKeyPath:@"response.items"];
                         NSMutableArray *usersArray = [NSMutableArray array];
                         
                         for (NSDictionary *dict in itemsArray) {
                             ASUser *user = [[ASUser alloc] initWithServerResponse:dict];
                             [usersArray addObject:user];
                         }
                         
                         if (successBlock) {
                             successBlock(usersArray);
                         }
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         NSLog(@"Error: %@", error);
                         
                         if (failureBlock) {
                             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                             failureBlock(error, httpResponse.statusCode);
                         }
                     }];
}

- (void)getUserDetails:(NSNumber *)identifier
             onSuccess:(successBlock)successBlock
             onFailure:(failureBlock)failureBlock {
    
    NSDictionary *params = @{
                             @"user_id"      : identifier,
                             @"fields"       : @"photo_max_orig, sex, city, last_seen",
                             @"access_token" : [self serviceKey],
                             @"v"            : version
                             };
    
    [self.sessionManager GET:@"users.get"
                  parameters:params
                     success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nonnull responseObject) {
                         
                         NSLog(@"JSON: %@", responseObject);
                         
                         NSArray *responseArray = [responseObject objectForKey:@"response"];
                         ASUser *user = [[ASUser alloc] initWithServerResponse:responseArray.firstObject];
                         
                         if (successBlock) {
                             successBlock(@[user]);
                         }
    }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         
                         NSLog(@"Error: %@", error);
                         
                         if (failureBlock) {
                             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                             failureBlock(error, httpResponse.statusCode);
                         }
    }];
}

- (void)getSubscriptionsForId:(NSNumber *)identifier
                    onSuccess:(successBlock)successBlock
                    onFailure:(failureBlock)failureBlock {
    
    NSDictionary *params = @{
                             @"user_id" : identifier,
                             @"extended" : @"YES",
                             @"access_token" : [self serviceKey],
                             @"v"            : version
                             };
    
    [self.sessionManager GET:@"users.getSubscriptions"
                  parameters:params
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                         
                         NSLog(@"JSON: %@", responseObject);
                         NSArray *receivedSubs = [responseObject valueForKeyPath:@"response.items"];
                         
                         NSMutableArray *subsArray = [NSMutableArray array];
                         
                         for (NSDictionary *dict in receivedSubs) {
                             
                             if ([[dict valueForKey:@"type"] isEqualToString:@"page"]) {
                                 ASSubscription *sub = [[ASSubscription alloc] initWithServerResponse:dict];
                                 [subsArray addObject:sub];
                             }
                             
                         }
                         
                         if (successBlock) {
                             successBlock(subsArray);
                         }
                         
    }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

                         if (failureBlock) {
                             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                             failureBlock(error, httpResponse.statusCode);
                         }
                     }];
}

- (void)getFollowersForId:(NSNumber *)identifier
                onSuccess:(successBlock)successBlock
                onFailure:(failureBlock)failureBlock {
    
    NSDictionary *params = @{
                             @"user_id"      : identifier,
                             @"fields"       : @"photo_50",
                             @"access_token" : [self serviceKey],
                             @"v"            : version
                             };
    
    [self.sessionManager GET:@"users.getFollowers"
                  parameters:params
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                         
                         NSLog(@"%@", responseObject);
                         
                         NSArray *objects = [responseObject valueForKeyPath:@"response.items"];
                         NSMutableArray *followersArray = [NSMutableArray array];
                         
                         for (NSDictionary *dict in objects) {
                             
                             ASFollower *follower = [[ASFollower alloc] initWithServerResponse:dict];
                             [followersArray addObject:follower];
                         }
                         
                         if (successBlock) {
                             successBlock(followersArray);
                         }
    }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         
                         if (failureBlock) {
                             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                             failureBlock(error, httpResponse.statusCode);
                         }
    }];
}

- (void)loadWall:(NSNumber *)identifier
       onSuccess:(successBlock)successBlock
       onFailure:(failureBlock)failureBlock {
    
        NSDictionary *params = @{
                             @"owner_id"     : identifier,
                             @"filter"       : @"all",
                             @"extended"     : @"YES",
                             @"access_token" : [self serviceKey],
                             @"v"            : version
                             };
    
    [self.sessionManager GET:@"wall.get"
                  parameters:params
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
                         NSLog(@"%@", responseObject);
                         
                         NSMutableArray *parsedWallItems = [NSMutableArray array];
                         NSMutableArray *parsedGroups = [NSMutableArray array];
                         
                         NSArray *itemsArray = [responseObject valueForKeyPath:@"response.items"];
                         NSArray *groupsArray = [responseObject valueForKeyPath:@"response.groups"];
                         
                         for (NSDictionary *dict in groupsArray) {
                             ASGroup *group = [[ASGroup alloc] initWithServerResponse:dict];
                             [parsedGroups addObject:group];
                         }
                         
                         
                         for (NSDictionary *dict in itemsArray) {
                             ASWallItem *item = [[ASWallItem alloc] initWithServerResponse:dict];
                             if (item.isUsingGroup) {
                                 for (ASGroup *group in parsedGroups) {
                                     if ([group.identifier isEqualToNumber:item.ownerId]) {
                                         item.repostGroup = group;
                                     }
                                 }
                             }
                             [parsedWallItems addObject:item];
                         }
                             
                             
                         if (successBlock) {
                             successBlock(parsedWallItems);
                         }
    }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
                         if (failureBlock) {
                             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                             failureBlock(error, httpResponse.statusCode);
                         }
    }];
    
}

- (NSString *)serviceKey {
    
    return @"aa6fc259aa6fc259aa6fc25928aa05d275aaa6faa6fc259f6d7432f20428dbe90f96c51";
}



@end

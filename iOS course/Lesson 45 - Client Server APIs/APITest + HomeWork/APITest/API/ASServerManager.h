//
//  ASServerManager.h
//  APITest
//
//  Created by Alex on 4/18/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^successBlock)(NSArray *parsedObjects);
typedef void(^failureBlock)(NSError *error, NSInteger code);

@interface ASServerManager : NSObject

+ (ASServerManager *)sharedManager;

- (void)getFriendsWithOffset:(NSInteger)offset
                       count:(NSInteger)count
                   onSuccess:(successBlock)successBlock
                   onFailure:(failureBlock)failureBlock;

- (void)getUserDetails:(NSNumber *)identifier
             onSuccess:(successBlock)successBlock
             onFailure:(failureBlock)failureBlock;

- (void)getSubscriptionsForId:(NSNumber *)identifier
                    onSuccess:(successBlock)successBlock
                    onFailure:(failureBlock)failureBlock;

- (void)getFollowersForId:(NSNumber *)identifier
                onSuccess:(successBlock)successBlock
                onFailure:(failureBlock)failureBlock;

- (void)loadWall:(NSNumber *)identifier
       onSuccess:(successBlock)successBlock
       onFailure:(failureBlock)failureBlock;

- (NSString *)serviceKey;



@end


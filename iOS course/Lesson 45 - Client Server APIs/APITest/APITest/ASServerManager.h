//
//  ASServerManager.h
//  APITest
//
//  Created by Alex on 4/18/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^successBlock)(NSArray *friends);
typedef void(^failureBlock)(NSError *error, NSInteger code);

@interface ASServerManager : NSObject

+ (ASServerManager *)sharedManager;

- (void)getFriendsWithOffset:(NSInteger)offset
                       count:(NSInteger)count
                   onSuccess:(successBlock)successBlock
                   onFailure:(failureBlock)failureBlock;

- (NSString *)serviceKey;



@end


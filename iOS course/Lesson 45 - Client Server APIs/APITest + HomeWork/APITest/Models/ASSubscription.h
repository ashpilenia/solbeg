//
//  ASSubscription.h
//  APITest
//
//  Created by Alex on 5/14/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASSubscription : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *identifier;
@property (nonatomic, strong) NSURL *imageUrl;

- (instancetype)initWithServerResponse:(NSDictionary *)response;

@end

//
//  ASFollower.h
//  APITest
//
//  Created by Alex on 5/14/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASFollower : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSNumber *identifier;
@property (nonatomic, strong) NSURL *imageUrl;

- (instancetype)initWithServerResponse:(NSDictionary *)response;

@end


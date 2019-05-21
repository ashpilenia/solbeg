//
//  ASGroup.h
//  APITest
//
//  Created by Alex on 5/21/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASGroup : NSObject

@property (nonatomic, strong) NSNumber *identifier;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSURL *photoUrl;

- (instancetype)initWithServerResponse:(NSDictionary *)response;

@end


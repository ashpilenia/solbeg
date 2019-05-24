//
//  ASServerResponse.h
//  last_homework
//
//  Created by Alex on 5/24/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASServerResponse : NSObject

@property (nonatomic, strong) NSString *photoList;
@property (nonatomic, strong) NSString *hashValue;
@property (nonatomic, strong) NSString *server;

- (instancetype)initWithServerResponse:(NSDictionary *)response;

@end


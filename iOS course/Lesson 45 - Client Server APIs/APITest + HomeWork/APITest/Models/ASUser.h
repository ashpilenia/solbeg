//
//  ASUser.h
//  APITest
//
//  Created by Alex on 5/10/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASUser : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSURL *imageUrl;
@property (nonatomic, strong) NSNumber *identifier;
@property (nonatomic, strong) NSURL *originalImageUrl;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSDate *lastSeenDate;


- (instancetype)initWithServerResponse:(NSDictionary *)response;

@end



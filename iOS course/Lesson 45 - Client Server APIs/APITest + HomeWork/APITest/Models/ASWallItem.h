//
//  ASWallItem.h
//  APITest
//
//  Created by Alex on 5/17/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASWallItem : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSArray <NSURL *>* attachmentsArray;
@property (nonatomic, strong) NSNumber *likes;
@property (nonatomic, strong) NSNumber *reposts;
@property (nonatomic, strong) NSNumber *views;
@property (nonatomic, assign) BOOL isRepost;

- (instancetype)initWithServerResponse:(NSDictionary *)response;

@end


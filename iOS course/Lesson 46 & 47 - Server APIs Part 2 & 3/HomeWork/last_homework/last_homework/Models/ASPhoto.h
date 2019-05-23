//
//  ASPhoto.h
//  last_homework
//
//  Created by Alex on 5/23/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASPhoto : NSObject

@property (nonatomic, strong) NSURL *photoURL;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *ownerID;

- (instancetype)initWithServerResponse:(NSDictionary *)response;

@end

//
//  ASVideo.h
//  last_homework
//
//  Created by Alex on 5/24/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASVideo : NSObject

@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *ownerID;
@property (nonatomic, strong) NSURL *player;
@property (nonatomic, strong) NSURL *photoURL;
@property (nonatomic, strong) NSString *videoTitle;



- (instancetype)initWithServerResponse:(NSDictionary *)response;

@end


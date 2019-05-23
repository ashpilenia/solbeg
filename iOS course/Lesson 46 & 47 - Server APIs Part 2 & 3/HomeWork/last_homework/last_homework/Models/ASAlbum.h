//
//  ASAlbum.h
//  last_homework
//
//  Created by Alex on 5/23/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASAlbum : NSObject

@property (nonatomic, assign) BOOL canUpload;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSNumber *size;
@property (nonatomic, strong) NSURL *avatarURL;
@property (nonatomic, strong) NSString *ownerID;

- (instancetype)initWithServerResponse:(NSDictionary *)response;

@end


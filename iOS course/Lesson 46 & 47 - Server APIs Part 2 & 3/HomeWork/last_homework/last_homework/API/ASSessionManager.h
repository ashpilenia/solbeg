//
//  ASSessionManager.h
//  last_homework
//
//  Created by Alex on 5/23/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASToken.h"

typedef void(^successBlock)(NSArray *parsedObjects);
typedef void(^failureBlock)(NSError *error);

@class ASUser;
@class ASAlbum;
@class UIImage;
@class ASServerResponse;

@interface ASSessionManager : NSObject

@property (nonatomic, strong) ASUser *currentUser;

+ (instancetype)sharedManager;

- (void)authorizeUser;

- (void)getAlbumsForId:(NSString *)ownerID
             onSuccess:(successBlock)successBlock
             onFailure:(failureBlock)failureBlock;

- (void)getPhotosForAlbum:(ASAlbum *)album
                onSuccess:(successBlock)successBlock
                onFailure:(failureBlock)failureBlock;

- (void)getUploadServerForAlbumId:(NSString *)identifier
                        onSuccess:(successBlock)successBlock
                        onFailure:(failureBlock)failureBlock;

- (void)uploadImageForURL:(NSURL *)url
                withImage:(UIImage *)image
                onSuccess:(successBlock)successBlock
                onFailure:(failureBlock)failureBlock;

- (void)saveUploadedImageForServerResponse:(ASServerResponse *)response
                                   inAlbum:(NSString *)albumID
                                 onSuccess:(successBlock)successBlock
                                 onFailure:(failureBlock)failureBlock;

- (void)getVideosForId:(NSString *)ownerID
             onSuccess:(successBlock)successBlock
             onFailure:(failureBlock)failureBlock;

@end


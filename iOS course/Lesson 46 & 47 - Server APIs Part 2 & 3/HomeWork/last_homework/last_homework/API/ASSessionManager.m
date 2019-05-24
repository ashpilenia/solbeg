//
//  ASSessionManager.m
//  last_homework
//
//  Created by Alex on 5/23/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASSessionManager.h"
#import <AFNetworking.h>
#import "ASLoginController.h"

#import "ASToken.h"
#import "ASUser.h"
#import "ASAlbum.h"
#import "ASPhoto.h"
#import "ASServerResponse.h"
#import "ASVideo.h"

@interface ASSessionManager ()

@property (nonatomic, strong) ASToken *accessToken;
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation ASSessionManager

static NSString * const version = @"5.95";

+ (instancetype)sharedManager {
    
    static ASSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ASSessionManager alloc] init];
    });
    
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        NSURL *baseUrl = [NSURL URLWithString:@"https://api.vk.com/method/"];
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseUrl];
    }
    return self;
}

- (void)authorizeUser {
    
    ASLoginController *vc = [[ASLoginController alloc] initWithCompletion:^(ASToken *token) {
        
        if (token.token.length) {
            self.accessToken = token;
        }
        
        [self getUserDetails:token.userId
                   onSuccess:^(NSArray *parsedObjects) {
                       
                       self.currentUser = parsedObjects.firstObject;
                   }
                   onFailure:^(NSError *error) {
                       NSLog(@"Error getting user: %@", error);
                   }];
        
    }];
    
    UIViewController *mainVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [mainVC presentViewController:vc
                         animated:YES
                       completion:nil];
    
    
}

- (void)getUserDetails:(NSString *)identifier
             onSuccess:(successBlock)successBlock
             onFailure:(failureBlock)failureBlock {
    
    NSDictionary *params = @{
                             @"user_id"      : identifier,
                             @"fields"       : @"photo_max_orig, sex, city, last_seen",
                             @"access_token" : self.accessToken.token,
                             @"v"            : version
                             };
    
    [self.sessionManager GET:@"users.get"
                  parameters:params
                     success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nonnull responseObject) {
                         
                         NSLog(@"JSON: %@", responseObject);
                         
                         NSArray *responseArray = [responseObject objectForKey:@"response"];
                         ASUser *user = [[ASUser alloc] initWithServerResponse:responseArray.firstObject];
                         
                         if (successBlock) {
                             successBlock(@[user]);
                         }
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         
                         NSLog(@"Error: %@", error);
                         
                         if (failureBlock) {
                            
                             failureBlock(error);
                         }
                     }];
}

- (void)getAlbumsForId:(NSString *)ownerID
             onSuccess:(successBlock)successBlock
             onFailure:(failureBlock)failureBlock {
    
    NSDictionary *params = @{
                             @"owner_id"     : ownerID,
                             @"need_covers"  : @"YES",
                             @"photo_sizes"  : @"YES",
                             @"access_token" : self.accessToken.token,
                             @"v"            : version
                             };
    
    [self.sessionManager GET:@"photos.getAlbums"
                  parameters:params
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                         
                         NSLog(@"%@",responseObject);
                         
                         NSArray *itemsArray = [responseObject valueForKeyPath:@"response.items"];
                         NSMutableArray *parsedArray = [NSMutableArray array];
                         
                         for (NSDictionary *dict in itemsArray) {
                             ASAlbum *album = [[ASAlbum alloc] initWithServerResponse:dict];
                             [parsedArray addObject:album];
                         }
                         
                         if (successBlock) {
                             successBlock(parsedArray);
                         }
        
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         
                         NSLog(@"%@",error.localizedDescription);
                     }];
    
}

- (void)getPhotosForAlbum:(ASAlbum *)album
             onSuccess:(successBlock)successBlock
             onFailure:(failureBlock)failureBlock {
    
    NSDictionary *params = @{
                             @"owner_id"     : album.ownerID,
                             @"album_id"     : album.identifier,
                             //@"photo_sizes"  : @"YES",
                             @"rev"          : @"1",
                             @"access_token" : self.accessToken.token,
                             @"v"            : version
                             };
    
    [self.sessionManager GET:@"photos.get"
                  parameters:params
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                         
                         NSLog(@"%@",responseObject);
                         
                         NSArray *itemsArray = [responseObject valueForKeyPath:@"response.items"];
                         NSMutableArray *parsedArray = [NSMutableArray array];
                         
                         for (NSDictionary *dict in itemsArray) {
                             ASPhoto *album = [[ASPhoto alloc] initWithServerResponse:dict];
                             [parsedArray addObject:album];
                         }
                         
                         if (successBlock) {
                             successBlock(parsedArray);
                         }
                         
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         
                         NSLog(@"%@",error.localizedDescription);
                     }];
    
}

- (void)getUploadServerForAlbumId:(NSString *)identifier
                        onSuccess:(successBlock)successBlock
                        onFailure:(failureBlock)failureBlock {
    
    NSString *iosGroupId = @"58860049";
    NSDictionary *params = @{
                             @"group_id"     : iosGroupId,
                             @"album_id"     : identifier,
                             @"access_token" : self.accessToken.token,
                             @"v"            : version
                             };
    
    [self.sessionManager GET:@"photos.getUploadServer"
                  parameters:params
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                         
                         NSLog(@"%@",responseObject);
                         
                         NSString *urlString = [responseObject valueForKeyPath:@"response.upload_url"];
                         
                         if (successBlock) {
                             successBlock(@[urlString]);
                         }
                         
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         
                         NSLog(@"%@",error.localizedDescription);
                     }];
    
}


- (void)uploadImageForURL:(NSString *)url
                withImage:(UIImage *)image
                onSuccess:(successBlock)successBlock
                onFailure:(failureBlock)failureBlock {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [sessionManager POST:url
              parameters:nil
constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    
    NSData *data = UIImageJPEGRepresentation(image, 0.5f);
    [formData appendPartWithFileData:data name:@"file1" fileName:@"file1.png" mimeType:@"image/jpeg"];
    }
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                     
                     NSLog(@"%@", responseObject);
                     ASServerResponse *response = [[ASServerResponse alloc] initWithServerResponse:responseObject];
                     
                     if (successBlock) {
                         successBlock(@[response]);
                     }
    }
                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     
                     failureBlock(error);
    }];
    
    

}

- (void)saveUploadedImageForServerResponse:(ASServerResponse *)response
                                   inAlbum:(NSString *)albumID
                                 onSuccess:(successBlock)successBlock
                                 onFailure:(failureBlock)failureBlock {
    
    NSString *iosGroupId = @"58860049";
    NSDictionary *params = @{
                             @"group_id"     : iosGroupId,
                             @"album_id"     : albumID,
                             @"server"       : response.server,
                             @"photos_list"  : response.photoList,
                             @"hash"         : response.hashValue,
                             @"access_token" : self.accessToken.token,
                             @"v"            : version
                             };
    [self.sessionManager GET:@"photos.save"
                  parameters:params
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                         
                         NSLog(@"%@", responseObject);
                         if (successBlock) {
                             successBlock(nil);
                         }
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         
                         if (failureBlock) {
                             failureBlock(error);
                         }
                     }];
}

- (void)getVideosForId:(NSString *)ownerID
             onSuccess:(successBlock)successBlock
             onFailure:(failureBlock)failureBlock {
    
    NSDictionary *params = @{
                             @"owner_id"     : ownerID,
                             @"access_token" : self.accessToken.token,
                             @"v"            : version
                             };
    
    [self.sessionManager GET:@"video.get"
                  parameters:params
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                         
                         NSLog(@"%@",responseObject);
                         
                         NSArray *itemsArray = [responseObject valueForKeyPath:@"response.items"];
                         NSMutableArray *parsedArray = [NSMutableArray array];
                         
                         for (NSDictionary *dict in itemsArray) {
                             ASVideo *video = [[ASVideo alloc] initWithServerResponse:dict];
                             [parsedArray addObject:video];
                         }
                         
                         if (successBlock) {
                             successBlock(parsedArray);
                         }
                         
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         
                         NSLog(@"%@",error.localizedDescription);
                     }];
    
}



@end

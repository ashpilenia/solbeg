//
//  ASUserLoginController.h
//  APITest
//
//  Created by Alex on 5/22/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASAccessToken;

typedef void(^loginCompletionBlock)(ASAccessToken *token);

@interface ASUserLoginController : UIViewController

- (instancetype)initWithCompletionBlock:(loginCompletionBlock)completion;

@end


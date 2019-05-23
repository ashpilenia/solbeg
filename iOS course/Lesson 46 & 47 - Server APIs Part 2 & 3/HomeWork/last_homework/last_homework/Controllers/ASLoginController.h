//
//  ASLoginController.h
//  last_homework
//
//  Created by Alex on 5/23/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASToken.h"

typedef void(^loginCompletionBlock)(ASToken *token);

@interface ASLoginController : UIViewController

@property (nonatomic, copy) loginCompletionBlock completion;

- (instancetype)initWithCompletion:(loginCompletionBlock)completion;

@end

//
//  ASTestViewController.h
//  BugsTest
//
//  Created by Alex Shpilenia on 1/24/20.
//  Copyright © 2020 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TestBlock)(void);

@interface ASTestViewController : UIViewController

@property (nonatomic, copy) TestBlock block;

- (void)testMethod;

@end

NS_ASSUME_NONNULL_END

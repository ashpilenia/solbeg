//
//  ASBusinessman.h
//  NotificationsTest
//
//  Created by Alex on 9/20/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ASBusinessman : NSObject

@property (nonatomic, assign) CGFloat taxLevel;
@property (nonatomic, assign) CGFloat averagePrice;
@property (nonatomic, assign) CGFloat inflation;
@property (nonatomic, assign) NSInteger income;

@end

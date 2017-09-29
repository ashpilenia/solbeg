//
//  ASStudent.h
//  ThreadsHomeWork
//
//  Created by Alex on 9/28/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void(^helpingBlock)(void);

@interface ASStudent : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) double durationP;

- (void) guessAnswer:(NSInteger) intVar lowerBound:(NSInteger) low higherBound:(NSInteger) high innerBlock:(helpingBlock) block;

+ (dispatch_queue_t) getQueue;

@end

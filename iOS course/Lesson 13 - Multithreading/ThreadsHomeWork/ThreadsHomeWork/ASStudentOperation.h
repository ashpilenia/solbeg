//
//  ASStudentOperation.h
//  ThreadsHomeWork
//
//  Created by Alex on 9/29/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^helpingBlock2)(void);

@interface ASStudentOperation : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) double durationOp;


- (void) guessNumberUsingOperations:(NSInteger) intVar lowerBound:(NSInteger) low higherBound:(NSInteger) high innerBlock:(helpingBlock2) inBlock;


@end

//
//  ASStudentOperation.m
//  ThreadsHomeWork
//
//  Created by Alex on 9/29/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASStudentOperation.h"

@implementation ASStudentOperation

- (void) guessNumberUsingOperations:(NSInteger) intVar lowerBound:(NSInteger) low higherBound:(NSInteger) high innerBlock:(helpingBlock2) inBlock
{
    NSLog(@"The required number is %ld. Student %@ is starting to guess.", intVar, self.name);
    
    __block NSInteger x = 0;
    __weak ASStudentOperation *weakSelf = self;
    
    [[ASStudentOperation getOpQueue] addOperationWithBlock:^{
        
        double startTime = CACurrentMediaTime();
        while (x!= intVar)
        {
            x = arc4random_uniform(high - low) + low;
            
            if (x!= intVar)
            {
                //NSLog(@"Student %@ gives %ld answer and it is a wrong one",self.name, x);
            }
            else
            {
                //NSLog(@"Student %@ gives the right answer! %ld is the correct one! Congratulations!",self.name, x);
                double duration = CACurrentMediaTime() - startTime;
                
                weakSelf.durationOp = duration;
            }
        }
        inBlock();
    }];
    
 
    
}

+ (NSOperationQueue *) getOpQueue
{
    static NSOperationQueue *oPqueue;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        oPqueue = [[NSOperationQueue alloc] init];
    });
    return oPqueue;
}

@end

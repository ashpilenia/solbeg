//
//  ASStudent.m
//  ThreadsHomeWork
//
//  Created by Alex on 9/28/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASStudent.h"

@implementation ASStudent

- (void) guessAnswer:(NSInteger) intVar lowerBound:(NSInteger) low higherBound:(NSInteger) high innerBlock:(helpingBlock) block
{
    NSLog(@"The required number is %ld. Student %@ is starting to guess.", intVar, self.name);
    
    __block NSInteger x = 0;
    __block __weak ASStudent *weakSelf = self;
    /*
    dispatch_queue_t queue1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue1, ^{
     */
    dispatch_async([ASStudent getQueue], ^{
        
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
                
                weakSelf.durationP = duration;
            }
        }
            block();
    });
    
    
    
}

+ (dispatch_queue_t) getQueue
{
    static dispatch_once_t once;
    static dispatch_queue_t staticQueue;
    dispatch_once(&once, ^{
        staticQueue = dispatch_queue_create("threadsTest.queue", DISPATCH_QUEUE_CONCURRENT);
    });

    
    return staticQueue;
}

@end

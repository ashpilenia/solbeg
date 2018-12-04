//
//  ASObject.m
//  ASPropertiesTypeTest
//
//  Created by Alex on 8/24/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASObject.h"

@implementation ASObject

- (void) dealloc {
    NSLog (@"The object has been deallocated.");
}

- (NSString*) say {
    NSString* a = [[NSString alloc] init];
    a = @"hello";
    NSLog(@"%@",a);
return a;
}



@end

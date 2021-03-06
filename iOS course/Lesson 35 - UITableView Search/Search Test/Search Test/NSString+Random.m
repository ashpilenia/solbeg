//
//  NSString+Random.m
//  Search Test
//
//  Created by Alex on 2/7/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import "NSString+Random.h"

@implementation NSString (Random)

+ (NSString *) randomString
{
    int length = arc4random() % 11 + 5;
    
    return [self randomStringWithLength:length];
}

+ (NSString *) randomStringWithLength:(NSInteger) length
{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyz"; //ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    
    for (int i = 0; i < length; i++)
    {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random() % [letters length]]];
    }
    return randomString;
}

@end

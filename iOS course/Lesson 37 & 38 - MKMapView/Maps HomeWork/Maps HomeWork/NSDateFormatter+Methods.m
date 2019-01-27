//
//  NSDateFormatter+Methods.m
//  Maps HomeWork
//
//  Created by Alex on 1/27/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "NSDateFormatter+Methods.h"

@implementation NSDateFormatter (Methods)

+ (instancetype)uiDateFormatter {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM yyyy"];
    
    return formatter;
}

@end

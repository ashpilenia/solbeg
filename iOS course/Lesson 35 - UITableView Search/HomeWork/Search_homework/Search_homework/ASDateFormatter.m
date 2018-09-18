//
//  ASDateFormatter.m
//  Search_homework
//
//  Created by Alex on 4/27/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import "ASDateFormatter.h"

@implementation ASDateFormatter

+ (instancetype) getFormatter {

    ASDateFormatter *formatter = [[ASDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM yyyy"];
    
    return formatter;
}

+ (instancetype) cutMonthFormatter {
    
    ASDateFormatter *formatter = [[ASDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM"];
    
    return formatter;
}

@end

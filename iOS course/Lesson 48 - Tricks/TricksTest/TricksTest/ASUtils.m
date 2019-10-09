//
//  ASUtils.m
//  TricksTest
//
//  Created by Alex Shpilenia on 10/9/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASUtils.h"
#import <UIKit/UIKit.h>

NSString *fancyDateStringFromDate(NSDate *date) {
    
    static NSDateFormatter *formatter = nil;
    
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"-- dd : MM : yy --"];
    }
    
    return [formatter stringFromDate:date];
}

BOOL iPad() {
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}

BOOL iPhone() {
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
}

NSString *NSStringFromASProgrammerType(ASProgrammerType type) {
    
    switch (type) {
        case ASProgrammerTypeJunior:
            return @"Junior";
        case ASProgrammerTypeMiddle:
            return @"Middle";
        case ASProgrammerTypeSenior:
            return @"Senior";
            
        default: return nil;
    }
}

void ASLog(NSString *format, ...) {
    
#if LOGS_ENABLED
    va_list argumentList;
    va_start(argumentList, format);
    
    NSLogv(format, argumentList);
    
    va_end(argumentList);
#endif

}

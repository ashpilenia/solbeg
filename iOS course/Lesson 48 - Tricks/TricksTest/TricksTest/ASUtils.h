//
//  ASUtils.h
//  TricksTest
//
//  Created by Alex Shpilenia on 10/9/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef UTILS
#define UTILS

#define APP_SHORT_NAME @"TRICKS"

//#define PRODUCTION_BUILD
//#define LOGS_ENABLED 0
#define LOGS_NOTIFICATION_ENABLED 1

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a/255.f];

extern NSString * const ASLogNotification;
extern NSString * const ASLogNotificationTextUserInfoKey;

typedef enum {
    ASProgrammerTypeJunior,
    ASProgrammerTypeMiddle,
    ASProgrammerTypeSenior
} ASProgrammerType;

NSString *fancyDateStringFromDate(NSDate *date);

BOOL iPad(void);
BOOL iPhone(void);

NSString *NSStringFromASProgrammerType(ASProgrammerType type);

void ASLog(NSString *format, ...);

#endif

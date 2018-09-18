//
//  ASDateFormatter.h
//  Search_homework
//
//  Created by Alex on 4/27/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASDateFormatter : NSDateFormatter

+ (instancetype) getFormatter;
+ (instancetype) cutMonthFormatter;

@end

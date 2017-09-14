//
//  ASStudent.m
//  DictionaryTest
//
//  Created by Alex on 9/13/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASStudent.h"

@implementation ASStudent

- (NSComparisonResult) compare: (NSString*) newObj
{
    return [_name compare:newObj];
}

@end

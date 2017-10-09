//
//  ASStudent.m
//  NSDateHomeWork
//
//  Created by Alex on 10/5/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASStudent.h"

@implementation ASStudent


- (instancetype) initWithAlias:(NSString *) objName
{
    self = [super init];
    if (self)
    {
        self.alias = objName;
    }
    return self;
}



@end

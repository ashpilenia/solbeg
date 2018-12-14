//
//  UIButton+Extension.m
//  ASCalculator
//
//  Created by Alex on 12/4/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        self.backgroundColor = [UIColor lightTextColor];
    } else {
        self.backgroundColor = [UIColor darkTextColor];
    }
}

@end

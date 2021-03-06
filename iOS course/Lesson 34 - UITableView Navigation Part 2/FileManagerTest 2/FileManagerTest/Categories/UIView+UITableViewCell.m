//
//  UIView+UITableViewCell.m
//  FileManagerTest
//
//  Created by Alex on 11/20/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "UIView+UITableViewCell.h"

@implementation UIView (UITableViewCell)

- (UITableViewCell *) superCell
{
    if (!self.superview)
    {
        return nil;
    }
    
    if ([self.superview isKindOfClass:[UITableViewCell class]])
    {
        return (UITableViewCell *)self.superview;
    }
    
    return [self.superview superCell];
        
}

@end

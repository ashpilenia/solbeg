//
//  UIView+TableViewFindCell.m
//  Navigation_Homework
//
//  Created by Alex on 1/31/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import "UIView+TableViewFindCell.h"

@implementation UIView (TableViewFindCell)

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

//
//  ASUserDetailCell.m
//  CoreData HomeWork
//
//  Created by Alex on 4/30/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASUserDetailCell.h"

@implementation ASUserDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)reuseIdentifier {
    return @"userCellId";
}

@end

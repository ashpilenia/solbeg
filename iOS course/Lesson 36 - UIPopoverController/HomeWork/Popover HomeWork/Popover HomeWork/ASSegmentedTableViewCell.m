//
//  ASSegmentedTableViewCell.m
//  Popover HomeWork
//
//  Created by Alex on 1/5/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASSegmentedTableViewCell.h"

@implementation ASSegmentedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)reuseIdentifier {
    
    return @"segmentedCellId";
}

@end

//
//  ASWallGroupCell.m
//  APITest
//
//  Created by Alex on 5/22/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASWallGroupCell.h"

@implementation ASWallGroupCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)reuseIdentifier {
    return @"groupCellReuseId";
}

@end

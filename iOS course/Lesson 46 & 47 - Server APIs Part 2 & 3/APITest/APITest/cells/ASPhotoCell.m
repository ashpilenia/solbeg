//
//  ASPhotoCell.m
//  APITest
//
//  Created by Alex on 5/10/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASPhotoCell.h"

@implementation ASPhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)reuseIdentifier {
    return @"photoCellReuseId";
}

+ (CGFloat)cellHeight {
    return 300.f;
}

@end

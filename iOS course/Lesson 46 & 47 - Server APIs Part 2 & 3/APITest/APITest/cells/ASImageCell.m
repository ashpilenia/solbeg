//
//  ASImageCell.m
//  APITest
//
//  Created by Alex on 5/17/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASImageCell.h"

@implementation ASImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (NSString *)reuseIdentifier {
    return @"imageCellReuseId";
}

+ (CGFloat)cellHeight {
    return 300.f;
}

@end

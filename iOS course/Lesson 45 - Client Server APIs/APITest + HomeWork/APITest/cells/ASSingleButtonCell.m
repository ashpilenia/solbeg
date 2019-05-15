//
//  ASSingleButtonCell.m
//  APITest
//
//  Created by Alex on 5/10/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASSingleButtonCell.h"

@implementation ASSingleButtonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (NSString *)reuseIdentifier {
    return @"oneButtonsCellReuseId";
}

- (IBAction)wallAction:(UIButton *)sender {
    
    if (self.wallBlock) {
        self.wallBlock();
    }
}

@end

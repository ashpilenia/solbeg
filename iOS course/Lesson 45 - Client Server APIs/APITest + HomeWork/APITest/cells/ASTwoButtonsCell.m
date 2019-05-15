//
//  ASTwoButtonsCell.m
//  APITest
//
//  Created by Alex on 5/10/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASTwoButtonsCell.h"

@implementation ASTwoButtonsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (NSString *)reuseIdentifier {
    return @"twoButtonsCellReuseId";
}

- (IBAction)subscriptionsAction:(UIButton *)sender {
    
    if (self.subsctibersBlock) {
        self.subsctibersBlock();
    }
}

- (IBAction)followersAction:(UIButton *)sender {
    
    if (self.followersBlock) {
        self.followersBlock();
    }
}

@end

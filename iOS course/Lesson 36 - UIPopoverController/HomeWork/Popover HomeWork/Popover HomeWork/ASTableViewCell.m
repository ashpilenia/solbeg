//
//  ASTableViewCell.m
//  Popover HomeWork
//
//  Created by Alex on 1/5/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASTableViewCell.h"

@implementation ASTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.textField.delegate = self;
    
    if (self.isEducationCell) {
        self.textField.returnKeyType = UIReturnKeyDone;
    } else {
        self.textField.returnKeyType = UIReturnKeyNext;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)reuseIdentifier {
    
    return @"cellId";
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (self.isEducationCell) {
        
        if (self.educationBlock) {
            self.educationBlock();
        }
        return NO;
    } else if (self.isBirthDateCell) {
        
        if (self.birthDateBlock) {
            self.birthDateBlock();
        }
        return NO;
    } else {
        return YES;
    }
}



@end

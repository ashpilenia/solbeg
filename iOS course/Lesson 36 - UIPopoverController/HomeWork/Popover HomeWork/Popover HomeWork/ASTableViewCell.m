//
//  ASTableViewCell.m
//  Popover HomeWork
//
//  Created by Alex on 1/5/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASTableViewCell.h"

 NSString * const changeRespondernNotification = @"kChangeRespondernNotification";

@implementation ASTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notifciationReceivedAction:) name:changeRespondernNotification object:nil];
    
    self.textField.delegate = self;
    self.textField.returnKeyType = UIReturnKeyNext;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)reuseIdentifier {
    
    return @"cellId";
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (self.isLastNameCell) {
        self.textField.returnKeyType = UIReturnKeyDone;
    }
    
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField.returnKeyType == UIReturnKeyNext) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:(changeRespondernNotification) object:nil];
    }
    
    if (self.isLastNameCell) {
        
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - Notifications

- (void)notifciationReceivedAction:(NSNotification *)notification {
    
    if (self.isLastNameCell) {
        [self.textField becomeFirstResponder];
    }
}



@end

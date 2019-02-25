//
//  TextViewCell.m
//  KVCHomeWork
//
//  Created by Alex on 2/23/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "TextViewCell.h"

@interface TextViewCell () <UITextFieldDelegate>

@end

@implementation TextViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.textView.delegate = self;
    
    [self addObserver:self forKeyPath:@"isLastNameCell" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    
    [self removeObserver:self forKeyPath:@"isLastNameCell"];
}

- (IBAction)textEditingEnded:(UITextField *)sender {
    
    if (self.isLastNameCell) {
        self.student.lastName = self.textView.text;
    } else {
        self.student.name = self.textView.text;
    }
}

+ (NSString *)reuseIdentifier {
    
    return @"textCellReuseId";
}

#pragma mark - KVC/KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"isLastNameCell"]) {
        [self setTextLabel];
    }
}

- (void)setTextLabel {
    
    self.textLabel.text = self.isLastNameCell ? @"Last Name:" : @"Name:";
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField endEditing:YES];
    
    return YES;
}

@end

//
//  ASTableViewCell.h
//  Popover HomeWork
//
//  Created by Alex on 1/5/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (nonatomic, assign) BOOL isEducationCell;
@property (nonatomic, assign) BOOL isBirthDateCell;
@property (nonatomic, copy) void (^educationBlock)(void);
@property (nonatomic, copy) void (^birthDateBlock)(void);


+ (NSString *)reuseIdentifier;

@end

NS_ASSUME_NONNULL_END

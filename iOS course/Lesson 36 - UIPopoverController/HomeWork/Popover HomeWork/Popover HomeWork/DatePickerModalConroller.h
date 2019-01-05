//
//  DatePickerModalConroller.h
//  Popover HomeWork
//
//  Created by Alex on 1/6/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DatePickerModalConroller : UIViewController

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIView *doneView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (nonatomic, weak) ViewController *delegate;
@property (nonatomic, strong) NSDate *passedDate;

@end

NS_ASSUME_NONNULL_END

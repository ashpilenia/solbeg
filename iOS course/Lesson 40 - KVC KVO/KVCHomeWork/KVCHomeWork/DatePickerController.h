//
//  DatePickerController.h
//  KVCHomeWork
//
//  Created by Alex on 2/22/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"


@interface DatePickerController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)saveAction:(UIButton *)sender;
- (IBAction)cancelAction:(UIButton *)sender;

@property (weak, nonatomic) ViewController *delegate;

@end


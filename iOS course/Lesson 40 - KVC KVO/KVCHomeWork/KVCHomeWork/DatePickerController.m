//
//  DatePickerController.m
//  KVCHomeWork
//
//  Created by Alex on 2/22/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "DatePickerController.h"

typedef void(^voidBlcok)(void);

@interface DatePickerController ()

@end

@implementation DatePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.saveButton.tintColor = [UIColor whiteColor];
    self.cancelButton.tintColor = [UIColor whiteColor];
    self.saveButton.backgroundColor = [UIColor blackColor];
    self.cancelButton.backgroundColor = [UIColor blackColor];
    self.saveButton.layer.borderWidth = 1.5;
    self.cancelButton.layer.borderWidth = 1.5;
    self.saveButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.cancelButton.layer.borderColor = [UIColor grayColor].CGColor;
    [self.saveButton setTitle:@"SAVE" forState:UIControlStateNormal];
    [self.cancelButton setTitle:@"CANCEL" forState:UIControlStateNormal];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.datePicker.date = self.delegate.student.birthDate;
    self.delegate.view.alpha = 0.45f;
    
}

#pragma mark - Private Methods

- (void)applyAnimation:(UIButton *)button andCompletion:(voidBlcok)completion {
    
    button.backgroundColor = [UIColor lightGrayColor];
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [UIView animateWithDuration:0.3f animations:^{
        
        button.backgroundColor = [UIColor blackColor];
        button.layer.borderColor = [UIColor grayColor].CGColor;
        
    } completion:^(BOOL finished) {
        
        completion();
    }];
    
}


- (IBAction)saveAction:(UIButton *)sender {
    
    voidBlcok completionBlock = ^{
        
        self.delegate.student.birthDate = self.datePicker.date;
        [self.delegate.tableView reloadData];
        self.delegate.view.alpha = 1.f;
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    [self applyAnimation:sender andCompletion:completionBlock];
    
}

- (IBAction)cancelAction:(UIButton *)sender {
    
    voidBlcok completionBlock = ^{
        
        self.delegate.view.alpha = 1.f;
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    [self applyAnimation:sender andCompletion:completionBlock];
}




@end

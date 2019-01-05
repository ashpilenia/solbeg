//
//  DatePickerModalConroller.m
//  Popover HomeWork
//
//  Created by Alex on 1/6/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "DatePickerModalConroller.h"

@interface DatePickerModalConroller ()

@property (nonatomic, assign) BOOL isBackPressed;
@property (nonatomic, assign) BOOL isDonePressed;

@end

@implementation DatePickerModalConroller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainView.layer.cornerRadius = 60;
    self.mainView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.mainView.layer.borderWidth = 5.f;
    self.doneView.layer.cornerRadius = 30;
    self.backView.layer.cornerRadius = 30;
    
    if (self.passedDate) {
        self.datePicker.date = self.passedDate;
    }
    
}

- (void)backAction {
    
    self.delegate.view.alpha = 1.f;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)doneAction {
    
    self.delegate.view.alpha = 1.f;
    [self.delegate didFinishPickingData:self.datePicker.date];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint point  = [touch locationInView:self.view];
    BOOL isInsideBackButton = CGRectContainsPoint(self.backView.frame, point);
    BOOL isInsideDoneButton = CGRectContainsPoint(self.doneView.frame, point);
    
    if (isInsideBackButton) {
        
        [UIView animateWithDuration:0.1f animations:^{
            self.backView.backgroundColor = [UIColor lightGrayColor];
            self.backView.layer.borderWidth = 3.f;
            self.backView.layer.borderColor = [[UIColor whiteColor] CGColor];
        }];
        
        self.isBackPressed = YES;
    }
    
    if (isInsideDoneButton) {
        
        [UIView animateWithDuration:0.1f animations:^{
            self.doneView.backgroundColor = [UIColor lightGrayColor];
            self.doneView.layer.borderWidth = 3.f;
            self.doneView.layer.borderColor = [[UIColor whiteColor] CGColor];
        }];
        
        self.isDonePressed = YES;
    }
    
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (self.isBackPressed) {
        
        [UIView animateWithDuration:0.3f animations:^{
            self.backView.backgroundColor = [UIColor blackColor];
            self.backView.layer.borderWidth = 0;
            self.isBackPressed = NO;
        } completion:^(BOOL finished) {
            [self backAction];
        }];
        
    }
    
    if (self.isDonePressed) {
        
        [UIView animateWithDuration:0.3f animations:^{
            self.doneView.backgroundColor = [UIColor blackColor];
            self.doneView.layer.borderWidth = 0;
            self.isDonePressed = NO;
        } completion:^(BOOL finished) {
            [self doneAction];
        }];
    }
    
}

- (void)dealloc {
    NSLog(@"DatePicker controller is deallocated");
}
@end

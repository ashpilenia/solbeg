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

- (void)dealloc {
    NSLog(@"DatePicker controller is deallocated");
}

#pragma mark - Actions

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
        
        [self applyAnimations:self.backView];
        self.isBackPressed = YES;
    }
    
    if (isInsideDoneButton) {
        
        [self applyAnimations:self.doneView];
        self.isDonePressed = YES;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (self.isBackPressed) {
        
        self.isBackPressed = NO;
        [self revertAnimations:self.backView];
    }
    
    if (self.isDonePressed) {
        
        self.isDonePressed = NO;
        [self revertAnimations:self.doneView];
    }
    
}

- (void)applyAnimations:(UIView *)view {
    
    [UIView animateWithDuration:0.1f animations:^{
        view.backgroundColor = [UIColor lightGrayColor];
        view.layer.borderWidth = 3.f;
        view.layer.borderColor = [[UIColor whiteColor] CGColor];
    }];
}

- (void)revertAnimations:(UIView *)view {
    
    [UIView animateWithDuration:0.3f animations:^{
        view.backgroundColor = [UIColor blackColor];
        view.layer.borderWidth = 0;
        
    } completion:^(BOOL finished) {
        
        if ([view isEqual:self.backView]) {
            [self backAction];
        } else {
            [self doneAction];
        }
    }];
}

@end

//
//  ViewController.m
//  TextFieldTest
//
//  Created by Alex on 12/16/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.firstNameField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    self.lastNameField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    
    self.firstNameField.returnKeyType = UIReturnKeyNext;
    self.lastNameField.returnKeyType = UIReturnKeyDone;
    
    self.firstNameField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.lastNameField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    self.firstNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.lastNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.firstNameField.delegate = self;
    self.lastNameField.delegate = self;
    
    [self.firstNameField becomeFirstResponder];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(notificationTextDidBeginEditing:)
               name:UITextFieldTextDidBeginEditingNotification
             object:nil];
    
    [nc addObserver:self
           selector:@selector(notificationTextDidEndEditing:)
               name:UITextFieldTextDidEndEditingNotification
             object:nil];
    
    [nc addObserver:self
           selector:@selector(notificationTextDidChange:)
               name:UITextFieldTextDidChangeNotification
             object:nil];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Actions

- (IBAction)logAction:(UIButton *)sender {
    
    NSLog(@"First Name = %@\nLast Name = %@", self.firstNameField.text, self.lastNameField.text);
    if (self.firstNameField.isFirstResponder)
    {
        [self.firstNameField resignFirstResponder];
    }
    else if (self.lastNameField.isFirstResponder)
    {
        [self.lastNameField resignFirstResponder];
    }
}

- (IBAction)axtionTextChanged:(UITextField *)sender {
    
    NSLog(@"%@", sender.text);
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:self.firstNameField])
    {
        [self.lastNameField becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - Notifications

- (void)notificationTextDidBeginEditing:(NSNotification *)notificaiton
{
    NSLog(@"Text Begin Editing From Notificaiton");
}

- (void)notificationTextDidEndEditing:(NSNotification *)notificaiton
{
    NSLog(@"Text End Editing From Notificaiton");
}

- (void)notificationTextDidChange:(NSNotification *)notificaiton
{
    NSLog(@"Text Change From Notificaiton");
}


@end
